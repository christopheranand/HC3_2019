{-
-}
module Main exposing (main)

import Debug



import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Browser.Navigation as Navigation
import Browser exposing (UrlRequest)
import Browser.Dom as Dom
import Browser.Events exposing (onAnimationFrame)
import Time
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
import Bootstrap.Utilities.Spacing as Spacing
import Task
import Dict exposing (Dict)

import Bootstrap.Card.Block as Block

import Bootstrap.Modal as Modal

import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup

import GraphicSVG exposing(..)
import GraphicSVG.Widget as Widget

import Dict
import Set
import List.Extra as List

import Grp1
import Grp2
import Grp1 as Grp3
import Grp1 as Grp4
import Grp1 as Grp5
import Grp1 as Grp6
import Grp1 as Grp7
import Grp1 as Grp8
import Grp1 as Grp9
import Grp1 as Grp10
import Grp1 as Grp11
import Grp1 as Grp12
import Grp1 as Grp13
import Grp1 as Grp14
import Grp1 as Grp15
import Grp1 as Grp16
import Grp1 as Grp17
import Grp1 as Grp18
import Grp1 as Grp19
import Grp1 as Grp20
import Grp1 as Grp21
import Grp1 as Grp22
import Grp1 as Grp23
import Grp1 as Grp24
import Grp25
import Grp1 as Grp26
import Grp1 as Grp27
import Grp1 as Grp28
import Grp1 as Grp29
import Grp1 as Grp30
import Grp1 as Grp31
import Grp1 as Grp32
import Grp1 as Grp33
import Grp1 as Grp34
import Grp1 as Grp35
import Grp1 as Grp36
import Grp1 as Grp37
import Grp1 as Grp38
import Grp1 as Grp39
import Grp1 as Grp40
import Grp1 as Grp41
import Grp1 as Grp42
import Grp43
import Grp1 as Grp44

{-headerWeb Page Creator.-}

{-Editable-}
--this appears at the top of the browser screen (or on the tab)
title : String
title = "WidgetTemplate"

