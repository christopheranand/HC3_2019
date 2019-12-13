-- the only change you should need to make is to add these three lines (and change the group number) TODO


module WebSlot26 exposing (..)
import GraphicSVG exposing (..)
import WebExtra exposing (..)
import Bootstrap.Navbar as Navbar
import Browser.Navigation as Navigation
import Url exposing (Url)
import Browser exposing (UrlRequest)
import Time
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)
import Task
import Browser.Dom as Dom
import Browser.Events exposing (onAnimationFrame)
import GraphicSVG.Widget as Widget
import GraphicSVG.Widget exposing (icon)


--  below is code copied from a Web Slot
{-
4HC3 Final Project Code
Group 26
Student# and Names
Hao Yin
Ruoyuan Liu

Credit to Dr.Christopher Anand for his wordCount assignment code, the initial structure of the code is from WordCount assignment.

Problem definition:
How might we explain the binomial distribution and how to use it to solve certain questions.

Discoverability:
- Problem descriptions and all possible cases are clearly displayed in a decent layout
Feedback:
- The last roll result will be shown above the box
- The number of occurrence and its corresponding probability will be updated after each roll
Conceptual Model:
- The number of occurrence and probability basically show each case's occurrence times and its weight out of all trials
- Text on the right shows equation of binomial distribution and the probability of getting two red balls under one trial
- Input text bar accepts integers only
Affordance:
- Probability chart afford the function of displaying different probability and occurance of each draw scenario
- Last Roll display afford the function of displaying last draw result
- Roll once button afford the function of randomly roll once and record the result to probability chart
- Roll any times button afford the function of reading the number from user input, roll the input number of times, and record the result to the probability chart
- Input area afford the function that let the user to input some integer number
Signifier:
- Formula and explanation text signals bonimial distribution formula explanation to the user
- Problem text signals the question to the user
- Red Instruction text signals the instruction and how to use the application
- Red number signals the result of the question
- Last roll display rectancle signals that the last roll result will be displayed in the rectangle
- Ball scenario images signals which result the probabiility and occurance values represents
Mappings:
- Each case has its corresponding occurrence times and probability
- Each ball has its possible color on one roll
Constraints:
- Only 6 balls can be drawn at one time, restricted to the question description
- Only 2 color of balls are considered to ease user's interpretation of this problem
-}

import Bootstrap.Alert as Alert
import Bootstrap.Badge as Badge
import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Form as Form
import Bootstrap.Form.Checkbox as Checkbox
import Bootstrap.Form.Fieldset as Fieldset
import Bootstrap.Form.Input as Input
import Bootstrap.Form.Radio as Radio
import Bootstrap.Form.Select as Select
import Bootstrap.Form.Textarea as Textarea
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Modal as Modal
import Bootstrap.Table as Table
import Bootstrap.Utilities.Spacing as Spacing
import Bootstrap.Utilities.Size as Size
import Browser
import Debug
import Array exposing (..)
import Dict exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Set
import Tuple
import Random as Random

--this appears at the top of the browser screen (or on the tab)
title : String
title = "Binomial Distribution"

--canvas size
iconWidth = 258
iconHeight = 110

-- last roll display element
lastRollRect =
  [
    GraphicSVG.text "Last Roll:"
    |> GraphicSVG.size 4
    |> filled black
    |> move (-54, 25)
    ,GraphicSVG.rect 110 20
    |> GraphicSVG.size 4
    |> outlined (solid 0.5) black
    |> move (0, 30)

  ]
  |>group

