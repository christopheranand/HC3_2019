-- copy this code into macoutreach.rocks and make a state diagram

import Array

init = { time = 0
       , state = Waiting 0
       , skimLevel = 0
       , line = 0
       , past = [firstLine] }

type State = Waiting Float -- time to wait until we show instructions
           | MoveDownOne Float -- time we first detected move down

           | MoveUpOne Float -- time we first detected move up

           | MaybeStartSkimming Float State -- waiting for delay to start skimming
           | Skimming Int Int -- level, line
           | SkimInOne Int Int -- level, line, prevents multiple moves in
           | SkimOutOne Int Int -- level, line, prevents multiple moves out

type Displayable = Line Int String
                 | Animation AnimationSize
                 | MCQ String (List String)
                 | Quote (String,String) String -- (author,reference) text

type AnimationSize = FullScreen (Float,Float) -- aspect ration

myShapes model =
  ( case model.state of
      Skimming level line -> displaySkim model level line
      SkimInOne level line -> displaySkim model level line
      SkimOutOne level line -> displaySkim model level line
      MaybeStartSkimming startTime oldState ->
        ( case oldState of
            Waiting _ -> []
            otherwise ->
              myShapes { model | state = oldState }
        )
        ++
          [text "Hold <- -> to start skimming." |> centered |> filled green |> move (0,12)
          , rect (10 * (jumpInTime - model.time + startTime)) 10 |> filled green]
      otherwise ->
        List.map2 displayLine [-30,-20,-10,0,10,20,30,40,50] model.past
        ++ (case model.state of
              Waiting until ->
                if model.time > until then
                  [text "Tap or hold up/down arrows" |> centered |> filled green |> move (0,12)
                  ,text "to advance through slides." |> centered |> filled green]
                else
                  []
              _ -> []
           )
  ) ++ [Debug.toString model.state |> text |> centered |> size 4 |> filled red |> move (0,-59)]


displayLine offset (indent,line) =
  text line |> size 6 |> filled black
    |> move (5 * (toFloat indent) - 80, 1*offset)

displaySkim model level line =
  List.map2 displayLine
            [-30,-20,-10,0,10,20,30,40,50]
            <| List.concat
                [ List.reverse <| findLines level (line+1) ( 1) 5
                , findLines level line     (-1) 5
                ]

-- nor do we need any new messages
type Msg = Tick Float GetKeyState

-- time to wait before surfing
takeoffTime = 1
-- time to wait before showing instructions
waitForInstructions = 10
--time to wait before entering overview mode
jumpInTime = 2

-- the update function records the time (in case we want animations)
update msg model =
  case msg of
    Tick t (_,(deltaLevel,deltaLine),_)
      -> if deltaLevel /= 0 then
           -- here we handle changes in levels
           if deltaLevel < 0 then
             case model.state of
              MaybeStartSkimming startT oldState ->
                 if t > startT + jumpInTime then
                   { model | time = t
                           , state = Skimming 0 model.line
                           }
                 else
                   { model | time = t }
              Skimming level line ->
                { model | time = t, state = SkimOutOne (level-1) line }
              SkimInOne level line ->
                { model | time = t, state = SkimOutOne (level-1) line }
              SkimOutOne _ _ -> { model | time = t }
              otherState ->
                { model | time = t, state = MaybeStartSkimming t model.state }
           else
             case model.state of
              MaybeStartSkimming startT oldState ->
                 if t > startT + jumpInTime then
                   { model | time = t
                           , state = Skimming (maxLevel - 1) model.line
                           }
                 else
                   { model | time = t }
              Skimming level line ->
                { model | time = t, state = SkimInOne (level+1) line }
              SkimOutOne level line ->
                { model | time = t, state = SkimInOne (level+1) line }
              SkimInOne _ _ -> { model | time = t }
              otherState ->
                { model | time = t, state = MaybeStartSkimming t model.state }
         else
           -- here we can assume there are no changes in levels
           case model.state of
             MaybeStartSkimming startT oldState ->
               -- stopped holding left/right arrow, go back to normal states
               { model | time = t, state = oldState }
             Waiting _ -> if deltaLine < 0 then
                            { model | time = t
                                    , state = MoveDownOne t
                                    , line = model.line + 1
                                    , past = getNext (model.line + 1) model.past
                                    }
                          else
                            { model | time = t }
             MoveDownOne startTime ->
               { model | time = t
                       , state = if deltaLine < 0 then
                                     model.state
                                 else
                                   Waiting <| t + waitForInstructions
                       }

             MoveUpOne startTime ->
               { model | time = t
                       , state = if deltaLine > 0 then
                                     model.state
                                 else
                                   Waiting <| t + waitForInstructions
                       }

             Skimming level line ->
               { model | time = t
                       , state = Skimming level (moveLine level deltaLine line)
                       }
             SkimInOne level line ->
               { model | time = t
                       , state = Skimming level (moveLine level deltaLine line)
                       }
             SkimOutOne level line ->
               { model | time = t
                       , state = Skimming level (moveLine level deltaLine line)
                       }


