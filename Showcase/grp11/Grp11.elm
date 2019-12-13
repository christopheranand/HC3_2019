-- change your group number TODO


module Grp11 exposing (Model, Msg(..), authors, init, keywords, title, update, view)

-- change to your group number TODO

import WebSlot11 as WebSlot
import GraphicSVG exposing (..)
import GraphicSVG.Widget as Widget
import Html exposing (Html)
import Html.Attributes exposing (..)
import WebExtra exposing (Flags)
import Browser.Navigation as Navigation
import Url exposing (Url)



-- change keywords, etc TODO


title : String
title = "Cross Product"

keywords : List String
keywords = ["Cross Product", "Group 25"]

authors : List String
authors =
    [ "Bowen Yuan","Tim Zhang","Jeffrey Sun","Tongfei Wang"]


-- you should not have to change anything below here ---


view : Model -> List (Html Msg)
view model =
    [ Html.div [ style "margin" "1%" ]
        [ Html.div [ style "display" "flex", style "flex-direction" "row" ]
            [ Html.div [ style "width" "100%" ]
                -- change the width of the icon
                ( List.map (Html.map WebSlotMsg) <| WebSlot.page model.webSlot
                )
            ]
        ]
    ]



type alias Model =
    { webSlot : WebSlot.Model -- Nothing = bad input, Just = acceptable value
    }


type Msg
    = Tick Float
    | WebSlotMsg WebSlot.Msg


init : Navigation.Key -> Url -> ( Model, Cmd Msg )
init key url =
    let
        ( wstate0, wcmd0 ) =
            WebSlot.init {} url key

        model =
            { webSlot = wstate0
            }
    in
    ( model, Cmd.map WebSlotMsg wcmd0 )


iconWidth =
    196


iconHeight =
    128


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WebSlotMsg gsMsg ->
          let
              ( wstate0, wcmd0 ) =
                  WebSlot.update gsMsg model.webSlot
          in
              ( { model | webSlot = wstate0 }, Cmd.map WebSlotMsg wcmd0 )

        Tick t ->
          let
              ( wstate0, wcmd0 ) =
                  WebSlot.update (WebSlot.Tick t) model.webSlot
          in
              ( { model | webSlot = wstate0 }, Cmd.map WebSlotMsg wcmd0 )

{-viewable

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
endviewable-}
