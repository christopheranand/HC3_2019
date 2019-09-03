-- paste this code into a game slot at https://macoutreach.rocks
{-
Your assignment, if you choose to accept it, is to add a "Clear" button
to turn off the light timer.  To do that add a
  "|> notifyTap Clear"
to an appropriate button-like shape.  For full marks, make the button
grey when there is no timing to clear.

When you are finished, submit the assignment by typing
  Please submit to the hall of fame.
in the chat pane (lower right).  When asked for the title, give
<yourStudentNumber>,1
as the title.  And confirm it.
It will not really go into the Hall of Fame, but you will get a mark on Avenue.
-}
myShapes model =
  [ wedge 40 0.01
      |> filled black
      |> rotate (pi + model.startTime - model.time)
  , circle 40
      |> filled (rgba 0 0 0 0.5)
      |> notifyTapAt TapClockAt
  , rect 3 40 |> filled black |> move (50,0)
  , circle 5 |> filled lightGrey |> move (50,20)

  , text (Debug.toString model.state) |> size 4 |> centered |> filled red |> move (0,-60)
  ]
  ++
    case model.state of
        NotSet ->
            [ text "Tap on clock to set start time."
                |> centered
                |> filled blue
                |> move (0,50)
            ]
        SetStart start ->
            [ text "Tap on clock to set stop time."
                |> centered
                |> filled blue
                |> move (0,50)
            ]

        Set start end ->
            [ text "Away we go!"
                |> centered
                |> filled blue
                |> move (0,50)
            , let
                tRaw = model.time - model.startTime
                t = tRaw - toFloat (floor (tRaw / (2*pi))) * 2 * pi
              in
                if start < end then
                  if t > start && t < end then
                    circle 5 |> filled yellow |> move (50,20)
                  else
                    group []
                else
                  if t > start || t < end then
                    circle 5 |> filled yellow |> move (50,20)
                  else
                    group []
            , let
                (delta,twist) =
                  if start < end then
                    ( (end - start) / (2*pi)
                    , pi - (start + end) * 0.5
                    )
                  else
                    ( (2*pi + end - start) / (2*pi)
                    , -(start+end) * 0.5
                    )
              in
                wedge 40 delta
                  |> filled (rgb 0 255 0)
                  |> rotate twist
            ]


type Msg = Tick Float GetKeyState
         | TapClockAt (Float,Float)
         | Clear

type State = NotSet
           | SetStart Float
           | Set Float Float -- start and end times in hours

update msg model =
    case msg of
        Tick t _ ->
            { model | time = t }
        TapClockAt (x,y) ->
            case model.state of
                NotSet ->
                  if abs x + abs y > 0.1 then
                    let
                      angle = atan2 y x
                    in
                      { model | state = SetStart (pi - angle) }
                  else
                    model
                SetStart start ->
                  if abs x + abs y > 0.1 then
                    let
                      angle = atan2 y x
                    in
                      { model | state = Set start (pi - angle)
                              , startTime = model.time
                              }
                  else
                    model
                otherwise ->
                    model
        Clear ->
            { model | state = NotSet }

type alias Model =
    { time : Float
    , startTime : Float
    , state : State
    }

init : Model
init = { time = 0
       , startTime = 0
       , state = NotSet
       }
