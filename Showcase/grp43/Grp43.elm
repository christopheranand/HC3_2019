-- change your group number
module Grp43 exposing (Model,view,update,Msg(..),init,keywords,title,authors)


import Html exposing (Html)
import Html.Attributes exposing (..)

import GraphicSVG exposing(..)
import GraphicSVG.Widget as Widget

-- change to your group number
import GameSlot43 as GameSlot

-- change keywords, etc
keywords : List String
keywords = ["~~put keywords for search here~~"]
title : String
title = ""
authors : List String
authors = ["Max Mercer","Gregory Kitching","Koushik Ghosh"]

-- you should not have to change anything below here ---

view : Model -> List (Html Msg)
view model =
    [ Html.div [ style "margin" "1%" ]
        [ Html.div [style "display" "flex", style "flex-direction" "row"]
            [ Html.div [style "width" "100%"] -- change the width of the icon
                [
                    Widget.view model.widget0
                        (
                            GameSlot.myShapes model.gameSlot
                              |> List.map (GraphicSVG.map GameSlotMsg)
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
    { widget0 : Widget.Model -- contains state about display of widget
    , gameSlot : GameSlot.Model -- Nothing = bad input, Just = acceptable value
    }

type Msg
    = Tick Float

    | Widget0Msg (Widget.Msg)

    | GameSlotMsg GameSlot.Msg

init : ( Model, Cmd Msg )
init  =
    let
        (wstate0, wcmd0) = Widget.init iconWidth iconHeight "widget0"


        model =           { widget0 = wstate0
                          , gameSlot = GameSlot.init
                          }
    in
        ( model, Cmd.map Widget0Msg wcmd0)

iconWidth = 196
iconHeight = 128

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Widget0Msg wMsg ->
            let
                (newWState, wCmd) = Widget.update wMsg model.widget0
            in
                ({ model | widget0 = newWState }
                , Cmd.map Widget0Msg wCmd)

        GameSlotMsg gsMsg -> ( { model | gameSlot = GameSlot.update gsMsg model.gameSlot }, Cmd.none )

        Tick t -> ({ model | gameSlot = GameSlot.update (GameSlot.Tick t ()) model.gameSlot }, Cmd.none)
