-- the only change you should need to make is to add these three lines (and change the group number) TODO


module GameSlot43 exposing (..)
import FakeGetKeyState exposing (..)
import GraphicSVG exposing (..)

--  below is code copied from a Game Slot
--Group 43
--Max Mercer
--Gregory Kitching
--Koushik Ghosh
-- Our application was developed to help students in second year discrete
-- math (CS/SE 2DM3) at McMaster memorze course theorems. Students have
-- over 100 theorems they have to utilize and memorize in order to prove theorems
-- and solve equations. Our application is matching game that helps
-- students memorize 30 of their course theorems. The theorems come from 3
-- course topics (Logic, Set Theory, and Integers).
-- How the game works.
-- Run the application and read 'How To Play'.
-- imported libraries.

import Dict exposing (Dict)
import List.Extra exposing (getAt, removeAt)
import Random exposing (Seed, generate, initialSeed, int, maxInt, minInt, step)



-- this section describes the view depending on the selected page.


myShapes : Model -> List (Shape Msg)
myShapes model =
    case model.page of
        Home ->
            [ text "Welcome to Discrete Match!" |> centered |> size 12 |> filled black |> move ( 0, 40 )
            , text "- an educational matching game for discrete mathematics -" |> centered |> size 5 |> filled black |> move ( 0, 30 )
            , title "Home"
            , roundedRect 125 40 3 |> outlined (solid 1) (rgb 0 0 0)
            , changePageButton GoToGame "PLAY GAME" 30 8
            , selectGameTypeButton SelectLogic "Logic" -30 10 Logic model
            , selectGameTypeButton SelectSetTheory "Set Theory" -30 0 SetTheory model
            , selectGameTypeButton SelectIntegers "Integers" -30 -10 Integers model
            , changePageButton GoToTheoremList "Theorem List" 30 -8
            , changePageButton GoToHowToPlay "How To Play" 0 -40
            ]

        Game ->
            [ title "Game"
            , changePageButton GoToHowToPlay "How To Play" -50 -58
            , theoremColumn model.gameType "Theorem Name"
            , column "Theorem" 0
            , column "Selection" 50
            , changePageButton GoToHome "Quit" -50 -46
            , text ("Score: " ++ String.fromInt model.gameScore ++ "/10")
                |> filled black
                |> move ( -20, -50 )
            , text ("Time: " ++ (String.fromInt <| round (model.time - model.startTime)))
                |> filled black
                |> move ( 40, -50 )
            ]
                ++ dynamicGame model

        -- this is the matching game that is rendered on the game page.
        Results ->
            [ title "Results"
            , text "Congradulations!" |> centered |> filled black |> move ( 0, 20 )
            , text "You matched 10/10 theorems in:" |> centered |> filled black |> move ( 0, 5 )
            , text ((String.fromInt <| round model.totalTime) ++ " seconds.") |> centered |> filled black |> move ( 0, -10 )
            , changePageButton GoToGame "Play Again" -50 -50
            , changePageButton GoToHome "Go To Home" 50 -50
            ]

        TheoremList ->
            [ title "Theorem List"
            , changePageButton GoToHome "Go To Home" -50 -50
            , dynamicTheoremList model
            ]

        HowToPlay ->
            [ title "How To Play"
            , text "1) In the home menu, Select Logic, Set Theory, or Integers." |> size 5 |> centered |> filled black |> move ( 0, 20 )
            , text "2) Click Play Game" |> size 5 |> centered |> filled black |> move ( 0, 10 )
            , text "3) Click and drag the theorems in the right column to the middle column." |> size 5 |> centered |> filled black |> move ( 0, 0 )
            , text "Goal: Match the theorem to the same row as the theorem name!" |> size 5 |> centered |> filled black |> move ( 0, -10 )
            , changePageButton GoToHome "Go To Home" -50 -50
            ]



-- this is the title that appears at the top of each page.


title label =
    group [ text label |> centered |> size 3 |> filled black ] |> move ( -85, 60 )



-- standard change page button function.


changePageButton goTo label dx dy =
    group
        [ roundedRect 50 10 3 |> outlined (solid 1) (rgb 0 0 0)
        , text label |> centered |> size 8 |> filled red |> move ( 0, -2.5 )
        ]
        |> move ( dx, dy )
        |> notifyTap goTo



