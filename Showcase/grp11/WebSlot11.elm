-- the only change you should need to make is to add these three lines (and change the group number) TODO


module WebSlot11 exposing (..)
import GraphicSVG exposing (..)
import WebExtra exposing (..)
import Bootstrap.Navbar as Navbar
import Browser.Navigation as Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.Widget as Widget
import Bootstrap.Accordion as Accordion
import Bootstrap.Modal as Modal
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Carousel as Carousel
import Url exposing (Url)
import Browser exposing (UrlRequest)
import Browser.Dom as Dom
import Browser.Events exposing (onAnimationFrame)
import Bootstrap.Utilities.Spacing as Spacing
import Time
import Task
import Dict exposing (Dict)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)
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
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Modal as Modal
import Bootstrap.Table as Table
import Bootstrap.Navbar as Navbar
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Text as Text

import Bootstrap.Card.Block as Block

import Bootstrap.Modal as Modal

import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup

import GraphicSVG exposing(..)
import GraphicSVG.Widget as Widget

import Dict
import Set
import List.Extra as List


--  below is code copied from a Web Slot
{-
4HC3 Final Project

Group 11

Stephanie Lin -
Christine Mitry -
Abrar Attia -
Curtis Coe -
-}

import Bootstrap.Button as Btn
import Bootstrap.CDN as CDN
import List.Extra exposing (unique)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random

--this appears at the top of the browser screen (or on the tab)
title : String
title = "Group 11 Final Code"

iconWidth = 190
iconHeight = 130
butWidth = 150
butHeight = 100

myApple = group
  [ rect 3 10
      |> filled brown
      |> move (0,8)
  , curve (0,0) [Pull (10,0) (20,-10)]
      |> filled green
      |> scale 0.6
      |> rotate (degrees 30)
      |> move (-1,12.5)
  , circle 7
      |> filled red
      |> scaleY 1.5
      |> move (-3,0)
  , circle 7
      |> filled red
      |> scaleY 1.5
      |> move (3,0)
  ]

-- Choices of 1 to 6 apples
choices =
  [ myApple
  , group
    [ myApple |> move (-12.5,0)
    , myApple |> move ( 12.5,0)
    ]
  , group
    [ myApple |> move (-12.5,-13)
    , myApple |> move ( 12.5,-13)
    , myApple |> move (    0, 13)
    ]
  , group
    [ myApple |> move (-12.5, 13)
    , myApple |> move ( 12.5, 13)
    , myApple |> move (-12.5,-13)
    , myApple |> move ( 12.5,-13)
    ]
  , group
    [ myApple |> move (-12.5, 26)
    , myApple |> move ( 12.5, 26)
    , myApple |> move (-12.5, 0)
    , myApple |> move ( 12.5, 0)
    , myApple |> move (    0,-26)
    ]
  , group
    [ myApple |> move (-12.5, 26)
    , myApple |> move ( 12.5, 26)
    , myApple |> move (-12.5, 0)
    , myApple |> move ( 12.5, 0)
    , myApple |> move (-12.5,-26)
    , myApple |> move ( 12.5,-26)
    ]
  ]

sqr = square 90
-- Borders, choices, and flashing colour for answers
leftBox model = group
  [ sqr |> outlined (solid 1) black
  , (Tuple.first  model.problem)
  , (case model.answerState of
      BadL  -> sqr |> filled red   |> makeTransparent 0.5
      BadE  -> sqr |> filled red   |> makeTransparent 0.5
      GoodL -> sqr |> filled green |> makeTransparent 0.5
      GoodE -> sqr |> filled green |> makeTransparent 0.5
      other -> sqr |> outlined (solid 1) black
    )
  ] |> move (-47.5, 0)
rightBox model = group
  [ sqr |> outlined (solid 1) black
  , (Tuple.second model.problem)
  , (case model.answerState of
      BadR  -> sqr |> filled red   |> makeTransparent 0.5
      BadE  -> sqr |> filled red   |> makeTransparent 0.5
      GoodR -> sqr |> filled green |> makeTransparent 0.5
      GoodE -> sqr |> filled green |> makeTransparent 0.5
      other -> sqr |> outlined (solid 1) black
    )
  ] |> move ( 47.5, 0)

