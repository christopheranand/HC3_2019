{- Run this from the main WordGameSandbox directory, so it can import the Wrd1515444549915349 file. -}


module Main exposing (..)

import GraphicSVG exposing(..)
import GraphicSVG.EllieApp exposing (..)
import Array


--import the words from the file

import Random
import WrdFromElmJr2019May15

words = WrdFromElmJr2019May15.words


type Msg
    = Tick Float GetKeyState -- basic type needed, this gets sent to your update 30 times per second
    | GetNewPicture -- message from the button telling the program to find a new random number
    | NewImage (Int,Int) -- the random number generator returns with a new image
    | Door Int
    | SwitchOrNotSwitch Bool

--Generates a random number between 0 and the length of the word list


generateRandom = Random.generate NewImage <|
  Random.pair
    (Random.int 0 (List.length words - 1))
    (Random.int 0 1)

main : EllieAppWithTick () Model Msg
main =
    ellieAppWithTick Tick
        { init = \ _ -> (init  -- this is the initial state, like you are used to
                                    -- this requests the first random number
                                    , generateRandom)
        , update = update
        , view = \ model -> { title = "Monty Hall Simulator", body = view model }
        , subscriptions = \_ -> Sub.none
        }

type Strategy = Switch | DoNotSwitch

-- starting model is blank and contains time, the current shape and the current word

type alias Model =
  { time : Float
  , shape : { time : Float } -> List (Shape Msg)
  , zeroOrOne : Int
  , word : String
  , winningDoor : Int
  , strategy : Strategy
  , wins : Int
  , losses : Int
  , state : State
  }

model0 : Model
model0 =
    { time = 0
    , shape = \t -> []
    , zeroOrOne = 0
    , word = ""
    , winningDoor = 0
    , strategy = DoNotSwitch
    , wins = 0
    , losses = 0
    , state = WaitingFirstPick
    }

type State = WaitingFirstPick
           | SwitchOrNot Int -- they picked
                         Int -- we Revealed
                         Curtain -- state of revealed curtain
           | Revealed Int Int Bool Curtain -- state of their final choice

type Curtain = Open
             | Opening Float
             | Closed

--initialize with the blank model and a command to get a starting picture

init : Model
init =  model0

wordArray =
    -- convert list to array so we can index it
    Array.fromList words

sadShape =
  \t -> [ circle 12 |> filled (rgb 255 0 255)
        , circle 2 |> filled black |> move (5,5)
        , circle 2 |> filled black |> move (-5,5)
        , wedge 6 0.5 |> filled red |> rotate (degrees 90) |> move (0,-6)
        ]

updateCurtain curtain =
  case curtain of
    Open -> Open
    Closed -> Closed
    Opening fraction -> if fraction < 0.04
                        then Open
                        else Opening (fraction - 0.04)