-- button to change game type (choose between Logic, Set Theory, Integers)


selectGameTypeButton select label dx dy gt model =
    group
        [ roundedRect 60 10 3 |> filled (selected gt model)
        , roundedRect 60 10 3 |> outlined (solid 1) (rgb 0 0 0)
        , text label |> centered |> size 8 |> filled red |> move ( 0, -2.5 )
        ]
        |> move ( dx, dy )
        |> notifyTap select



-- the selected funcion handles the colour of the selected game type.


selected gt model =
    case gt of
        Logic ->
            if model.gameType == Logic then
                grey

            else
                white

        SetTheory ->
            if model.gameType == SetTheory then
                grey

            else
                white

        Integers ->
            if model.gameType == Integers then
                grey

            else
                white



-- in the game page this is the column of theorem names depending on the game state.


theoremColumn gt label =
    case gt of
        Logic ->
            group
                [ text label |> centered |> size 8 |> filled red |> move ( -50, 50 )
                , theoremNameCell "Symmetry of ≡" -50 40
                , theoremNameCell "Zero of ∨" -50 32
                , theoremNameCell "Golden Rule" -50 24
                , theoremNameCell "De Morgan" -50 16
                , theoremNameCell "Definition of Implication" -50 8
                , theoremNameCell "Mutual Implication" -50 0
                , theoremNameCell "Absorbtion" -50 -8
                , theoremNameCell "Modus Ponens" -50 -16
                , theoremNameCell "Shunting" -50 -24
                , theoremNameCell "Identity of ∧" -50 -32
                ]

        SetTheory ->
            group
                [ text label |> centered |> size 8 |> filled red |> move ( -50, 50 )
                , theoremNameCell "Reflexivity of ⊆" -50 40
                , theoremNameCell "Mutual inclusion" -50 32
                , theoremNameCell "Self-inverse of ˘" -50 24
                , theoremNameCell "Cancellation of ˘" -50 16
                , theoremNameCell "Monotonicity of ˘" -50 8
                , theoremNameCell "Symmetry of ∩" -50 0
                , theoremNameCell "Idempotency of ∩" -50 -8
                , theoremNameCell "Converse of ∩" -50 -16
                , theoremNameCell "Inclusion via ∪" -50 -24
                , theoremNameCell "Idempotency of ∪" -50 -32
                ]

        Integers ->
            group
                [ text label |> centered |> size 8 |> filled red |> move ( -50, 50 )
                , theoremNameCell "Converse of <" -50 40
                , theoremNameCell "Reflexivity of ≤" -50 32
                , theoremNameCell "Associativity of +" -50 24
                , theoremNameCell "Cancellation of +" -50 16
                , theoremNameCell "Subtraction" -50 8
                , theoremNameCell "Positivity of Squares" -50 0
                , theoremNameCell "Associativity of •" -50 -8
                , theoremNameCell "Positivity under •" -50 -16
                , theoremNameCell "Unary Minus" -50 -24
                , theoremNameCell "Definition of ≥" -50 -32
                ]



-- describes the individual cells of the theorem name column above.


theoremNameCell theoremName dx dy =
    group
        [ rect 50 8 |> outlined (solid 1) (rgb 0 0 0)
        , text theoremName |> centered |> size 4 |> filled red |> move ( 0, -2.5 )
        ]
        |> move ( dx, dy )



-- Middle column of empty cells in the game.


column label x =
    group
        [ text label |> centered |> size 8 |> filled red |> move ( x, 50 )
        , emptyCell x 40
        , emptyCell x 32
        , emptyCell x 24
        , emptyCell x 16
        , emptyCell x 8
        , emptyCell x 0
        , emptyCell x -8
        , emptyCell x -16
        , emptyCell x -24
        , emptyCell x -32
        ]



-- describes the individual cells of the middle column above.


emptyCell dx dy =
    rect 50 8 |> outlined (solid 1) (rgb 0 0 0) |> move ( dx, dy )



-- displays all theorem names of the selected game type in the theorem list page.