page : Model -> List (Html Msg)
page model =
    [ Html.div [ style "margin" "1%" ] <|
        [ CDN.stylesheet
        , Html.node "link" [ attribute "rel" "stylesheet", attribute "crossorigin" "anonymous", href "https://use.fontawesome.com/releases/v5.7.2/css/all.css" ] []
        , Grid.container [] -- Wrap in a container to center the navbar
            [ Navbar.config NavMsg
                |> Navbar.withAnimation
                |> Navbar.collapseMedium            -- Collapse menu at the medium breakpoint
                |> Navbar.info                      -- Customize coloring
                |> Navbar.brand                     -- Add logo to your brand with a little styling to align nicely
                    [ href "#" ]
                    [ Html.img
                        [ src "http://www.cas.mcmaster.ca/~anand/McMasterLogo.png"
                        , class "d-inline-block align-top"
                        , style "width" "30px"
                        ]
                        []
                    ]
                |> Navbar.items
                    [ Navbar.itemLink
                        [ onClick FixSlopeIntercept ] [ Html.text "About"]
                    , Navbar.itemLink
                        [ onClick FixSlopeIntercept ] [ Html.text "Map"]
                    , Navbar.dropdown              -- Adding dropdowns is pretty simple
                        { id = "prototypes"
                        , toggle = Navbar.dropdownToggle [] [ Html.text "prototypes" ]
                        , items =
                            [ Navbar.dropdownItem [ onClick (GoTo (Demo1 model.navKey)) ] [ Html.text "group 1" ]
                            -- Prelude> putStrLn $ concat ["Navbar.dropdownItem [ onClick (GoTo (Demo"++show i++" model.navKey)) ] [ Html.text \"group "++show i++"\" ]\n                            , " | i <- [2..44]]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo2 model.navKey)) ] [ Html.text "group 2" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo3 model.navKey)) ] [ Html.text "group 3" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo4 model.navKey)) ] [ Html.text "group 4" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo5 model.navKey)) ] [ Html.text "group 5" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo6 model.navKey)) ] [ Html.text "group 6" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo7 model.navKey)) ] [ Html.text "group 7" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo8 model.navKey)) ] [ Html.text "group 8" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo9 model.navKey)) ] [ Html.text "group 9" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo10 model.navKey)) ] [ Html.text "group 10" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo11 model.navKey)) ] [ Html.text "group 11" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo12 model.navKey)) ] [ Html.text "group 12" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo13 model.navKey)) ] [ Html.text "group 13" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo14 model.navKey)) ] [ Html.text "group 14" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo15 model.navKey)) ] [ Html.text "group 15" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo16 model.navKey)) ] [ Html.text "group 16" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo17 model.navKey)) ] [ Html.text "group 17" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo18 model.navKey)) ] [ Html.text "group 18" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo19 model.navKey)) ] [ Html.text "group 19" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo20 model.navKey)) ] [ Html.text "group 20" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo21 model.navKey)) ] [ Html.text "group 21" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo22 model.navKey)) ] [ Html.text "group 22" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo23 model.navKey)) ] [ Html.text "group 23" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo24 model.navKey)) ] [ Html.text "group 24" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo25 model.navKey)) ] [ Html.text "group 25" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo26 model.navKey)) ] [ Html.text "group 26" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo27 model.navKey)) ] [ Html.text "group 27" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo28 model.navKey)) ] [ Html.text "group 28" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo29 model.navKey)) ] [ Html.text "group 29" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo30 model.navKey)) ] [ Html.text "group 30" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo31 model.navKey)) ] [ Html.text "group 31" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo32 model.navKey)) ] [ Html.text "group 32" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo33 model.navKey)) ] [ Html.text "group 33" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo34 model.navKey)) ] [ Html.text "group 34" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo35 model.navKey)) ] [ Html.text "group 35" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo36 model.navKey)) ] [ Html.text "group 36" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo37 model.navKey)) ] [ Html.text "group 37" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo38 model.navKey)) ] [ Html.text "group 38" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo39 model.navKey)) ] [ Html.text "group 39" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo40 model.navKey)) ] [ Html.text "group 40" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo41 model.navKey)) ] [ Html.text "group 41" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo42 model.navKey)) ] [ Html.text "group 42" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo43 model.navKey)) ] [ Html.text "group 43" ]
                            , Navbar.dropdownItem [ onClick (GoTo (Demo44 model.navKey)) ] [ Html.text "group 44" ]
                            ]
                        }
                    ]
                |> Navbar.customItems
                    [ Navbar.formItem []
                        [ Input.text [ Input.attrs [placeholder "search" ], Input.onInput NewSlope]
                        ]
                    ]
                |> Navbar.view model.navState
            ]
        ]
        ++
        (
            case model.demo of
                NoDemo ->
                  [ Html.text "Pick a demo."
                  ]

                Demo1 modelGrp1 ->
                  Grp1.view modelGrp1 |> (List.map (Html.map (DemoMsg << Demo1)))

                --putStrLn $ unlines ["Demo"++show i++" grpMdl -> Grp"++show i++".view grpMdl |> (List.map (Html.map (DemoMsg << Demo"++show i++")))" | i <- [2..44]]
                Demo2 grpMdl -> Grp2.view grpMdl |> (List.map (Html.map (DemoMsg << Demo2)))
                Demo3 grpMdl -> Grp3.view grpMdl |> (List.map (Html.map (DemoMsg << Demo3)))
                Demo4 grpMdl -> Grp4.view grpMdl |> (List.map (Html.map (DemoMsg << Demo4)))
                Demo5 grpMdl -> Grp5.view grpMdl |> (List.map (Html.map (DemoMsg << Demo5)))
                Demo6 grpMdl -> Grp6.view grpMdl |> (List.map (Html.map (DemoMsg << Demo6)))
                Demo7 grpMdl -> Grp7.view grpMdl |> (List.map (Html.map (DemoMsg << Demo7)))
                Demo8 grpMdl -> Grp8.view grpMdl |> (List.map (Html.map (DemoMsg << Demo8)))
                Demo9 grpMdl -> Grp9.view grpMdl |> (List.map (Html.map (DemoMsg << Demo9)))
                Demo10 grpMdl -> Grp10.view grpMdl |> (List.map (Html.map (DemoMsg << Demo10)))
                Demo11 grpMdl -> Grp11.view grpMdl |> (List.map (Html.map (DemoMsg << Demo11)))
                Demo12 grpMdl -> Grp12.view grpMdl |> (List.map (Html.map (DemoMsg << Demo12)))
                Demo13 grpMdl -> Grp13.view grpMdl |> (List.map (Html.map (DemoMsg << Demo13)))
                Demo14 grpMdl -> Grp14.view grpMdl |> (List.map (Html.map (DemoMsg << Demo14)))
                Demo15 grpMdl -> Grp15.view grpMdl |> (List.map (Html.map (DemoMsg << Demo15)))
                Demo16 grpMdl -> Grp16.view grpMdl |> (List.map (Html.map (DemoMsg << Demo16)))
                Demo17 grpMdl -> Grp17.view grpMdl |> (List.map (Html.map (DemoMsg << Demo17)))
                Demo18 grpMdl -> Grp18.view grpMdl |> (List.map (Html.map (DemoMsg << Demo18)))
                Demo19 grpMdl -> Grp19.view grpMdl |> (List.map (Html.map (DemoMsg << Demo19)))
                Demo20 grpMdl -> Grp20.view grpMdl |> (List.map (Html.map (DemoMsg << Demo20)))
                Demo21 grpMdl -> Grp21.view grpMdl |> (List.map (Html.map (DemoMsg << Demo21)))
                Demo22 grpMdl -> Grp22.view grpMdl |> (List.map (Html.map (DemoMsg << Demo22)))
                Demo23 grpMdl -> Grp23.view grpMdl |> (List.map (Html.map (DemoMsg << Demo23)))
                Demo24 grpMdl -> Grp24.view grpMdl |> (List.map (Html.map (DemoMsg << Demo24)))
                Demo25 grpMdl -> Grp25.view grpMdl |> (List.map (Html.map (DemoMsg << Demo25)))
                Demo26 grpMdl -> Grp26.view grpMdl |> (List.map (Html.map (DemoMsg << Demo26)))
                Demo27 grpMdl -> Grp27.view grpMdl |> (List.map (Html.map (DemoMsg << Demo27)))
                Demo28 grpMdl -> Grp28.view grpMdl |> (List.map (Html.map (DemoMsg << Demo28)))
                Demo29 grpMdl -> Grp29.view grpMdl |> (List.map (Html.map (DemoMsg << Demo29)))
                Demo30 grpMdl -> Grp30.view grpMdl |> (List.map (Html.map (DemoMsg << Demo30)))
                Demo31 grpMdl -> Grp31.view grpMdl |> (List.map (Html.map (DemoMsg << Demo31)))
                Demo32 grpMdl -> Grp32.view grpMdl |> (List.map (Html.map (DemoMsg << Demo32)))
                Demo33 grpMdl -> Grp33.view grpMdl |> (List.map (Html.map (DemoMsg << Demo33)))
                Demo34 grpMdl -> Grp34.view grpMdl |> (List.map (Html.map (DemoMsg << Demo34)))
                Demo35 grpMdl -> Grp35.view grpMdl |> (List.map (Html.map (DemoMsg << Demo35)))
                Demo36 grpMdl -> Grp36.view grpMdl |> (List.map (Html.map (DemoMsg << Demo36)))
                Demo37 grpMdl -> Grp37.view grpMdl |> (List.map (Html.map (DemoMsg << Demo37)))
                Demo38 grpMdl -> Grp38.view grpMdl |> (List.map (Html.map (DemoMsg << Demo38)))
                Demo39 grpMdl -> Grp39.view grpMdl |> (List.map (Html.map (DemoMsg << Demo39)))
                Demo40 grpMdl -> Grp40.view grpMdl |> (List.map (Html.map (DemoMsg << Demo40)))
                Demo41 grpMdl -> Grp41.view grpMdl |> (List.map (Html.map (DemoMsg << Demo41)))
                Demo42 grpMdl -> Grp42.view grpMdl |> (List.map (Html.map (DemoMsg << Demo42)))
                Demo43 grpMdl -> Grp43.view grpMdl |> (List.map (Html.map (DemoMsg << Demo43)))
                Demo44 grpMdl -> Grp44.view grpMdl |> (List.map (Html.map (DemoMsg << Demo44)))

        )

    ]