-- problem statement and instruction element
problemAndInsText time=
  let
    u = sin(4*time)
  in
  [
    GraphicSVG.text "Problem:"
    |> GraphicSVG.size 4
    |> filled black
    |> move (-80, 49)
    ,
    GraphicSVG.text "What is the probability of getting a draw of 6 balls with exactly 2 red balls?"
    |> GraphicSVG.size 4
    |> filled black
    |> move (-80, 45)
    ,
    GraphicSVG.rect 165 9
    |> outlined (solid 0.5) black
    |> move (0, 48)
    ,GraphicSVG.text " ▼ Try to Roll the result and see the red number getting close to our calculated result!"
    |> GraphicSVG.size 4
    |> filled red
    |> move (-127, -48)
    |> makeTransparent (if u>0 then 1 else 0.5)

  ]
  |> group


-- formula and explanation element
formula =
  [

    GraphicSVG.text "Binomial Distribution Formula:"
    |> GraphicSVG.size 4
    |> filled black
    |> move (24, 10)
    ,GraphicSVG.text "P = nCk*p^k*(1-p)^(n-k)"
    |> GraphicSVG.size 4
    |> filled black
    |> move (24, 4)
    ,GraphicSVG.text "n -> how many balls picked"
    |> GraphicSVG.size 4
    |> filled black
    |> move (24, -2)
    ,GraphicSVG.text "k -> how many red balls you want"
    |> GraphicSVG.size 4
    |> filled black
    |> move (24, -8)
    ,GraphicSVG.text "p -> the possibility of getting a red ball each time"
    |> GraphicSVG.size 4
    |> filled black
    |> move (24, -14)
    ,GraphicSVG.text "In this problem: n = 6, p = 40% = 0.4, k = 2"
    |> GraphicSVG.size 4
    |> filled black
    |> move (24, -20)
    ,GraphicSVG.text "Put in formula: Probability = 0.31104"
    |> GraphicSVG.size 4
    |> filled red
    |> move (24, -26)

  ]
  |>group

-- probability chart model
prob model=
  let
    originX = -85
    originY = -25
    text1 = String.fromInt model.total
    text2 = String.fromInt model.num1
    text3 = String.fromInt model.num2
    text4 = String.fromInt model.num3
    text5 = String.fromInt model.num4
    text6 = String.fromInt model.num5
    text7 = String.fromInt model.num6
    text8 = String.fromInt model.num7
    textp0 = String.left 6 (String.fromFloat model.p0)
    textp1 = String.left 6 (String.fromFloat model.p1)
    textp2 = String.left 6 (String.fromFloat model.p2)
    textp3 = String.left 6 (String.fromFloat model.p3)
    textp4 = String.left 6 (String.fromFloat model.p4)
    textp5 = String.left 6 (String.fromFloat model.p5)
    textp6 = String.left 6 (String.fromFloat model.p6)
  in
  [
    GraphicSVG.text text1
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+28, originY - 6.5)
    ,GraphicSVG.text text2
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+28, originY - 1.5)
    ,GraphicSVG.text text3
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+28, originY + 3.5)
    ,GraphicSVG.text text4
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+28, originY + 8.5)
    ,GraphicSVG.text text5
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+28, originY + 13.5)
    ,GraphicSVG.text text6
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+28, originY + 18.5)
    ,GraphicSVG.text text7
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+28, originY + 23.5)
    ,GraphicSVG.text text8
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+28, originY + 28.5)

    ,GraphicSVG.text "1"
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+48, originY - 6.5)
    ,GraphicSVG.text textp0
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+48, originY - 1.5)
    ,GraphicSVG.text textp1
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+48, originY + 3.5)
    ,GraphicSVG.text textp2
    |> GraphicSVG.size 4
    |> filled red
    |> move (originX+48, originY + 8.5)
    ,GraphicSVG.text textp3
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+48, originY + 13.5)
    ,GraphicSVG.text textp4
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+48, originY + 18.5)
    ,GraphicSVG.text textp5
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+48, originY + 23.5)
    ,GraphicSVG.text textp6
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+48, originY + 28.5)
    ,GraphicSVG.text "Total"
    |> GraphicSVG.size 4
    |> filled black
    |> move (originX+6, originY-6)
  ]
  |>group