dynamicTheoremList model =
    case model.gameType of
        Logic ->
            group
                [ theoremNameCell2 "Symmetry of ≡: p ≡ q ≡ q ≡ p" -50 40
                , theoremNameCell2 "Zero of ∨: p ∨ true ≡ true" -50 32
                , theoremNameCell2 "Golden Rule: p ∧ q ≡ (p ≡ (q ≡ p ∨ q))" -50 24
                , theoremNameCell2 "De Morgan: ¬(p ∧ q) ≡ ¬p ∨ ¬q" -50 16
                , theoremNameCell2 "Definition of Implication: p ⇒ q ≡ (p ∨ q ≡ q)" -50 8
                , theoremNameCell2 "Mutual Implication: (p⇒q) ∧ (q⇒p) ≡ (p ≡ q)" -50 0
                , theoremNameCell2 "Absorbtion: p ∧ (p ∨ q) ≡ p" -50 -8
                , theoremNameCell2 "Modus Ponens: p ∧ (p ⇒ q) ⇒ q" -50 -16
                , theoremNameCell2 "Shunting: p ∧ q ⇒ r ≡ p ⇒ (q ⇒ r)" -50 -24
                , theoremNameCell2 "Identity of ∧: p ∧ true ≡ p" -50 -32
                ]

        SetTheory ->
            group
                [ theoremNameCell2 "Reflexivity of ⊆: R = S ⇒ R ⊆ S" -50 40
                , theoremNameCell2 "Mutual inclusion: R=S ≡ R ⊆ S ∧ S ⊆ R" -50 32
                , theoremNameCell2 "Self-inverse of ˘: R ˘ ˘ = R" -50 24
                , theoremNameCell2 "Cancellation of ˘: R ˘ = S ˘ ≡ R = S" -50 16
                , theoremNameCell2 "Monotonicity of ˘: R ⊆ S ⇒ R ˘ ⊆ S ˘" -50 8
                , theoremNameCell2 "Symmetry of ∩: Q ∩ R = R ∩ Q" -50 0
                , theoremNameCell2 "Idempotency of ∩: R ∩ R = R" -50 -8
                , theoremNameCell2 "Converse of ∩: (R ∩ S) ˘ = R ˘ ∩ S ˘" -50 -16
                , theoremNameCell2 "Inclusion via ∪: Q ⊆ R ≡ Q ∪ R = R" -50 -24
                , theoremNameCell2 "Idempotency of ∪: R ∪ R = R" -50 -32
                ]

        Integers ->
            group
                [ theoremNameCell2 "Converse of <: a > b ≡ b < a" -50 40
                , theoremNameCell2 "Reflexivity of ≤: a ≤ a" -50 32
                , theoremNameCell2 "Associativity of +: (a+b)+c = a+(b+c)" -50 24
                , theoremNameCell2 "Cancellation of +: a + b = a + c ≡ b = c" -50 16
                , theoremNameCell2 "Subtraction:  - b = a + -b" -50 8
                , theoremNameCell2 "Positivity of Squares: b ≠ 0 ⇒ pos(b•b)" -50 0
                , theoremNameCell2 "Associativity of •: (a•b)•c = a•(b•c)" -50 -8
                , theoremNameCell2 "Positivity under •: pos(a)⇒(pos(b)≡pos(a•b))" -50 -16
                , theoremNameCell2 "Unary Minus: a + -a = 0" -50 -24
                , theoremNameCell2 "Definition of ≥: a≥b ≡ a>b ∨ a=b" -50 -32
                ]



-- This function formats the the individual theorems in the theorem list page.


theoremNameCell2 theoremName dx dy =
    group
        [ text theoremName |> centered |> size 4 |> filled red |> move ( 0, -2.5 )
        ]
        |> move ( 0, dy )



-- this is the game that is rendered in the Game page.