{- The number of  pop ups.
   To add more than one, you must increase this number and then make sure to
   put the correct id in the code where you add it. The ids start at 0 and go up from there
   (0, 1, 2, 3, etc.)
-}
numPopUps = 1


type alias Model =
    { navKey : Navigation.Key
    , page : Page
    , time : Float
    , navState : Navbar.State
    , url : Url
    -- PUT YOUR MODEL VALUES HERE
    , widget0 : Widget.Model -- contains state about display of widget
    , demo : Demo Grp1.Model
    --Prelude> putStrLn $ concat [" Grp"++show i++".Model" | i <- [2..44]]
                  Grp2.Model Grp3.Model Grp4.Model Grp5.Model
                  Grp6.Model Grp7.Model Grp8.Model Grp9.Model
                  Grp10.Model Grp11.Model Grp12.Model Grp13.Model Grp14.Model Grp15.Model
                  Grp16.Model Grp17.Model Grp18.Model Grp19.Model Grp20.Model Grp21.Model
                  Grp22.Model Grp23.Model Grp24.Model Grp25.Model Grp26.Model Grp27.Model
                  Grp28.Model Grp29.Model Grp30.Model Grp31.Model Grp32.Model Grp33.Model
                  Grp34.Model Grp35.Model Grp36.Model Grp37.Model Grp38.Model Grp39.Model
                  Grp40.Model Grp41.Model Grp42.Model Grp43.Model Grp44.Model
    , slope : Maybe Float -- Nothing = bad input, Just = acceptable value
    , intercept : Maybe Float -- Nothing = bad input, Just = acceptable value
    }

type Page
    = Home
    | NotFound

    -- Prelude> putStrLn $ concat [" d"++show i | i <- [2..44]]
type Demo d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17 d18 d19 d20 d21 d22 d23 d24 d25 d26 d27 d28 d29 d30 d31 d32 d33 d34 d35 d36 d37 d38 d39 d40 d41 d42 d43 d44
    = NoDemo
    | Demo1 d1
    --Prelude> putStrLn $ concat [" | Demo"++show i++" d"++show i | i <- [2..44]]
    | Demo2 d2 | Demo3 d3 | Demo4 d4 | Demo5 d5 | Demo6 d6 | Demo7 d7 | Demo8 d8 | Demo9 d9 | Demo10 d10
    | Demo11 d11 | Demo12 d12 | Demo13 d13 | Demo14 d14 | Demo15 d15
    | Demo16 d16 | Demo17 d17 | Demo18 d18 | Demo19 d19 | Demo20 d20
    | Demo21 d21 | Demo22 d22 | Demo23 d23 | Demo24 d24 | Demo25 d25
    | Demo26 d26 | Demo27 d27 | Demo28 d28 | Demo29 d29 | Demo30 d30
    | Demo31 d31 | Demo32 d32 | Demo33 d33 | Demo34 d34 | Demo35 d35
    | Demo36 d36 | Demo37 d37 | Demo38 d38 | Demo39 d39 | Demo40 d40
    | Demo41 d41 | Demo42 d42 | Demo43 d43 | Demo44 d44

type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State
    | NoOp
    | Tick Float

    | Widget0Msg (Widget.Msg)

    | GoTo (Demo  Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key Navigation.Key )

    | DemoMsg (Demo Grp1.Msg
    --Prelude> putStrLn $ concat [" Grp"++show i++".Msg" | i <- [2..44]]
              Grp2.Msg Grp3.Msg Grp4.Msg Grp5.Msg Grp6.Msg Grp7.Msg Grp8.Msg Grp9.Msg Grp10.Msg Grp11.Msg Grp12.Msg Grp13.Msg Grp14.Msg Grp15.Msg Grp16.Msg Grp17.Msg Grp18.Msg Grp19.Msg Grp20.Msg Grp21.Msg Grp22.Msg Grp23.Msg Grp24.Msg Grp25.Msg Grp26.Msg Grp27.Msg Grp28.Msg Grp29.Msg Grp30.Msg Grp31.Msg Grp32.Msg Grp33.Msg Grp34.Msg Grp35.Msg Grp36.Msg Grp37.Msg Grp38.Msg Grp39.Msg Grp40.Msg Grp41.Msg Grp42.Msg Grp43.Msg Grp44.Msg
              )

    | FixSlopeIntercept

    | NewSlope String
    | NewIntercept String

init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg

        (wstate0, wcmd0) = Widget.init iconWidth iconHeight "widget0"


        ( model, urlCmd ) =
            urlUpdate url { navKey = key
                          , navState = navState
                          , page = Home
                          , time = 0
                          , url = url
                          , widget0 = wstate0
                          , demo = NoDemo
                          , slope = Nothing
                          , intercept = Nothing
                          }
    in
        ( model, Cmd.batch [ Cmd.map Widget0Msg wcmd0, urlCmd, navCmd ] )



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [Navbar.subscriptions model.navState NavMsg
    , onAnimationFrame ( \ posix -> Tick ((Time.posixToMillis posix |> toFloat) * 0.001) )
    ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FixSlopeIntercept ->
          ( { model | slope = Just 3, intercept = Just -2 }, Cmd.none )
        Widget0Msg wMsg ->
            let
                (newWState, wCmd) = Widget.update wMsg model.widget0
            in
                ({ model | widget0 = newWState }
                , Cmd.map Widget0Msg wCmd)

        NewSlope txt -> ( { model | slope = String.toFloat txt }, Cmd.none )

        NewIntercept txt ->
          ( { model | intercept = case String.toFloat txt of
                                    Nothing -> Nothing
                                    Just value -> if value < 30 && value > -30
                                                  then Just value
                                                  else Nothing
            }
          , Cmd.none )
        ClickedLink req -> (model, Cmd.none ) {-}
             case req of
                 Browser.Internal url ->
                     ( model, Navigation.pushUrl model.navKey <| Url.toString url )

                 Browser.External href ->
                     ( model, Navigation.load href )
-}

        UrlChange url ->
            urlUpdate url model

        NavMsg state ->
            ( { model | navState = state }
            , Cmd.none
            )

        NoOp -> (model, Cmd.none)

        GoTo demo ->
          case demo of
            Demo1 _ ->
              let
                  (demoModel, demoCmd) = Grp1.init
              in
                  ( { model | demo = Demo1 demoModel}, Cmd.map (DemoMsg << Demo1) demoCmd)