--draw scenario ball display
ballGroup=
  let
    originX = -85
    originY = -25
    ballsize = 1.8
  in
  [      -- all black
    GraphicSVG.circle ballsize
    |> filled black
    |> move (originX, originY)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+4, originY)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+8, originY)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+12, originY)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+16, originY)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+20, originY)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+32, originY-2)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+52, originY-2)
    -- five black
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX, originY+5)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+4, originY+5)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+8, originY+5)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+12, originY+5)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+16, originY+5)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+20, originY+5)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+32, originY+3)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+52, originY+3)
    -- four black
    ,  GraphicSVG.circle ballsize
    |> filled black
    |> move (originX, originY+10)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+4, originY+10)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+8, originY+10)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+12, originY+10)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+16, originY+10)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+20, originY+10)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+32, originY+8)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+52, originY+8)
    -- three black
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX, originY+15)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+4, originY+15)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+8, originY+15)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+12, originY+15)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+16, originY+15)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+20, originY+15)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+32, originY+13)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+52, originY+13)
    -- two black
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX, originY+20)
    , GraphicSVG.circle ballsize
    |> filled black
    |> move (originX+4, originY+20)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+8, originY+20)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+12, originY+20)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+16, originY+20)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+20, originY+20)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+32, originY+18)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+52, originY+18)
    -- one black
    ,  GraphicSVG.circle ballsize
    |> filled black
    |> move (originX, originY+25)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+4, originY+25)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+8, originY+25)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+12, originY+25)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+16, originY+25)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+20, originY+25)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+32, originY+23)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+52, originY+23)
    -- all red
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX, originY+30)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+4, originY+30)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+8, originY+30)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+12, originY+30)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+16, originY+30)
    , GraphicSVG.circle ballsize
    |> filled red
    |> move (originX+20, originY+30)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+32, originY+28)
    , GraphicSVG.rect 15 0.3
    |> filled black
    |> move (originX+52, originY+28)
    --display text
    , GraphicSVG.text "Occurrence#"
    |> GraphicSVG.size 3.25
    |> filled black
    |> move (originX+24, originY+35)
    , GraphicSVG.text "Probability"
    |> GraphicSVG.size 3.25
    |> filled black
    |> move (originX+45, originY+35)
  ]
  |>group

--display box
box =
  [
    GraphicSVG.rect 23 1
    |> filled black
    |> move (5, -10)
    |> rotate (degrees 30)

    ,GraphicSVG.rect 23 1
    |> filled black
    |> move (-5, -10)
    |> rotate (degrees -30)

    ,GraphicSVG.rect 18 1
    |> filled black
    |> move (-20, 0)
    |> rotate (degrees 90)

    ,GraphicSVG.polygon [(0,0),(-20,10),(-20,30),(0,40),(20,30),(20,10)]
    |> outlined (solid 1) black
    |> move (0, -30)

    ,GraphicSVG.circle 10
    |> filled black
    |> move (0, 0)
    |> scaleY 0.5
    ,
    GraphicSVG.rect 10 3
    |> filled red
    |> move (12, 0)
    |> rotate (degrees 90)
    ,
    GraphicSVG.triangle 5
    |> filled red
    |> move (15, 0)
    |> rotate (degrees 90)
    ,GraphicSVG.text "40% red balls"
    |> GraphicSVG.size 3.25
    |> filled red
    |> move (-8, -15)
    |>rotate (degrees 36)
    ,GraphicSVG.text "60% black balls"
    |> GraphicSVG.size 3.25
    |> filled black
    |> move (-12, -20)
    |>rotate (degrees 36)
  ]
  |> group