otherWrongOne a b =
  if a == 0 && b == 1 || a ==1 && b == 0
    then 2
    else
      if a == 1 && b == 2 || a == 2 && b == 1
        then 0
        else 1

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick t _ ->
            ( { model | time = t
                      , state = case model.state of
                          WaitingFirstPick ->
                              WaitingFirstPick

                          SwitchOrNot pick revealing curtain ->
                              SwitchOrNot pick revealing (updateCurtain curtain)

                          Revealed pick revealed switchOrNot curtain ->
                              Revealed pick revealed switchOrNot (updateCurtain curtain)
                      }
            , Cmd.none )

        Door door -> ( case model.state of
                          WaitingFirstPick -> if door == model.winningDoor
                                              then
                                                let
                                                    revealing = (modBy 3 (door + 1 + model.zeroOrOne))
                                                in
                                                  { model | state = SwitchOrNot door revealing (Opening 1)}

                                              else
                                                { model | state = SwitchOrNot door (otherWrongOne door model.winningDoor) (Opening 1)}
                          otherwise -> model
                      , Cmd.none )


        NewImage (n,zeroOrOne) ->
            -- called with this message when the Random Number Generator returns
            let
                goodN = if n == 31 then 32 else n

                ( word, shape ) =
                    --extract the word and shape from the array
                    case
                        (Array.get goodN wordArray)
                    of
                        -- index exists
                        Just ( (user, word0, grade), (name, school, shape0) ) ->
                            ( word0, shape0 )

                        -- index does not exist, use some defaults
                        Nothing ->
                            ( "", \t -> [] )
            in
                --update the word and shape in our model, and don't launch another command
                ( { model | zeroOrOne = zeroOrOne, word = word, shape = shape, winningDoor = modBy 3 n, state = WaitingFirstPick }, Cmd.none )

        SwitchOrNotSwitch switchOrNot -> ( case model.state of
                                              WaitingFirstPick ->
                                                  model

                                              SwitchOrNot pick revealing curtain ->
                                                  { model | state = Revealed pick revealing switchOrNot (Opening 1)
                                                          , wins = model.wins + if xor (pick == model.winningDoor) switchOrNot then 1 else 0
                                                          , losses = model.losses + if xor (pick == model.winningDoor) switchOrNot then 0 else 1  }

                                              Revealed int int2 bool curtain ->
                                                  model
                                            , Cmd.none )
        GetNewPicture ->
            --launch the generateRandom command
            ( model, generateRandom )

view : Model -> Collage Msg
view model =
    collage 500
        500
        [ (if model.winningDoor == 0 then model.shape else sadShape) { time = model.time }  --display shape
            |> group
            |> clip (square 100 |> ghost)
            |> move (-150,0)
        , (if model.winningDoor == 1 then model.shape else sadShape) { time = model.time }  --display shape
            |> group
            |> clip (square 100 |> ghost)
        , (if model.winningDoor == 2 then model.shape else sadShape) { time = model.time }  --display shape
            |> group
            |> clip (square 100 |> ghost)
            |> move (150,0)
        -- curtain shadows
        , case model.state of
            WaitingFirstPick ->
              group [ curtainShadow Closed
                        |> move (-150,0)
                    , curtainShadow Closed
                    , curtainShadow Closed
                        |> move (150,0)
                    ]
            SwitchOrNot _ revealing curtain ->
              group [ curtainShadow (if revealing == 0 then curtain else Closed)
                        |> move (-150,0)
                    , curtainShadow (if revealing == 1 then curtain else Closed)
                    , curtainShadow (if revealing == 2 then curtain else Closed)
                        |> move (150,0)
                    ]
            Revealed pick revealed switchOrNot curtain ->
              group [ curtainShadow (if revealed == 0 then Open else if pick == 0 && (not switchOrNot) || pick /= 0 && switchOrNot then curtain else Closed)
                        |> move (-150,0)
                    , curtainShadow (if revealed == 1 then Open else if pick == 1 && (not switchOrNot) || pick /= 1 && switchOrNot then curtain else Closed)
                    , curtainShadow (if revealed == 2 then Open else if pick == 2 && (not switchOrNot) || pick /= 2 && switchOrNot then curtain else Closed)
                        |> move (150,0)
                    ]
        -- curtain rod
        , rect 500 5 |> filled (rgb 225 200 50)
            |> move (0, 85)
        -- curtain highlights
        , case model.state of
            WaitingFirstPick ->
              group [ button "0" |> move (-150,-125) |> notifyTap (Door 0)
                    , button "1" |> move (0,-125)    |> notifyTap (Door 1)
                    , button "2" |> move (150,-125)  |> notifyTap (Door 2)
                    ]
            SwitchOrNot _ _ _ ->
              group [ button "Switch" |> move (-75,-125) |> notifyTap (SwitchOrNotSwitch True)
                    , button "Don't Switch" |> move (75,-125)    |> notifyTap (SwitchOrNotSwitch False)
                    ]
            Revealed _ _ _ _ -> button "Next"
                |> move ( 0, -200 )
                |> notifyTap GetNewPicture

        -- highlight
        , case model.state of
            WaitingFirstPick ->
              group [ curtainHighlight Closed
                        |> move (-150,0)
                    , curtainHighlight Closed
                    , curtainHighlight Closed
                        |> move (150,0)
                    ]
            SwitchOrNot _ revealing curtain ->
              group [ curtainHighlight (if revealing == 0 then curtain else Closed)
                        |> move (-150,0)
                    , curtainHighlight (if revealing == 1 then curtain else Closed)
                    , curtainHighlight (if revealing == 2 then curtain else Closed)
                        |> move (150,0)
                    ]
            Revealed pick revealed switchOrNot curtain ->
              group [ curtainHighlight (if revealed == 0 then Open else if pick == 0 && (not switchOrNot) || pick /= 0 && switchOrNot then curtain else Closed)
                        |> move (-150,0)
                    , curtainHighlight (if revealed == 1 then Open else if pick == 1 && (not switchOrNot) || pick /= 1 && switchOrNot then curtain else Closed)
                    , curtainHighlight (if revealed == 2 then Open else if pick == 2 && (not switchOrNot) || pick /= 2 && switchOrNot then curtain else Closed)
                        |> move (150,0)
                    ]


        , case model.state of
            WaitingFirstPick ->
              group [ button "0" |> move (-150,-125) |> notifyTap (Door 0)
                    , button "1" |> move (0,-125)    |> notifyTap (Door 1)
                    , button "2" |> move (150,-125)  |> notifyTap (Door 2)
                    ]
            SwitchOrNot _ _ _ ->
              group [ button "Switch" |> move (-75,-125) |> notifyTap (SwitchOrNotSwitch True)
                    , button "Don't Switch" |> move (75,-125)    |> notifyTap (SwitchOrNotSwitch False)
                    ]
            Revealed _ _ _ _ -> button "Next"
                |> move ( 0, -200 )
                |> notifyTap GetNewPicture
        , text ("Wins:  " ++ String.fromInt model.wins ++ "     Losses:  " ++ String.fromInt model.losses) |> centered |> size 15 |> filled (rgb 0 150 0)
           |> move (0,120)
        , text model.word
            -- display word
            |> centered
            |> size 24
            |> filled black
            |> move ( 0, -170 )
        --, text (String.fromInt model.winningDoor) |> filled green
        --attach GetNewPicture message to the button
        ]