getNext idx prev =
  case Array.get idx bullets of
    Just l -> l :: prev
    Nothing -> prev

bulletList = String.lines source
  |> List.map (spaces2indent 0)
bullets = bulletList
  |> Array.fromList

firstLine = case Array.get 0 bullets of
              Nothing -> (0,"~~~ end ~~~")
              Just l -> l

spaces2indent indent line =
  if String.startsWith "  " line then
    if String.startsWith "  - " line then
      (indent+1, String.trim <| String.dropLeft 4 line)
    else
      spaces2indent (indent+1) <| String.dropLeft 2 line
  else
    (indent, String.trim line)

maxLevel = case List.maximum <| List.map Tuple.first bulletList of
             Just lvl -> lvl
             Nothing -> 0

moveLine level deltaLine line =
  if deltaLine /= 0 then
    moveLineHelper level (round deltaLine) line
  else
    line

moveLineHelper level deltaLine line =
  case Array.get (line+deltaLine) bullets of
    Nothing -> line -- this should only happen if we fall off the end of the list
    Just (indent,_) ->
      if indent <= level then
        line+deltaLine
      else
        moveLineHelper level deltaLine (line+deltaLine)

findLines level line dir left =
  if left > 0 then
    case Array.get line bullets of
      Nothing -> (0,"") :: (findLines level (line+dir) dir (left-1))
      Just (indent,str) ->
        if indent <= level then
          (indent,str) :: (findLines level (line+dir) dir (left-1))
        else
          findLines level (line+dir) dir left
  else
    []

source = """
Section 0
  - Bullet 0.0
  - Bullet 0.1
  - Bullet 0.2
  - Bullet 0.3
  - Bullet 0.4
  - Bullet 0.5
Section 1
  - Bullet 1.0
  - Bullet 1.1
  - Bullet 1.2
Section 2
  - Bullet 2.0
  - Bullet 2.1
  - Bullet 2.2
  - Bullet 2.3
  - Bullet 2.4
  - Bullet 2.5
Section 3
  - Bullet 3.0
  - Bullet 3.1
  - Bullet 3.2
  - Bullet 3.3
  - Bullet 3.4
Section 4
  - Bullet 4.0
  - Bullet 4.1
  - Bullet 4.2
Section 5
  - Bullet 5.0
  - Bullet 5.1
  - Bullet 5.2
  - Bullet 5.3
  - Bullet 5.4
  - Bullet 5.5
Section 6
  - Bullet 6.0
  - Bullet 6.1
  - Bullet 6.2
  - Bullet 6.3
Section 7
  - Bullet 7.0
  - Bullet 7.1
  - Bullet 7.2
  - Bullet 7.3
  - Bullet 7.4
  - Bullet 7.5
Section 8
  - Bullet 8.0
  - Bullet 8.1
  - Bullet 8.2
  - Bullet 8.3
Section 9
  - Bullet 9.0
  - Bullet 9.1
  - Bullet 9.2
  - Bullet 9.3
Section 10
  - Bullet 10.0
  - Bullet 10.1
  - Bullet 10.2
  - Bullet 10.3
  - Bullet 10.4
  - Bullet 10.5
Section 11
  - Bullet 11.0
  - Bullet 11.1
  - Bullet 11.2
  - Bullet 11.3
  - Bullet 11.4
  - Bullet 11.5
Section 12
  - Bullet 12.0
  - Bullet 12.1
  - Bullet 12.2
  - Bullet 12.3
  - Bullet 12.4
  - Bullet 12.5
"""