dynamicGame : Model -> List (Shape Msg)
dynamicGame model =
    let
        lList =
            Dict.toList model.targetDict
    in
    List.map drawAt lList
        ++ -- what we draw depends on the state, this code generated by PALDraw
           (case model.state of
                Waiting ->
                    -- apply drawWord to two inputs, the index in list, and the value in the wordList
                    List.indexedMap drawWord lList

                SlinkingBack ( label, ( x0, y0 ) ) progress ( dx, dy ) ( lx, ly ) ->
                    [ text label
                        |> centered
                        |> filled black
                        |> move
                            ( x0 + (1 - progress) * (lx - dx)
                            , y0 + (1 - progress) * (ly - dy)
                            )
                    ]

                Dragging ( label, ( x0, y0 ) ) ( dx, dy ) ( lx, ly ) ->
                    [ text label
                        |> centered
                        |> filled black
                        |> move
                            ( x0 + lx - dx
                            , y0 + ly - dy
                            )
                    , rect 192 128
                        |> filled (rgba 0 0 255 0.01)
                        |> notifyMouseUpAt MUp
                        |> notifyMouseMoveAt MMove
                    ]

                ProclaimingVictory label ( lx, ly ) ->
                    [ text ""
                        |> centered
                        |> filled black
                    ]
           )



-- draws all the polygons in the list of the target region for the word


drawAt : ( String, ( List (List ( Float, Float )), ( Float, Float ) ) ) -> Shape userMsg
drawAt ( _, ( polys, xy ) ) =
    List.map (\polly -> polygon polly |> outlined (solid 1) black |> makeTransparent 0) polys
        |> group



-- draws one word, and attaches a notifyMouseDownAt to start the drag operation


drawWord :
    Int
    ->
        ( String
        , ( List (List ( Float, Float )) -- the colour and target region
          , ( Float, Float )
          )
        )
    -> Shape Msg
drawWord idx ( wrd, ( _, ( x, y ) ) ) =
    let
        pos =
            ( x, y )
    in
    text wrd
        |> size 5
        |> centered
        |> filled black
        |> move pos
        |> notifyMouseDownAt (MDown ( wrd, pos ))



-- when a user makes the correct match the theorems location is updated.


updateDict xnyn maybeElem =
    case maybeElem of
        Just ( polys, _ ) ->
            Just ( polys, xnyn )

        Nothing ->
            Nothing



-- application model.


type alias Model =
    { time : Float
    , startTime : Float
    , totalTime : Float
    , page : Page
    , gameType : GameType
    , gameScore : Int
    , state : State

    -- a Dict lets us look up values, like a normal dictionary, but with any values, not just definitions
    , targetDict :
        Dict String
            ( List (List ( Float, Float )) -- the target region
            , ( Float, Float )
            )
    }



-- different pages in application


type Page
    = Home
    | Game
    | Results
    | TheoremList
    | HowToPlay



-- possible game states


type State
    = Waiting
    | SlinkingBack ( String, ( Float, Float ) ) Float ( Float, Float ) ( Float, Float )
    | Dragging ( String, ( Float, Float ) ) ( Float, Float ) ( Float, Float )
    | ProclaimingVictory String ( Float, Float )



-- possible game types


type GameType
    = Logic
    | SetTheory
    | Integers



-- possible user actions. As a result of button clicks, and clicking and dragging.


type Msg
    = Tick Float GetKeyState
    | GoToHome
    | GoToGame
    | Submit
    | GoToTheoremList
    | GoToHowToPlay
    | SelectLogic
    | SelectSetTheory
    | SelectIntegers
    | MDown ( String, ( Float, Float ) ) ( Float, Float )
    | MMove ( Float, Float )
    | MUp ( Float, Float )



-- this is the control that perfors actions depending on the application model and user actions.


