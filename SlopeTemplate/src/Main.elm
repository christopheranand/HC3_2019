{-
-}
module Main exposing (main)

--import Debug



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
import GraphicSVG.Widget exposing (icon)

import Dict
import Set
import List.Extra as List


{-headerWeb Page Creator.-}

{-Editable-}
--this appears at the top of the browser screen (or on the tab)
title : String
title = "My Name's Resume"

page : Model -> List (Html Msg)
page model =
    [ Html.div [ style "margin" "1%" ]
        [ CDN.stylesheet
        , Html.node "link" [ attribute "rel" "stylesheet", attribute "crossorigin" "anonymous", href "https://use.fontawesome.com/releases/v5.7.2/css/all.css" ] []
        , Html.h1 [] [ Html.text "Plot slope and intercept." ]
        , Html.div [style "display" "flex", style "flex-direction" "row"]
            [ Html.div [style "width" "100%"] -- change the width of the icon
                [
                    icon "myIcon" iconWidth iconHeight
                        (
                            case (model.slope,model.intercept) of
                              (Just slope,Just intercept) -> slopeIntercept slope intercept
                              otherwise -> [text "I need slope and intercept." |> centered |> filled purple]
                        )
                ]
            ]
        , Grid.row []
          [ Grid.col [Col.xs3] [Html.text "slope"]
          , Grid.col [Col.xs3] [Html.text "intercept"]
          ]
        , Grid.row []
          [ Grid.col [Col.xs3]
              [ Input.text <| [ Input.attrs [ placeholder "slope", style "width" "90px"]
                               , Input.onInput NewSlope
                               ]
                               ++
                               ( case model.slope of
                                   Just _ -> []
                                   Nothing -> [Input.danger]
                               )
              ]
          , Grid.col [Col.xs3]
              [ Input.text <| [ Input.attrs [ placeholder "intercept", style "width" "90px"]
                              , Input.onInput NewIntercept
                              ]
                              ++
                              ( case model.slope of
                                  Just _ -> []
                                  Nothing -> [Input.danger]
                              )
             ]
          ]
        ]





      , Html.div []
        [Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick <| ShowModal 0, style "color" "black" ]
            ]
            [ Html.text "Open Pop-Up" ]

        , Modal.config (CloseModal 0)
            |> Modal.small
            |> Modal.hideOnBackdropClick True
            |> Modal.h3 [] [ Html.text "Pop-up header" ]
            |> Modal.body [] [ Html.p [] [ Html.text "I'm obscuring the plot."] ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick (CloseModal 0), style "color" "blue" ]
                    ]
                    [ Html.text "Close" ]
                ]
            |> Modal.view (modalVisibility 0 model.modalVisibilities)
        ]
        , Html.div []
        [Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick <| ShowModal 1, style "color" "black" ]
            ]
            [ Html.text "Open Another Pop-Up" ]

        --To add another pop-up, you must increase the numPopUps, and include a unique id for each one
        , Modal.config (CloseModal 1)
            |> Modal.small
            |> Modal.hideOnBackdropClick True
            |> Modal.h3 [] [ Html.text "Pop-up header" ]
            |> Modal.body [] [ Html.p [] [ Html.text "Keep on plotting.  Keep on plotting."] ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick (CloseModal 1), style "color" "blue" ]
                    ]
                    [ Html.text "Close" ]
                ]
            |> Modal.view (modalVisibility 1 model.modalVisibilities)
        ]

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
    , modalVisibilities : Dict Int Modal.Visibility -- ADD MODAL
    -- PUT YOUR MODEL VALUES HERE
    , slope : Maybe Float -- Nothing = bad input, Just = acceptable value
    , intercept : Maybe Float -- Nothing = bad input, Just = acceptable value
    }

type Page
    = Home
    | NotFound


type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State
    | NoOp
    | CloseModal Int
    | ShowModal Int
    | Tick Float

    | NewSlope String
    | NewIntercept String

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
                          , modalVisibilities = Dict.fromList <| List.map (\n -> (n,Modal.hidden)) (List.range 0 (numPopUps-1))
                          , slope = Nothing
                          , intercept = Nothing
                          }
    in
        ( model, Cmd.batch [ urlCmd, navCmd ] )



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [Navbar.subscriptions model.navState NavMsg
    , onAnimationFrame ( \ posix -> Tick ((Time.posixToMillis posix |> toFloat) * 0.001) )
    ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewSlope txt -> ( { model | slope = String.toFloat txt }, Cmd.none )

        NewIntercept txt ->
          ( { model | intercept = case String.toFloat txt of
                                    Nothing -> Nothing
                                    Just value -> if value < 30 && value > -30
                                                  then Just value
                                                  else Nothing
            }
          , Cmd.none )
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

        --ADD MODAL
        CloseModal id ->
            ( { model | modalVisibilities = Dict.insert id Modal.hidden model.modalVisibilities } , Cmd.none )

        ShowModal id ->
            ( { model | modalVisibilities = Dict.insert id Modal.shown model.modalVisibilities } , Cmd.none )

        Tick t -> ({ model | time = t }, Cmd.none)

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
        ,  Html.div [style "width" "25%"] -- change the width of the icon
            [
                icon "myIcon" 50 50
                    [
                        group [ circle 10 |> filled red
                              , polygon [(1,0), (-1,0), (0,7)] |> filled yellow |> rotate (-model.time * 2 * pi / 2160)
                              , polygon [(1,0), (-1,0), (0,9)] |> filled yellow |> rotate (-model.time * 2 * pi / 360)
                              , polygon [(0.5,0), (-0.5,0), (0,10)] |> filled yellow |> rotate (-model.time * 2 * pi / 60)
                              ]
                    ]
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