-- Game display - Title, boxes, apples, and score
game model = group
  [ GraphicSVG.text "Which box has more apples?"
      |> GraphicSVG.size 15 |> centered |> filled black |> move (0,  50)
  , GraphicSVG.text ("Score : " ++ (String.fromInt model.score))
      |> GraphicSVG.size 15 |> centered |> filled black |> move (0, -60)
  , group [leftBox model, rightBox model]
  ]

-- Page setup
page : Model -> List (Html Msg)
page model =
    [ div [ style "margin" "1%" ]
        [ CDN.stylesheet
        , Html.div [align "center"]
            -- Displays the game
            [ Widget.view model.widget0 [game model]
            -- Displays the buttons
            , Btn.button [Btn.onClick TapLeft,  Btn.large, Btn.dark, Btn.attrs [ Spacing.ml1 ]] [Html.text "Left"]
            , Btn.button [Btn.onClick TapEqual, Btn.large, Btn.dark, Btn.attrs [ Spacing.ml1 ]] [Html.text "Same"]
            , Btn.button [Btn.onClick TapRight, Btn.large, Btn.dark, Btn.attrs [ Spacing.ml1 ]] [Html.text "Right"]
            ]
        ]
    ]

type alias Model =
    { navKey : Navigation.Key
    , navState : Navbar.State
    , page : Page
    , time : Float
    , timeOfInput : Float
    , problem : (Shape Msg, Shape Msg) -- Current problem
    , score : Int
    , answer : Answer
    , answerState : AnswerState -- If a right or wrong answer was chosen
    , animate : GuessState -- Animation state
    , badTime : Float -- How long to flash the animation
    , widget0 : Widget.Model
    }

type Answer
    = Left
    | Right
    | Equal

type AnswerState
    = None
    | GoodL
    | GoodR
    | GoodE
    | BadL
    | BadR
    | BadE

type GuessState
    = Waiting
    | BadPick  Float
    | GoodPick Float
    | Startup

type Page
    = Home
    | NotFound

type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State
    | Widget0Msg Widget.Msg
    | NoOp
    | Tick Float
    | TapLeft
    | TapRight
    | TapEqual
    | NewComp (Int,Int)