update msg model =
    case msg of
        Tick t _ ->
            --{ time = t, page = model.page, gameType = model.gameType, state = model.state,  }
            case model.state of
                Waiting ->
                    { model | time = t }

                SlinkingBack draggable progress downPos lastPos ->
                    { model
                        | time = t
                        , state =
                            case updateProgress model.time t progress of
                                Just newProgress ->
                                    SlinkingBack draggable newProgress downPos lastPos

                                Nothing ->
                                    Waiting
                    }

                Dragging draggable downPos lastPos ->
                    { model | time = t }

                ProclaimingVictory label tuple ->
                    { model
                        | time = t
                        , state = Waiting
                        , targetDict = Dict.update label (updateDict tuple) model.targetDict
                        , gameScore = model.gameScore + 1
                        , totalTime = model.time - model.startTime
                        , page =
                            if
                                model.gameScore == 9
                                -- is one less than 10
                            then
                                Results

                            else
                                Game
                    }

        GoToHome ->
            { model | page = Home }

        GoToGame ->
            { model
                | page = Game
                , startTime = model.time
                , gameScore = 0
                , targetDict =
                    case model.gameType of
                        Logic ->
                            randomize logicList model.time

                        SetTheory ->
                            randomize setList model.time

                        Integers ->
                            randomize integerList model.time
            }

        Submit ->
            { model | page = Results }

        GoToTheoremList ->
            { model | page = TheoremList }

        GoToHowToPlay ->
            { model | page = HowToPlay }

        SelectLogic ->
            { model | gameType = Logic }

        SelectSetTheory ->
            { model | gameType = SetTheory }

        SelectIntegers ->
            { model | gameType = Integers }

        MDown draggable newPos ->
            case model.state of
                Waiting ->
                    { model | state = Dragging draggable newPos newPos }

                otherwise ->
                    model

        MMove newPos ->
            case model.state of
                Dragging draggable downPos lastPos ->
                    { model | state = Dragging draggable downPos newPos }

                otherwise ->
                    model

        MUp newPos ->
            case model.state of
                Dragging ( label, ( x0, y0 ) ) ( dx, dy ) ( lx, ly ) ->
                    { model
                        | state =
                            case Dict.get label model.targetDict of
                                Just ( polys, xy ) ->
                                    if
                                        List.filter (\poly -> insideConvexClockwisePoly poly ( x0 + lx - dx, y0 + ly - dy ))
                                            polys
                                            == []
                                    then
                                        SlinkingBack ( label, ( x0, y0 ) ) 0 ( dx, dy ) ( lx, ly )

                                    else
                                        ProclaimingVictory label ( x0 + lx - dx, y0 + ly - dy )

                                Nothing ->
                                    SlinkingBack ( label, ( x0, y0 ) ) 0 ( dx, dy ) ( lx, ly )
                    }

                otherwise ->
                    model



-- this function randomizes the order of the dictionary where the current time is the seed.


randomize theoremList time =
    Dict.fromList (List.map (randomizeHelper time) theoremList)


randomizeHelper time dictElem =
    let
        heights =
            shuffleList (initialSeed (round time)) randomCellList
    in
    case dictElem of
        ( label, ( polys, ( x, i ) ) ) ->
            ( label, ( polys, ( x, Maybe.withDefault 100 (getAt (round i) heights) ) ) )



-- initial values.


init =
    { time = 0, startTime = 0, totalTime = 0, page = Home, gameType = Logic, gameScore = 0, state = Waiting, targetDict = Dict.fromList logicList }



-- y corrdinates of theorems start locations.
-- this list is randomized. Then each value is assigned as the y coordinate of a theormes start location.


randomCellList =
    [ 40 - 2.5, 32 - 2.5, 24 - 2.5, 16 - 2.5, 8 - 2.5, 0 - 2.5, -8 - 2.5, -16 - 2.5, -24 - 2.5, -32 - 2.5 ]


logicList :
    List
        ( String -- the theorem
        , ( List (List ( Float, Float )) -- the target region
          , ( Float, Float )
          )
          -- the theorems start location. (updated to the target when user makes a correct match)
        )
logicList =
    [ ( "p ≡ q ≡ q ≡ p", ( [ [ ( 0, 46 ), ( 25, 36 ), ( -25, 36 ), ( 0, 46 ) ] ], ( 50, 0 ) ) )
    , ( "p ∨ true ≡ true", ( [ [ ( 0, 38 ), ( 25, 28 ), ( -25, 28 ), ( 0, 38 ) ] ], ( 50, 1 ) ) )
    , ( "p ∧ q ≡ (p ≡ (q ≡ p ∨ q))", ( [ [ ( 0, 30 ), ( 25, 20 ), ( -25, 20 ), ( 0, 30 ) ] ], ( 50, 2 ) ) )
    , ( "¬(p ∧ q) ≡ ¬p ∨ ¬q", ( [ [ ( 0, 22 ), ( 25, 12 ), ( -25, 12 ), ( 0, 22 ) ] ], ( 50, 3 ) ) )
    , ( "p ⇒ q ≡ (p ∨ q ≡ q)", ( [ [ ( 0, 14 ), ( 25, 4 ), ( -25, 4 ), ( 0, 14 ) ] ], ( 50, 4 ) ) )
    , ( "(p⇒q) ∧ (q⇒p) ≡ (p ≡ q)", ( [ [ ( 0, 6 ), ( 25, -4 ), ( -25, -4 ), ( 0, 6 ) ] ], ( 50, 5 ) ) )
    , ( "p ∧ (p ∨ q) ≡ p", ( [ [ ( 0, -2 ), ( 25, -12 ), ( -25, -12 ), ( 0, -2 ) ] ], ( 50, 6 ) ) )
    , ( "p ∧ (p ⇒ q) ⇒ q", ( [ [ ( 0, -10 ), ( 25, -20 ), ( -25, -20 ), ( 0, -10 ) ] ], ( 50, 7 ) ) )
    , ( "p ∧ q ⇒ r ≡ p ⇒ (q ⇒ r)", ( [ [ ( 0, -18 ), ( 25, -28 ), ( -25, -28 ), ( 0, -18 ) ] ], ( 50, 8 ) ) )
    , ( "p ∧ true ≡ p", ( [ [ ( 0, -26 ), ( 25, -36 ), ( -25, -36 ), ( 0, -26 ) ] ], ( 50, 9 ) ) )
    ]