--show six random ball colors for each trial
ball time boolList=
  let
    color1 = case List.head boolList of
      Nothing -> white
      Just True -> red
      Just False -> black
    color2 = case List.head (List.drop 1 boolList) of
      Nothing -> white
      Just True -> red
      Just False -> black
    color3 = case List.head (List.drop 2 boolList)  of
      Nothing -> white
      Just True -> red
      Just False -> black
    color4 = case List.head (List.drop 3 boolList)  of
      Nothing -> white
      Just True -> red
      Just False -> black
    color5 = case List.head (List.drop 4 boolList)  of
      Nothing -> white
      Just True -> red
      Just False -> black
    color6 = case List.head (List.drop 5 boolList)  of
      Nothing -> white
      Just True -> red
      Just False -> black

  in
    [
      GraphicSVG.circle 5
      |> filled color3
      |> move(0,20)
      ,
      GraphicSVG.circle 5
      |> filled color4
      |> move(15,20)
      ,
      GraphicSVG.circle 5
      |> filled color5
      |> move(30,20)
      ,
      GraphicSVG.circle 5
      |> filled color6
      |> move(45,20)
      ,
      GraphicSVG.circle 5
      |> filled color2
      |> move(-15,20)
      ,
      GraphicSVG.circle 5
      |> filled color1
      |> move(-30,20)
    ]
    |>group
    |>move(0,10)

--page function
page : Model -> List (Html Msg)
page model =
    [ div [ style "margin" "1%" ]
        [ CDN.stylesheet
        , Html.node "link" [ attribute "rel" "stylesheet", attribute "crossorigin" "anonymous", href "https://use.fontawesome.com/releases/v5.7.2/css/all.css" ] []
        , h1 [] [ Html.text "Binomial Distribution" ]
        , Html.div [style "display" "flex", style "flex-direction" "row"]
            [ Html.div [style "width" "100%"] -- change the width of the icon
                [
                    icon "myIcon" iconWidth iconHeight
                        [
                            box,
                            ball model.time model.drawResultList,
                            ballGroup,
                            prob model,
                            problemAndInsText model.time,
                            formula,
                            lastRollRect
                        ]
                ]
            ]
            , Html.div []
            [
              button[onClick Roll][Html.text "Roll Once"]               ]
            , Html.div []
            [
              button[onClick RollAny][Html.text "Roll Any Times"]
              ,
              Input.number
              [
                Input.id "myarea",
                Input.attrs [Size.w25],
                Input.placeholder "100",
                Input.onInput OnInput
              ]
            ]

         ]
     ]

--define model
type alias Model =
    { navKey : Navigation.Key
    ,page : Page
    ,time : Float
    ,timeOfInput : Float
    ,navState : Navbar.State
    ,drawResultList : List Bool
    ,input : Int
    ,total : Int
    ,num1 : Int
    ,num2 : Int
    ,num3 : Int
    ,num4 : Int
    ,num5 : Int
    ,num6 : Int
    ,num7 : Int
    ,p0 : Float
    ,p1 : Float
    ,p2 : Float
    ,p3 : Float
    ,p4 : Float
    ,p5 : Float
    ,p6 : Float
    }

--define page
type Page
    = Home
    | NotFound

--define Msg
type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State
    | NoOp
    | Tick Float
    | NewDraw (List Bool)
    | Roll
    | RollAny
    | OnInput String
    | NewDrawAny (List Bool)


--init function
init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg

        ( model, urlCmd ) =
            urlUpdate url { navKey = key
                          , navState = navState
                          , page = Home
                          , time = 0
                          , timeOfInput = 0
                          , drawResultList = []
                          , input = 100
                          ,total = 0
                          ,num1  = 0
                          ,num2  = 0
                          ,num3  = 0
                          ,num4  = 0
                          ,num5  = 0
                          ,num6  = 0
                          ,num7  = 0
                          ,p0  = 0
                          ,p1  = 0
                          ,p2  = 0
                          ,p3  = 0
                          ,p4  = 0
                          ,p5  = 0
                          ,p6  = 0
                          }
    in
        ( model, Cmd.batch [ urlCmd, navCmd ] )


--subscription function
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [onAnimationFrame ( \ posix -> Tick ((Time.posixToMillis posix |> toFloat) * 0.001) )
         ]