init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg
        ( wstate0, wcmd0 ) =
            Widget.init iconWidth iconHeight "widget0"

        ( model, urlCmd ) =
            urlUpdate url { navKey = key
                          , navState = navState
                          , page = Home
                          , time = 0
                          , timeOfInput = 0
                          -- Display nothing in the problem initially
                          , problem = ( sqr |> filled blank, sqr |> filled blank )
                          , score = 0
                          , answer = Equal
                          , answerState = None
                          , animate = Startup
                          , badTime = 0.25
                          , widget0 = wstate0
                          }
    in
        ( model, Cmd.batch [ urlCmd, navCmd, Cmd.map Widget0Msg wcmd0 ] )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink req ->
             case req of
                 Browser.Internal url ->
                     ( model, Navigation.pushUrl model.navKey <| Url.toString url )
                 Browser.External href ->
                     ( model, Navigation.load href )

        UrlChange url -> urlUpdate url model

        NavMsg state -> ( { model | navState = state }, Cmd.none)

        Widget0Msg wMsg ->
            let
                ( newWState, wCmd ) =
                    Widget.update wMsg model.widget0
            in
            ( { model | widget0 = newWState }
            , Cmd.map Widget0Msg wCmd
            )


        NoOp -> (model, Cmd.none)

        Tick t ->
          let lastTime = if model.time > 0 then model.time else t
          in case model.animate of
            -- Generate a new problem when the game first opens
            Startup ->  ( { model | time = t, animate = Waiting }, randInt model )
            -- Wait for a new state
            Waiting ->  ( { model | time = t, animate = Waiting }, Cmd.none )
            -- If the wrong choice was picked, wait tLeft time, then stop red flash
            BadPick tLeft
              -> if tLeft < t - lastTime
                  then ( { model | time = t, animate = Waiting, answerState = None }, Cmd.none )
                  else ( { model | time = t, animate = BadPick (tLeft-(t-lastTime))}, Cmd.none )
            -- If the correct choice was picked, wait tLeft time, then stop green flash
            GoodPick tLeft
              -> if tLeft < t - lastTime
                  then ( { model | time = t, animate = Waiting, answerState = None  }, Cmd.none )
                  else ( { model | time = t, animate = GoodPick (tLeft-(t-lastTime))}, Cmd.none )

        -- If left is chosen
        TapLeft ->
          -- If not in waiting state, do nothing
          if model.animate /= Waiting then (model, Cmd.none)
          else case model.answer of
          -- If left is the correct answer, score+1 and flash green
            Left ->
                ({model | animate = GoodPick model.badTime
                , score = model.score + 1
                , answerState = GoodL }, randInt model)
            -- otherwise score-1 and flash red
            a ->
                ({model | animate = BadPick model.badTime
                , answerState = BadL
                , score = model.score - 1}, Cmd.none)


        -- If right is chosen
        TapRight ->
          -- If not in waiting state, do nothing
          if model.animate /= Waiting then (model, Cmd.none)
          -- If right is the correct answer, score+1 and flash green
          else case model.answer of
            Right ->
                ({model | animate = GoodPick model.badTime
                , score = model.score + 1
                , answerState = GoodR }, randInt model)
            -- otherwise score-1 and flash red
            a ->
                ({model | animate = BadPick model.badTime
                , answerState = BadR
                , score = model.score - 1}, Cmd.none)

        TapEqual ->
          -- If not in waiting state, do nothing
          if model.animate /= Waiting then (model, Cmd.none)
          -- If equal is the correct answer, score+1 and flash green
          else case model.answer of
            Equal ->
                ({model | animate = GoodPick <| model.badTime
                , score = model.score + 1
                , answerState = GoodE }, randInt model)
            -- otherwise score-1 and flash red
            a ->
                ({model | animate = BadPick model.badTime
                , answerState = BadE
                , score = model.score - 1}, Cmd.none)

        -- Generate a new problem, and set answer
        NewComp (a,b) ->
          ({model | problem = newProblem choices a b
                  , answer = if a == b then Equal
                        else if a > b  then Left
                                       else Right
           }, Cmd.none)

-- Retrieve the choices from the list
newProblem : List (Shape Msg) -> Int -> Int -> (Shape Msg, Shape Msg)
newProblem list a b =
  ( (List.Extra.getAt a list |> Maybe.withDefault myApple)
  , (List.Extra.getAt b list |> Maybe.withDefault myApple)
  )

-- Generate two random integers from 1 to the length of the choices list -1
randInt : Model -> Cmd Msg
randInt model =
    (Random.pair
    (Random.int 0 ((List.length choices)-1))
      (Random.int 0 ((List.length choices)-1)))
  |> Random.generate NewComp



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [onAnimationFrame ( \ posix -> Tick ((Time.posixToMillis posix |> toFloat) * 0.001) )]

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
    UrlParser.oneOf [ UrlParser.map Home top ]

view : Model -> Browser.Document Msg
view model =
    { title = case model.page of
          Home ->
            title

          NotFound ->
              "Page Not Found"
    , body =
        [ Html.node "link" [attribute "rel" "stylesheet", href "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"] []
        , Html.node "link" [attribute "rel" "stylesheet", href "https://documents.mcmaster.ca/www/cdn/css/1.0/mcm-bw.css"] []
        ,  Html.div [] [ mainContent model ]
        ]
    }

mainContent : Model -> Html Msg
mainContent model =
    Grid.container [] <|
        case model.page of
            Home ->
                page model
            NotFound ->
                pageNotFound

pageNotFound : List (Html Msg)
pageNotFound =
    [ Html.h1 [Spacing.my4] [ Html.text "Not found" ]
    , Html.text "Sorry, couldn't find that page"
    ]
