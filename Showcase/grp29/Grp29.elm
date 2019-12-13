-- change your group number TODO


module Grp29 exposing (Model, Msg(..), authors, init, keywords, title, update, view)

-- change to your group number TODO

import GameSlot29 as GameSlot
import GraphicSVG exposing (..)
import GraphicSVG.Widget as Widget
import Html exposing (Html)
import Html.Attributes exposing (..)
import List
import String
import Dict exposing (Dict)



-- change keywords, etc TODO


keywords : List String
keywords =
    [ "~~put keywords for search here~~" ]


title : String
title =
    ""


authors : List String
authors =
    [ "" ]



-- you should not have to change anything below here ---


view : Model -> List (Html Msg)
view model =
    [ Html.div [ style "margin" "1%" ]
        [ Html.div [ style "display" "flex", style "flex-direction" "row" ]
            [ Html.div [ style "width" "100%" ]
                -- change the width of the icon
                [ Widget.view model.widget0
                    (GameSlot.myShapes model.gameSlot
                        |> List.map (GraphicSVG.map GameSlotMsg)
                    )
                ]
            ]
        ]
    ]



type alias Model =
    { widget0 : Widget.Model -- contains state about display of widget
    , gameSlot : GameSlot.Model -- Nothing = bad input, Just = acceptable value
    }


type Msg
    = Tick Float
    | Widget0Msg Widget.Msg
    | GameSlotMsg GameSlot.Msg


init : ( Model, Cmd Msg )
init =
    let
        ( wstate0, wcmd0 ) =
            Widget.init iconWidth iconHeight "widget0"

        model =
            { widget0 = wstate0
            , gameSlot = GameSlot.init
            }
    in
    ( model, Cmd.map Widget0Msg wcmd0 )


iconWidth =
    196


iconHeight =
    128


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Widget0Msg wMsg ->
            let
                ( newWState, wCmd ) =
                    Widget.update wMsg model.widget0
            in
            ( { model | widget0 = newWState }
            , Cmd.map Widget0Msg wCmd
            )

        GameSlotMsg gsMsg ->
            ( { model | gameSlot = GameSlot.update gsMsg model.gameSlot }, Cmd.none )

        Tick t ->
            ( { model | gameSlot = GameSlot.update (GameSlot.Tick t ()) model.gameSlot }, Cmd.none )
