{-
-}
module Grp1 exposing (Model,view,update,Msg(..),init,keywords,title,authors)

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

keywords : List String
keywords = ["~~put keywords for search here~~"]
title : String
title = ""
authors : List String
authors = []

view : Model -> List (Html Msg)
view model =
    [ Html.div [ style "margin" "1%" ]
        [ Html.h1 [] [ Html.text "Hey, this is Group 1." ]
        , Html.div [style "display" "flex", style "flex-direction" "row"]
            [ Html.div [style "width" "100%"] -- change the width of the icon
                [
                    Widget.view model.widget0
                        (
                            case (model.slope,model.intercept) of
                              (Just slope,Just intercept) -> slopeIntercept slope intercept
                              otherwise -> [ text "I need slope and intercept." |> centered |> filled purple
                                           , group [ roundedRect 20 10 4 |> filled (rgb 0 0 200)
                                                   , text "fix" |> centered |> GraphicSVG.size 5 |> filled white |> move (0,-1)
                                                   ]
                                               |> notifyTap FixSlopeIntercept
                                               |> move (0,-20)
                                           ]
                        )
                ]
            ]
        , Grid.row []
          [ Grid.col [Col.xs3] [Html.text "slope"]
          , Grid.col [Col.xs3] [Html.text "intercept"]
          ]
        , Grid.row []
          [ Grid.col [Col.xs3]
              [ Input.text <| [ Input.attrs ( case model.slope of
                                                Just sl -> [value (String.fromFloat sl), style "width" "90px"]
                                                Nothing -> [placeholder "slope", style "width" "90px"]
                                            )
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






    ]

{- The number of  pop ups.
   To add more than one, you must increase this number and then make sure to
   put the correct id in the code where you add it. The ids start at 0 and go up from there
   (0, 1, 2, 3, etc.)
-}
numPopUps = 1


type alias Model =
    { time : Float
    -- PUT YOUR MODEL VALUES HERE
    , widget0 : Widget.Model -- contains state about display of widget
    , slope : Maybe Float -- Nothing = bad input, Just = acceptable value
    , intercept : Maybe Float -- Nothing = bad input, Just = acceptable value
    }

type Msg
    = Tick Float

    | Widget0Msg (Widget.Msg)

    | FixSlopeIntercept

    | NewSlope String
    | NewIntercept String

init : ( Model, Cmd Msg )
init  =
    let
        (wstate0, wcmd0) = Widget.init iconWidth iconHeight "widget0"


        model =           { time = 0
                          , widget0 = wstate0
                          , slope = Nothing
                          , intercept = Nothing
                          }
    in
        ( model, Cmd.map Widget0Msg wcmd0)


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

        Tick t -> ({ model | time = t }, Cmd.none)


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