setList :
    List
        ( String -- the theorem
        , ( List (List ( Float, Float )) -- the target region
          , ( Float, Float )
          )
          -- the theorems start location. (updated to the target when user makes a correct match)
        )
setList =
    [ ( "R = S ⇒ R ⊆ S", ( [ [ ( 0, 46 ), ( 25, 36 ), ( -25, 36 ), ( 0, 46 ) ] ], ( 50, 0 ) ) )
    , ( "R=S ≡ R ⊆ S ∧ S ⊆ R", ( [ [ ( 0, 38 ), ( 25, 28 ), ( -25, 28 ), ( 0, 38 ) ] ], ( 50, 1 ) ) )
    , ( "R ˘ ˘ = R", ( [ [ ( 0, 30 ), ( 25, 20 ), ( -25, 20 ), ( 0, 30 ) ] ], ( 50, 2 ) ) )
    , ( "R ˘ = S ˘ ≡ R = S", ( [ [ ( 0, 22 ), ( 25, 12 ), ( -25, 12 ), ( 0, 22 ) ] ], ( 50, 3 ) ) )
    , ( "R ⊆ S ⇒ R ˘ ⊆ S ˘", ( [ [ ( 0, 14 ), ( 25, 4 ), ( -25, 4 ), ( 0, 14 ) ] ], ( 50, 4 ) ) )
    , ( "Q ∩ R = R ∩ Q", ( [ [ ( 0, 6 ), ( 25, -4 ), ( -25, -4 ), ( 0, 6 ) ] ], ( 50, 5 ) ) )
    , ( "R ∩ R = R", ( [ [ ( 0, -2 ), ( 25, -12 ), ( -25, -12 ), ( 0, -2 ) ] ], ( 50, 6 ) ) )
    , ( "(R ∩ S) ˘ = R ˘ ∩ S ˘", ( [ [ ( 0, -10 ), ( 25, -20 ), ( -25, -20 ), ( 0, -10 ) ] ], ( 50, 7 ) ) )
    , ( "Q ⊆ R ≡ Q ∪ R = R", ( [ [ ( 0, -18 ), ( 25, -28 ), ( -25, -28 ), ( 0, -18 ) ] ], ( 50, 8 ) ) )
    , ( "R ∪ R = R", ( [ [ ( 0, -26 ), ( 25, -36 ), ( -25, -36 ), ( 0, -26 ) ] ], ( 50, 9 ) ) )
    ]


integerList :
    List
        ( String -- the theorem
        , ( List (List ( Float, Float )) -- the target region
          , ( Float, Float )
          )
          -- the theorems start location. (updated to the target when user makes a correct match)
        )