shadowColour = rgb 100 0 50
highlightColour = rgb 150 0 50

curtainShadow curtain =
  case curtain of
    Closed -> rect 150 200 |> filled shadowColour
    Open -> group [ rect 25 200 |> filled shadowColour |> move (-62.5,0)
                  , rect 25 200 |> filled shadowColour |> move ( 62.5,0)
                  ]
    Opening fraction ->
            group [ rect (25 + 50 * fraction) 200 |> filled shadowColour |> move ( 62.5 - 25 * fraction,0)
                  , rect (25 + 50 * fraction) 200 |> filled shadowColour |> move (-62.5 + 25 * fraction,0)
                  ]

curtainHighlight curtain =
  case curtain of
    Open -> openHighlight 0
    Closed -> openHighlight 1
    Opening fraction -> openHighlight fraction

openHighlight fraction =
            group (
              let
                 width = (25 + 50 * fraction)/7
              in
                  List.map ( \ foldNum -> rect width 200 |> filled highlightColour |> move (-75 + width*0.5 + (2*foldNum) * width ,0) )
                                     [0,1,2,3]
                          ++
                  List.map ( \ foldNum -> rect width 200 |> filled highlightColour |> move ( 75 - width*0.5 - (2*foldNum) * width ,0) )
                                     [0,1,2,3]
                  )


-- graphics for button to get new picture


button txt =
    group
        [ roundedRect 75 25 1 |> filled green
        , text txt |> centered |> filled white |> move ( 0, -3 )
        ]