--update function
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink req ->
             case req of
                 Browser.Internal url ->
                     ( model, Navigation.pushUrl model.navKey <| Url.toString url )

                 Browser.External href ->
                     ( model, Navigation.load href )


        UrlChange url ->
            urlUpdate url model

        NavMsg state ->
            ( { model | navState = state }
            , Cmd.none
            )

        NoOp -> (model, Cmd.none)
        Tick t -> ({ model | time = t }, Cmd.none)
        OnInput s -> ({ model | input = check s}, Cmd.none)
        --Operate n trials
        RollAny-> ( model , Random.generate NewDrawAny (Random.list (6*model.input) (Random.weighted (40, True) [ (60, False) ])))
        --Operate one trial
        Roll -> ( model, Random.generate NewDraw (Random.list 6 (Random.weighted (40, True) [ (60, False) ])))
        --Create a list of six Boolean values which shows a random sequence of colors for one trial
        NewDraw randomBoolList -> ( { model | drawResultList = randomBoolList,
                            total = model.total + 1,
                            num1 = countballs0 randomBoolList model.num1,
                            num2 = countballs1 randomBoolList model.num2,
                            num3 = countballs2 randomBoolList model.num3,
                            num4 = countballs3 randomBoolList model.num4,
                            num5 = countballs4 randomBoolList model.num5,
                            num6 = countballs5 randomBoolList model.num6,
                            num7 = countballs6 randomBoolList model.num7,
                            p0 = toFloat (countballs0 randomBoolList model.num1) / toFloat (model.total + 1),
                            p1 = toFloat (countballs1 randomBoolList model.num2) / toFloat (model.total + 1),
                            p2 = toFloat (countballs2 randomBoolList model.num3) / toFloat (model.total + 1),
                            p3 = toFloat (countballs3 randomBoolList model.num4) / toFloat (model.total + 1),
                            p4 = toFloat (countballs4 randomBoolList model.num5) / toFloat (model.total + 1),
                            p5 = toFloat (countballs5 randomBoolList model.num6) / toFloat (model.total + 1),
                            p6 = toFloat (countballs6 randomBoolList model.num7) / toFloat (model.total + 1)   }, Cmd.none)
        --Create a list of n multiple of six(6*n) Boolean values which shows a random sequence of colors for each of n trials
        NewDrawAny randomBoolList -> ( { model | drawResultList = randomBoolList,
                            total = model.total + model.input,
                            num1 = countballs0 randomBoolList model.num1,
                            num2 = countballs1 randomBoolList model.num2,
                            num3 = countballs2 randomBoolList model.num3,
                            num4 = countballs3 randomBoolList model.num4,
                            num5 = countballs4 randomBoolList model.num5,
                            num6 = countballs5 randomBoolList model.num6,
                            num7 = countballs6 randomBoolList model.num7,
                            p0 = toFloat (countballs0 randomBoolList model.num1) / toFloat (model.total + model.input),
                            p1 = toFloat (countballs1 randomBoolList model.num2) / toFloat (model.total + model.input),
                            p2 = toFloat (countballs2 randomBoolList model.num3) / toFloat (model.total + model.input),
                            p3 = toFloat (countballs3 randomBoolList model.num4) / toFloat (model.total + model.input),
                            p4 = toFloat (countballs4 randomBoolList model.num5) / toFloat (model.total + model.input),
                            p5 = toFloat (countballs5 randomBoolList model.num6) / toFloat (model.total + model.input),
                            p6 = toFloat (countballs6 randomBoolList model.num7) / toFloat (model.total + model.input)   }, Cmd.none)

urlUpdate : Url -> Model -> ( Model, Cmd Msg )
urlUpdate url model =
    case decode url of
        Nothing ->
            ( { model | page = NotFound }, resetViewport )

        Just route ->
            ( { model | page = route }, resetViewport )