integerList =
    [ ( "a > b ≡ b < a", ( [ [ ( 0, 46 ), ( 25, 36 ), ( -25, 36 ), ( 0, 46 ) ] ], ( 50, 0 ) ) )
    , ( "a ≤ a", ( [ [ ( 0, 38 ), ( 25, 28 ), ( -25, 28 ), ( 0, 38 ) ] ], ( 50, 1 ) ) )
    , ( "(a+b)+c = a+(b+c)", ( [ [ ( 0, 30 ), ( 25, 20 ), ( -25, 20 ), ( 0, 30 ) ] ], ( 50, 2 ) ) )
    , ( "a + b = a + c ≡ b = c", ( [ [ ( 0, 22 ), ( 25, 12 ), ( -25, 12 ), ( 0, 22 ) ] ], ( 50, 3 ) ) )
    , ( "a - b = a + -b", ( [ [ ( 0, 14 ), ( 25, 4 ), ( -25, 4 ), ( 0, 14 ) ] ], ( 50, 4 ) ) )
    , ( "b ≠ 0 ⇒ pos(b•b)", ( [ [ ( 0, 6 ), ( 25, -4 ), ( -25, -4 ), ( 0, 6 ) ] ], ( 50, 5 ) ) )
    , ( "(a•b)•c = a•(b•c)", ( [ [ ( 0, -2 ), ( 25, -12 ), ( -25, -12 ), ( 0, -2 ) ] ], ( 50, 6 ) ) )
    , ( "pos(a)⇒(pos(b)≡pos(a•b)) ", ( [ [ ( 0, -10 ), ( 25, -20 ), ( -25, -20 ), ( 0, -10 ) ] ], ( 50, 7 ) ) )
    , ( "a + -a = 0", ( [ [ ( 0, -18 ), ( 25, -28 ), ( -25, -28 ), ( 0, -18 ) ] ], ( 50, 8 ) ) )
    , ( "a≥b ≡ a>b ∨ a=b", ( [ [ ( 0, -26 ), ( 25, -36 ), ( -25, -36 ), ( 0, -26 ) ] ], ( 50, 9 ) ) )
    ]



---- geometry helper functions ----
-- unused function to draw a word in the middle of each region


drawInMiddle : ( String, List (List ( Float, Float )) ) -> Shape msg
drawInMiddle ( label, regions ) =
    let
        vertices =
            List.concat regions

        weights =
            1 / (toFloat <| List.length vertices)

        ( xSum, ySum ) =
            List.foldr (\( x, y ) ( x1, y1 ) -> ( x + x1, y + y1 )) ( 0, 0 ) vertices

        centre =
            ( weights * xSum, weights * ySum )
    in
    text label |> filled black |> move centre



-- return True if the point (x,y) is on the right of the line going from (x1,y1) to (x2,y2)


onRightOf : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float ) -> Bool
onRightOf ( x1, y1 ) ( x2, y2 ) ( x, y ) =
    let
        v12 =
            ( y1 - y2, x2 - x1 )

        vp2 =
            ( x - x2, y - y2 )
    in
    dot v12 vp2 < 0



-- calculate dot product, it is positive if two vectors are pointing in the same direction


dot : ( Float, Float ) -> ( Float, Float ) -> Float
dot ( x, y ) ( u, v ) =
    x * u + y * v


insideConvexClockwisePoly : List ( Float, Float ) -> ( Float, Float ) -> Bool
insideConvexClockwisePoly ptList pt =
    case ptList of
        q1 :: q2 :: qs ->
            if onRightOf q1 q2 pt then
                insideConvexClockwisePoly (q2 :: qs) pt

            else
                False

        otherwise ->
            True



-- impossible
-- increment animation progress 0 to 1, and return Nothing if we are at the end of the animation


updateProgress old new progress =
    let
        newProgress =
            progress + (new - old) * speed
    in
    if newProgress < 1 then
        Just newProgress

    else
        Nothing


speed =
    0.5



------------ shuffling code found at https://ellie-app.com/jSPT6mMLXFa1 ------------
-- entry point to suffling a list


shuffleList : Seed -> List a -> List a
shuffleList seed list =
    shuffleListHelper seed list []



-- recursize function that shuffles a list randomly


shuffleListHelper : Seed -> List a -> List a -> List a
shuffleListHelper seed source result =
    if List.isEmpty source then
        result

    else
        let
            indexGenerator =
                int 0 (List.length source - 1)

            ( index, nextSeed ) =
                step indexGenerator seed

            valAtIndex =
                getAt index source

            sourceWithoutIndex =
                removeAt index source
        in
        case valAtIndex of
            Just val ->
                shuffleListHelper nextSeed sourceWithoutIndex (val :: result)

            Nothing ->
                result