--Prelude> putStrLn $ unlines ["            Demo"++show i++" _ -> let (demoModel, demoCmd) = Grp"++show i++".init in ( { model | demo = Demo"++show i++" demoModel}, Cmd.map (DemoMsg << Demo"++show i++") demoCmd)" | i <- [2..44]]
            Demo2 _ -> let (demoModel, demoCmd) = Grp2.init in ( { model | demo = Demo2 demoModel}, Cmd.map (DemoMsg << Demo2) demoCmd)
            Demo3 _ -> let (demoModel, demoCmd) = Grp3.init in ( { model | demo = Demo3 demoModel}, Cmd.map (DemoMsg << Demo3) demoCmd)
            Demo4 _ -> let (demoModel, demoCmd) = Grp4.init in ( { model | demo = Demo4 demoModel}, Cmd.map (DemoMsg << Demo4) demoCmd)
            Demo5 _ -> let (demoModel, demoCmd) = Grp5.init in ( { model | demo = Demo5 demoModel}, Cmd.map (DemoMsg << Demo5) demoCmd)
            Demo6 _ -> let (demoModel, demoCmd) = Grp6.init in ( { model | demo = Demo6 demoModel}, Cmd.map (DemoMsg << Demo6) demoCmd)
            Demo7 _ -> let (demoModel, demoCmd) = Grp7.init in ( { model | demo = Demo7 demoModel}, Cmd.map (DemoMsg << Demo7) demoCmd)
            Demo8 _ -> let (demoModel, demoCmd) = Grp8.init in ( { model | demo = Demo8 demoModel}, Cmd.map (DemoMsg << Demo8) demoCmd)
            Demo9 _ -> let (demoModel, demoCmd) = Grp9.init in ( { model | demo = Demo9 demoModel}, Cmd.map (DemoMsg << Demo9) demoCmd)
            Demo10 _ -> let (demoModel, demoCmd) = Grp10.init in ( { model | demo = Demo10 demoModel}, Cmd.map (DemoMsg << Demo10) demoCmd)
            Demo11 _ -> let (demoModel, demoCmd) = Grp11.init in ( { model | demo = Demo11 demoModel}, Cmd.map (DemoMsg << Demo11) demoCmd)
            Demo12 _ -> let (demoModel, demoCmd) = Grp12.init in ( { model | demo = Demo12 demoModel}, Cmd.map (DemoMsg << Demo12) demoCmd)
            Demo13 _ -> let (demoModel, demoCmd) = Grp13.init in ( { model | demo = Demo13 demoModel}, Cmd.map (DemoMsg << Demo13) demoCmd)
            Demo14 _ -> let (demoModel, demoCmd) = Grp14.init in ( { model | demo = Demo14 demoModel}, Cmd.map (DemoMsg << Demo14) demoCmd)
            Demo15 _ -> let (demoModel, demoCmd) = Grp15.init in ( { model | demo = Demo15 demoModel}, Cmd.map (DemoMsg << Demo15) demoCmd)
            Demo16 _ -> let (demoModel, demoCmd) = Grp16.init in ( { model | demo = Demo16 demoModel}, Cmd.map (DemoMsg << Demo16) demoCmd)
            Demo17 _ -> let (demoModel, demoCmd) = Grp17.init in ( { model | demo = Demo17 demoModel}, Cmd.map (DemoMsg << Demo17) demoCmd)
            Demo18 _ -> let (demoModel, demoCmd) = Grp18.init in ( { model | demo = Demo18 demoModel}, Cmd.map (DemoMsg << Demo18) demoCmd)
            Demo19 _ -> let (demoModel, demoCmd) = Grp19.init in ( { model | demo = Demo19 demoModel}, Cmd.map (DemoMsg << Demo19) demoCmd)
            Demo20 _ -> let (demoModel, demoCmd) = Grp20.init in ( { model | demo = Demo20 demoModel}, Cmd.map (DemoMsg << Demo20) demoCmd)
            Demo21 _ -> let (demoModel, demoCmd) = Grp21.init in ( { model | demo = Demo21 demoModel}, Cmd.map (DemoMsg << Demo21) demoCmd)
            Demo22 _ -> let (demoModel, demoCmd) = Grp22.init in ( { model | demo = Demo22 demoModel}, Cmd.map (DemoMsg << Demo22) demoCmd)
            Demo23 _ -> let (demoModel, demoCmd) = Grp23.init in ( { model | demo = Demo23 demoModel}, Cmd.map (DemoMsg << Demo23) demoCmd)
            Demo24 _ -> let (demoModel, demoCmd) = Grp24.init in ( { model | demo = Demo24 demoModel}, Cmd.map (DemoMsg << Demo24) demoCmd)
            Demo25 key -> let (demoModel, demoCmd) = Grp25.init key model.url in ( { model | demo = Demo25 demoModel}, Cmd.map (DemoMsg << Demo25) demoCmd)
            Demo26 _ -> let (demoModel, demoCmd) = Grp26.init in ( { model | demo = Demo26 demoModel}, Cmd.map (DemoMsg << Demo26) demoCmd)
            Demo27 _ -> let (demoModel, demoCmd) = Grp27.init in ( { model | demo = Demo27 demoModel}, Cmd.map (DemoMsg << Demo27) demoCmd)
            Demo28 _ -> let (demoModel, demoCmd) = Grp28.init in ( { model | demo = Demo28 demoModel}, Cmd.map (DemoMsg << Demo28) demoCmd)
            Demo29 _ -> let (demoModel, demoCmd) = Grp29.init in ( { model | demo = Demo29 demoModel}, Cmd.map (DemoMsg << Demo29) demoCmd)
            Demo30 _ -> let (demoModel, demoCmd) = Grp30.init in ( { model | demo = Demo30 demoModel}, Cmd.map (DemoMsg << Demo30) demoCmd)
            Demo31 _ -> let (demoModel, demoCmd) = Grp31.init in ( { model | demo = Demo31 demoModel}, Cmd.map (DemoMsg << Demo31) demoCmd)
            Demo32 _ -> let (demoModel, demoCmd) = Grp32.init in ( { model | demo = Demo32 demoModel}, Cmd.map (DemoMsg << Demo32) demoCmd)
            Demo33 _ -> let (demoModel, demoCmd) = Grp33.init in ( { model | demo = Demo33 demoModel}, Cmd.map (DemoMsg << Demo33) demoCmd)
            Demo34 _ -> let (demoModel, demoCmd) = Grp34.init in ( { model | demo = Demo34 demoModel}, Cmd.map (DemoMsg << Demo34) demoCmd)
            Demo35 _ -> let (demoModel, demoCmd) = Grp35.init in ( { model | demo = Demo35 demoModel}, Cmd.map (DemoMsg << Demo35) demoCmd)
            Demo36 _ -> let (demoModel, demoCmd) = Grp36.init in ( { model | demo = Demo36 demoModel}, Cmd.map (DemoMsg << Demo36) demoCmd)
            Demo37 _ -> let (demoModel, demoCmd) = Grp37.init in ( { model | demo = Demo37 demoModel}, Cmd.map (DemoMsg << Demo37) demoCmd)
            Demo38 _ -> let (demoModel, demoCmd) = Grp38.init in ( { model | demo = Demo38 demoModel}, Cmd.map (DemoMsg << Demo38) demoCmd)
            Demo39 _ -> let (demoModel, demoCmd) = Grp39.init in ( { model | demo = Demo39 demoModel}, Cmd.map (DemoMsg << Demo39) demoCmd)
            Demo40 _ -> let (demoModel, demoCmd) = Grp40.init in ( { model | demo = Demo40 demoModel}, Cmd.map (DemoMsg << Demo40) demoCmd)
            Demo41 _ -> let (demoModel, demoCmd) = Grp41.init in ( { model | demo = Demo41 demoModel}, Cmd.map (DemoMsg << Demo41) demoCmd)
            Demo42 _ -> let (demoModel, demoCmd) = Grp42.init in ( { model | demo = Demo42 demoModel}, Cmd.map (DemoMsg << Demo42) demoCmd)
            Demo43 _ -> let (demoModel, demoCmd) = Grp43.init in ( { model | demo = Demo43 demoModel}, Cmd.map (DemoMsg << Demo43) demoCmd)
            Demo44 _ -> let (demoModel, demoCmd) = Grp44.init in ( { model | demo = Demo44 demoModel}, Cmd.map (DemoMsg << Demo44) demoCmd)

            NoDemo ->
              (model,Cmd.none)

        DemoMsg demoMsg ->
          case (demoMsg, model.demo) of
            (Demo1 dMsg, Demo1 dModel) ->
              let
                  (newModel, newCmd) = Grp1.update dMsg dModel
              in
                  ({ model | demo = Demo1 newModel }, Cmd.map (DemoMsg << Demo1) newCmd)
            --Prelude> putStrLn $ unlines ["                  (Demo"++show i++" dMsg, Demo"++show i++" dModel) -> let (newModel, newCmd) = Grp"++show i++".update dMsg dModel in ({ model | demo = Demo"++show i++" newModel }, Cmd.map (DemoMsg << Demo"++show i++") newCmd)" | i <- [2..44]]
            (Demo2 dMsg, Demo2 dModel) -> let (newModel, newCmd) = Grp2.update dMsg dModel in ({ model | demo = Demo2 newModel }, Cmd.map (DemoMsg << Demo2) newCmd)
            (Demo3 dMsg, Demo3 dModel) -> let (newModel, newCmd) = Grp3.update dMsg dModel in ({ model | demo = Demo3 newModel }, Cmd.map (DemoMsg << Demo3) newCmd)
            (Demo4 dMsg, Demo4 dModel) -> let (newModel, newCmd) = Grp4.update dMsg dModel in ({ model | demo = Demo4 newModel }, Cmd.map (DemoMsg << Demo4) newCmd)
            (Demo5 dMsg, Demo5 dModel) -> let (newModel, newCmd) = Grp5.update dMsg dModel in ({ model | demo = Demo5 newModel }, Cmd.map (DemoMsg << Demo5) newCmd)
            (Demo6 dMsg, Demo6 dModel) -> let (newModel, newCmd) = Grp6.update dMsg dModel in ({ model | demo = Demo6 newModel }, Cmd.map (DemoMsg << Demo6) newCmd)
            (Demo7 dMsg, Demo7 dModel) -> let (newModel, newCmd) = Grp7.update dMsg dModel in ({ model | demo = Demo7 newModel }, Cmd.map (DemoMsg << Demo7) newCmd)
            (Demo8 dMsg, Demo8 dModel) -> let (newModel, newCmd) = Grp8.update dMsg dModel in ({ model | demo = Demo8 newModel }, Cmd.map (DemoMsg << Demo8) newCmd)
            (Demo9 dMsg, Demo9 dModel) -> let (newModel, newCmd) = Grp9.update dMsg dModel in ({ model | demo = Demo9 newModel }, Cmd.map (DemoMsg << Demo9) newCmd)
            (Demo10 dMsg, Demo10 dModel) -> let (newModel, newCmd) = Grp10.update dMsg dModel in ({ model | demo = Demo10 newModel }, Cmd.map (DemoMsg << Demo10) newCmd)
            (Demo11 dMsg, Demo11 dModel) -> let (newModel, newCmd) = Grp11.update dMsg dModel in ({ model | demo = Demo11 newModel }, Cmd.map (DemoMsg << Demo11) newCmd)
            (Demo12 dMsg, Demo12 dModel) -> let (newModel, newCmd) = Grp12.update dMsg dModel in ({ model | demo = Demo12 newModel }, Cmd.map (DemoMsg << Demo12) newCmd)
            (Demo13 dMsg, Demo13 dModel) -> let (newModel, newCmd) = Grp13.update dMsg dModel in ({ model | demo = Demo13 newModel }, Cmd.map (DemoMsg << Demo13) newCmd)
            (Demo14 dMsg, Demo14 dModel) -> let (newModel, newCmd) = Grp14.update dMsg dModel in ({ model | demo = Demo14 newModel }, Cmd.map (DemoMsg << Demo14) newCmd)
            (Demo15 dMsg, Demo15 dModel) -> let (newModel, newCmd) = Grp15.update dMsg dModel in ({ model | demo = Demo15 newModel }, Cmd.map (DemoMsg << Demo15) newCmd)
            (Demo16 dMsg, Demo16 dModel) -> let (newModel, newCmd) = Grp16.update dMsg dModel in ({ model | demo = Demo16 newModel }, Cmd.map (DemoMsg << Demo16) newCmd)
            (Demo17 dMsg, Demo17 dModel) -> let (newModel, newCmd) = Grp17.update dMsg dModel in ({ model | demo = Demo17 newModel }, Cmd.map (DemoMsg << Demo17) newCmd)
            (Demo18 dMsg, Demo18 dModel) -> let (newModel, newCmd) = Grp18.update dMsg dModel in ({ model | demo = Demo18 newModel }, Cmd.map (DemoMsg << Demo18) newCmd)
            (Demo19 dMsg, Demo19 dModel) -> let (newModel, newCmd) = Grp19.update dMsg dModel in ({ model | demo = Demo19 newModel }, Cmd.map (DemoMsg << Demo19) newCmd)
            (Demo20 dMsg, Demo20 dModel) -> let (newModel, newCmd) = Grp20.update dMsg dModel in ({ model | demo = Demo20 newModel }, Cmd.map (DemoMsg << Demo20) newCmd)
            (Demo21 dMsg, Demo21 dModel) -> let (newModel, newCmd) = Grp21.update dMsg dModel in ({ model | demo = Demo21 newModel }, Cmd.map (DemoMsg << Demo21) newCmd)
            (Demo22 dMsg, Demo22 dModel) -> let (newModel, newCmd) = Grp22.update dMsg dModel in ({ model | demo = Demo22 newModel }, Cmd.map (DemoMsg << Demo22) newCmd)
            (Demo23 dMsg, Demo23 dModel) -> let (newModel, newCmd) = Grp23.update dMsg dModel in ({ model | demo = Demo23 newModel }, Cmd.map (DemoMsg << Demo23) newCmd)
            (Demo24 dMsg, Demo24 dModel) -> let (newModel, newCmd) = Grp24.update dMsg dModel in ({ model | demo = Demo24 newModel }, Cmd.map (DemoMsg << Demo24) newCmd)
            (Demo25 dMsg, Demo25 dModel) -> let (newModel, newCmd) = Grp25.update dMsg dModel in ({ model | demo = Demo25 newModel }, Cmd.map (DemoMsg << Demo25) newCmd)
            (Demo26 dMsg, Demo26 dModel) -> let (newModel, newCmd) = Grp26.update dMsg dModel in ({ model | demo = Demo26 newModel }, Cmd.map (DemoMsg << Demo26) newCmd)
            (Demo27 dMsg, Demo27 dModel) -> let (newModel, newCmd) = Grp27.update dMsg dModel in ({ model | demo = Demo27 newModel }, Cmd.map (DemoMsg << Demo27) newCmd)
            (Demo28 dMsg, Demo28 dModel) -> let (newModel, newCmd) = Grp28.update dMsg dModel in ({ model | demo = Demo28 newModel }, Cmd.map (DemoMsg << Demo28) newCmd)
            (Demo29 dMsg, Demo29 dModel) -> let (newModel, newCmd) = Grp29.update dMsg dModel in ({ model | demo = Demo29 newModel }, Cmd.map (DemoMsg << Demo29) newCmd)
            (Demo30 dMsg, Demo30 dModel) -> let (newModel, newCmd) = Grp30.update dMsg dModel in ({ model | demo = Demo30 newModel }, Cmd.map (DemoMsg << Demo30) newCmd)
            (Demo31 dMsg, Demo31 dModel) -> let (newModel, newCmd) = Grp31.update dMsg dModel in ({ model | demo = Demo31 newModel }, Cmd.map (DemoMsg << Demo31) newCmd)
            (Demo32 dMsg, Demo32 dModel) -> let (newModel, newCmd) = Grp32.update dMsg dModel in ({ model | demo = Demo32 newModel }, Cmd.map (DemoMsg << Demo32) newCmd)
            (Demo33 dMsg, Demo33 dModel) -> let (newModel, newCmd) = Grp33.update dMsg dModel in ({ model | demo = Demo33 newModel }, Cmd.map (DemoMsg << Demo33) newCmd)
            (Demo34 dMsg, Demo34 dModel) -> let (newModel, newCmd) = Grp34.update dMsg dModel in ({ model | demo = Demo34 newModel }, Cmd.map (DemoMsg << Demo34) newCmd)
            (Demo35 dMsg, Demo35 dModel) -> let (newModel, newCmd) = Grp35.update dMsg dModel in ({ model | demo = Demo35 newModel }, Cmd.map (DemoMsg << Demo35) newCmd)
            (Demo36 dMsg, Demo36 dModel) -> let (newModel, newCmd) = Grp36.update dMsg dModel in ({ model | demo = Demo36 newModel }, Cmd.map (DemoMsg << Demo36) newCmd)
            (Demo37 dMsg, Demo37 dModel) -> let (newModel, newCmd) = Grp37.update dMsg dModel in ({ model | demo = Demo37 newModel }, Cmd.map (DemoMsg << Demo37) newCmd)
            (Demo38 dMsg, Demo38 dModel) -> let (newModel, newCmd) = Grp38.update dMsg dModel in ({ model | demo = Demo38 newModel }, Cmd.map (DemoMsg << Demo38) newCmd)
            (Demo39 dMsg, Demo39 dModel) -> let (newModel, newCmd) = Grp39.update dMsg dModel in ({ model | demo = Demo39 newModel }, Cmd.map (DemoMsg << Demo39) newCmd)
            (Demo40 dMsg, Demo40 dModel) -> let (newModel, newCmd) = Grp40.update dMsg dModel in ({ model | demo = Demo40 newModel }, Cmd.map (DemoMsg << Demo40) newCmd)
            (Demo41 dMsg, Demo41 dModel) -> let (newModel, newCmd) = Grp41.update dMsg dModel in ({ model | demo = Demo41 newModel }, Cmd.map (DemoMsg << Demo41) newCmd)
            (Demo42 dMsg, Demo42 dModel) -> let (newModel, newCmd) = Grp42.update dMsg dModel in ({ model | demo = Demo42 newModel }, Cmd.map (DemoMsg << Demo42) newCmd)
            (Demo43 dMsg, Demo43 dModel) -> let (newModel, newCmd) = Grp43.update dMsg dModel in ({ model | demo = Demo43 newModel }, Cmd.map (DemoMsg << Demo43) newCmd)
            (Demo44 dMsg, Demo44 dModel) -> let (newModel, newCmd) = Grp44.update dMsg dModel in ({ model | demo = Demo44 newModel }, Cmd.map (DemoMsg << Demo44) newCmd)

            otherwise ->
              (model,Cmd.none) -- got message from the wrong demo (impossible)

        Tick t ->
            case model.demo of
              NoDemo -> ({ model | time = t }, Cmd.none)
              Demo1 dModel -> let (newModel, newCmd) = Grp1.update (Grp1.Tick t) dModel in ({ model | demo = Demo1 newModel }, Cmd.map (DemoMsg << Demo1) newCmd)
              Demo2 dModel -> let (newModel, newCmd) = Grp2.update (Grp2.Tick t) dModel in ({ model | demo = Demo2 newModel }, Cmd.map (DemoMsg << Demo2) newCmd)
              Demo3 dModel -> let (newModel, newCmd) = Grp3.update (Grp3.Tick t) dModel in ({ model | demo = Demo3 newModel }, Cmd.map (DemoMsg << Demo3) newCmd)
              Demo4 dModel -> let (newModel, newCmd) = Grp4.update (Grp4.Tick t) dModel in ({ model | demo = Demo4 newModel }, Cmd.map (DemoMsg << Demo4) newCmd)
              Demo5 dModel -> let (newModel, newCmd) = Grp5.update (Grp5.Tick t) dModel in ({ model | demo = Demo5 newModel }, Cmd.map (DemoMsg << Demo5) newCmd)
              Demo6 dModel -> let (newModel, newCmd) = Grp6.update (Grp6.Tick t) dModel in ({ model | demo = Demo6 newModel }, Cmd.map (DemoMsg << Demo6) newCmd)
              Demo7 dModel -> let (newModel, newCmd) = Grp7.update (Grp7.Tick t) dModel in ({ model | demo = Demo7 newModel }, Cmd.map (DemoMsg << Demo7) newCmd)
              Demo8 dModel -> let (newModel, newCmd) = Grp8.update (Grp8.Tick t) dModel in ({ model | demo = Demo8 newModel }, Cmd.map (DemoMsg << Demo8) newCmd)
              Demo9 dModel -> let (newModel, newCmd) = Grp9.update (Grp9.Tick t) dModel in ({ model | demo = Demo9 newModel }, Cmd.map (DemoMsg << Demo9) newCmd)
              Demo10 dModel -> let (newModel, newCmd) = Grp10.update (Grp10.Tick t) dModel in ({ model | demo = Demo10 newModel }, Cmd.map (DemoMsg << Demo10) newCmd)
              Demo11 dModel -> let (newModel, newCmd) = Grp11.update (Grp11.Tick t) dModel in ({ model | demo = Demo11 newModel }, Cmd.map (DemoMsg << Demo11) newCmd)
              Demo12 dModel -> let (newModel, newCmd) = Grp12.update (Grp12.Tick t) dModel in ({ model | demo = Demo12 newModel }, Cmd.map (DemoMsg << Demo12) newCmd)
              Demo13 dModel -> let (newModel, newCmd) = Grp13.update (Grp13.Tick t) dModel in ({ model | demo = Demo13 newModel }, Cmd.map (DemoMsg << Demo13) newCmd)
              Demo14 dModel -> let (newModel, newCmd) = Grp14.update (Grp14.Tick t) dModel in ({ model | demo = Demo14 newModel }, Cmd.map (DemoMsg << Demo14) newCmd)
              Demo15 dModel -> let (newModel, newCmd) = Grp15.update (Grp15.Tick t) dModel in ({ model | demo = Demo15 newModel }, Cmd.map (DemoMsg << Demo15) newCmd)
              Demo16 dModel -> let (newModel, newCmd) = Grp16.update (Grp16.Tick t) dModel in ({ model | demo = Demo16 newModel }, Cmd.map (DemoMsg << Demo16) newCmd)
              Demo17 dModel -> let (newModel, newCmd) = Grp17.update (Grp17.Tick t) dModel in ({ model | demo = Demo17 newModel }, Cmd.map (DemoMsg << Demo17) newCmd)
              Demo18 dModel -> let (newModel, newCmd) = Grp18.update (Grp18.Tick t) dModel in ({ model | demo = Demo18 newModel }, Cmd.map (DemoMsg << Demo18) newCmd)
              Demo19 dModel -> let (newModel, newCmd) = Grp19.update (Grp19.Tick t) dModel in ({ model | demo = Demo19 newModel }, Cmd.map (DemoMsg << Demo19) newCmd)
              Demo20 dModel -> let (newModel, newCmd) = Grp20.update (Grp20.Tick t) dModel in ({ model | demo = Demo20 newModel }, Cmd.map (DemoMsg << Demo20) newCmd)
              Demo21 dModel -> let (newModel, newCmd) = Grp21.update (Grp21.Tick t) dModel in ({ model | demo = Demo21 newModel }, Cmd.map (DemoMsg << Demo21) newCmd)
              Demo22 dModel -> let (newModel, newCmd) = Grp22.update (Grp22.Tick t) dModel in ({ model | demo = Demo22 newModel }, Cmd.map (DemoMsg << Demo22) newCmd)
              Demo23 dModel -> let (newModel, newCmd) = Grp23.update (Grp23.Tick t) dModel in ({ model | demo = Demo23 newModel }, Cmd.map (DemoMsg << Demo23) newCmd)
              Demo24 dModel -> let (newModel, newCmd) = Grp24.update (Grp24.Tick t) dModel in ({ model | demo = Demo24 newModel }, Cmd.map (DemoMsg << Demo24) newCmd)
              Demo25 dModel -> let (newModel, newCmd) = Grp25.update (Grp25.Tick t) dModel in ({ model | demo = Demo25 newModel }, Cmd.map (DemoMsg << Demo25) newCmd)
              Demo26 dModel -> let (newModel, newCmd) = Grp26.update (Grp26.Tick t) dModel in ({ model | demo = Demo26 newModel }, Cmd.map (DemoMsg << Demo26) newCmd)
              Demo27 dModel -> let (newModel, newCmd) = Grp27.update (Grp27.Tick t) dModel in ({ model | demo = Demo27 newModel }, Cmd.map (DemoMsg << Demo27) newCmd)
              Demo28 dModel -> let (newModel, newCmd) = Grp28.update (Grp28.Tick t) dModel in ({ model | demo = Demo28 newModel }, Cmd.map (DemoMsg << Demo28) newCmd)
              Demo29 dModel -> let (newModel, newCmd) = Grp29.update (Grp29.Tick t) dModel in ({ model | demo = Demo29 newModel }, Cmd.map (DemoMsg << Demo29) newCmd)
              Demo30 dModel -> let (newModel, newCmd) = Grp30.update (Grp30.Tick t) dModel in ({ model | demo = Demo30 newModel }, Cmd.map (DemoMsg << Demo30) newCmd)
              Demo31 dModel -> let (newModel, newCmd) = Grp31.update (Grp31.Tick t) dModel in ({ model | demo = Demo31 newModel }, Cmd.map (DemoMsg << Demo31) newCmd)
              Demo32 dModel -> let (newModel, newCmd) = Grp32.update (Grp32.Tick t) dModel in ({ model | demo = Demo32 newModel }, Cmd.map (DemoMsg << Demo32) newCmd)
              Demo33 dModel -> let (newModel, newCmd) = Grp33.update (Grp33.Tick t) dModel in ({ model | demo = Demo33 newModel }, Cmd.map (DemoMsg << Demo33) newCmd)
              Demo34 dModel -> let (newModel, newCmd) = Grp34.update (Grp34.Tick t) dModel in ({ model | demo = Demo34 newModel }, Cmd.map (DemoMsg << Demo34) newCmd)
              Demo35 dModel -> let (newModel, newCmd) = Grp35.update (Grp35.Tick t) dModel in ({ model | demo = Demo35 newModel }, Cmd.map (DemoMsg << Demo35) newCmd)
              Demo36 dModel -> let (newModel, newCmd) = Grp36.update (Grp36.Tick t) dModel in ({ model | demo = Demo36 newModel }, Cmd.map (DemoMsg << Demo36) newCmd)
              Demo37 dModel -> let (newModel, newCmd) = Grp37.update (Grp37.Tick t) dModel in ({ model | demo = Demo37 newModel }, Cmd.map (DemoMsg << Demo37) newCmd)
              Demo38 dModel -> let (newModel, newCmd) = Grp38.update (Grp38.Tick t) dModel in ({ model | demo = Demo38 newModel }, Cmd.map (DemoMsg << Demo38) newCmd)
              Demo39 dModel -> let (newModel, newCmd) = Grp39.update (Grp39.Tick t) dModel in ({ model | demo = Demo39 newModel }, Cmd.map (DemoMsg << Demo39) newCmd)
              Demo40 dModel -> let (newModel, newCmd) = Grp40.update (Grp40.Tick t) dModel in ({ model | demo = Demo40 newModel }, Cmd.map (DemoMsg << Demo40) newCmd)
              Demo41 dModel -> let (newModel, newCmd) = Grp41.update (Grp41.Tick t) dModel in ({ model | demo = Demo41 newModel }, Cmd.map (DemoMsg << Demo41) newCmd)
              Demo42 dModel -> let (newModel, newCmd) = Grp42.update (Grp42.Tick t) dModel in ({ model | demo = Demo42 newModel }, Cmd.map (DemoMsg << Demo42) newCmd)
              Demo43 dModel -> let (newModel, newCmd) = Grp43.update (Grp43.Tick t) dModel in ({ model | demo = Demo43 newModel }, Cmd.map (DemoMsg << Demo43) newCmd)
              Demo44 dModel -> let (newModel, newCmd) = Grp44.update (Grp44.Tick t) dModel in ({ model | demo = Demo44 newModel }, Cmd.map (DemoMsg << Demo44) newCmd)

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

iconWidth = 128
iconHeight = 64

slopeIntercept slope intercept =
  let
    firstPoint = (-64, -64 * slope + intercept)
    lastPoint = (64, 64 * slope + intercept)



  in
      [ rect 0.25 iconHeight |> filled black
      , rect iconWidth 0.25 |> filled black
      , line firstPoint lastPoint |> outlined (solid 0.5) (rgb 0 0 255)
      ]




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
            [ mainContent model
            ]
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

modalVisibility : Int -> Dict Int Modal.Visibility -> Modal.Visibility
modalVisibility n d =
    Maybe.withDefault Modal.hidden (Dict.get n d)

type alias Flags =
    {}

main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChange
        }
{-endviewable-}