resetViewport : Cmd Msg
resetViewport =
  Task.perform (\_ -> NoOp) (Dom.setViewport 0 0)

decode : Url -> Maybe Page
decode url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
    |> UrlParser.parse routeParser

routeParser : Parser (Page -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home top
        ]

--view function
view : Model -> Browser.Document Msg
view model =
    { title = case model.page of
          Home ->
            title

          NotFound ->
              "Page Not Found"
    , body =
        [
          Html.node "link" [attribute "rel" "stylesheet", href "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"] []
        , Html.node "link" [attribute "rel" "stylesheet", href "https://documents.mcmaster.ca/www/cdn/css/1.0/mcm-bw.css"] []
        ,  Html.div []
            [
              mainContent model
            ]
        ]
    }
--main function
mainContent : Model -> Html Msg
mainContent model =
    Grid.container [] <|
        case model.page of
            Home ->
                page model

            NotFound ->
                pageNotFound

-- pageNotFound function
pageNotFound : List (Html Msg)
pageNotFound =
    [ Html.h1 [Spacing.my4] [ Html.text "Not found" ]
    , Html.text "Sorry, couldn't find that page"
    ]

-- check if maybe string can be convert to int
check : String -> Int
check s = case String.toInt s of
          Nothing -> 0
          Just int -> int
--count the number of True in a list
numofTrue : (List Bool) -> Int -> Int
numofTrue list num =
  case List.head list of
    Nothing -> num
    Just True -> numofTrue (List.drop 1 list) (num+1)
    Just False -> numofTrue (List.drop 1 list)  num

--count the number of trials which contain 0 red balls
countballs0 list num =
  case list of
    b1 :: b2 :: b3 :: b4 :: b5 :: b6 :: lstr -> if numofTrue [b1, b2, b3, b4, b5, b6] 0 == 0 then countballs0 lstr (num + 1)
                                           else countballs0 lstr num
    other -> num

--count the number of trials which contain 1 red balls
countballs1 list num =
  case list of
    b1 :: b2 :: b3 :: b4 :: b5 :: b6 :: lstr -> if numofTrue [b1, b2, b3, b4, b5, b6] 0 == 1 then countballs1 lstr (num + 1)
                                           else countballs1 lstr num
    other -> num

--count the number of trials which contain 2 red balls
countballs2 list num =
  case list of
    b1 :: b2 :: b3 :: b4 :: b5 :: b6 :: lstr -> if numofTrue [b1, b2, b3, b4, b5, b6] 0 == 2 then countballs2 lstr (num + 1)
                                           else countballs2 lstr num
    other -> num

--count the number of trials which contain 3 red balls
countballs3 list num =
  case list of
    b1 :: b2 :: b3 :: b4 :: b5 :: b6 :: lstr -> if numofTrue [b1, b2, b3, b4, b5, b6] 0 == 3 then countballs3 lstr (num + 1)
                                           else countballs3 lstr num
    other -> num

--count the number of trials which contain 4 red balls
countballs4 list num =
  case list of
    b1 :: b2 :: b3 :: b4 :: b5 :: b6 :: lstr -> if numofTrue [b1, b2, b3, b4, b5, b6] 0 == 4 then countballs4 lstr (num + 1)
                                           else countballs4 lstr num
    other -> num

--count the number of trials which contain 5 red balls
countballs5 list num =
  case list of
    b1 :: b2 :: b3 :: b4 :: b5 :: b6 :: lstr -> if numofTrue [b1, b2, b3, b4, b5, b6] 0 == 5 then countballs5 lstr (num + 1)
                                           else countballs5 lstr num
    other -> num

--count the number of trials which contain 6 red balls
countballs6 list num =
  case list of
    b1 :: b2 :: b3 :: b4 :: b5 :: b6 :: lstr -> if numofTrue [b1, b2, b3, b4, b5, b6] 0 == 6 then countballs6 lstr (num + 1)
                                           else countballs6 lstr num
    other -> num
