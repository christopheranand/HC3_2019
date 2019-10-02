{- Paste this code input slot 0 or 1 of type </>
   Modify the code so that when you paste or type text into the text area, the bar chart shows the word count of the top 20 words.
   Add a scale.
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
import Debug
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Set

--this appears at the top of the browser screen (or on the tab)

title : String
title = "Word Count"

iconWidth = 128
iconHeight = 64

barChart wordCounts time =
  let
    numWords = List.length wordCounts
    maxCount = List.maximum (List.map Tuple.first wordCounts) |> Maybe.withDefault 10
    scaleHeight = iconHeight / toFloat maxCount

    width = iconWidth / toFloat numWords

    growHeight y = if y < time then y else time

    bar idx (count,word) =
        group [ GraphicSVG.rect width (growHeight <| scaleHeight * toFloat count)
                  |> filled (rgb 200 0 200)
                  |> move (0,0.5 * growHeight ( scaleHeight * toFloat count ) )
              , GraphicSVG.text word |> GraphicSVG.size 5
                  |> filled white
                  |> rotate (degrees 90)
                  |> move (0,3)
              ]
          |> move ( toFloat idx * width - 0.5 * iconWidth + 0.5 * width
                  , -0.5 * toFloat iconHeight)


  in
      [ -- put a scale here
      ]
      ++ (List.indexedMap bar wordCounts)
            |> group

-- END of included import

page : Model -> List (Html Msg)
page model =
    [ div [ style "margin" "1%" ]
        [ CDN.stylesheet
        , Html.node "link" [ attribute "rel" "stylesheet", attribute "crossorigin" "anonymous", href "https://use.fontawesome.com/releases/v5.7.2/css/all.css" ] []
        , h1 [] [ Html.text "Count Words." ]
        , Html.div [style "display" "flex", style "flex-direction" "row"]
            [ Html.div [style "width" "100%"] -- change the width of the icon
                [
                    icon NoOp "myIcon" iconWidth iconHeight
                        [
                            barChart model.wordCounts (10 * (model.time - model.timeOfInput))
                        ]
                ]
            ]
        , Html.div []
            [Form.form []
              [ Form.group []
                  [ Form.label [ for "myarea"] [ Html.text "My textarea"]
                  , Textarea.textarea
                      [ Textarea.id "myarea"
                      , Textarea.rows 10
                      , Textarea.onInput NewText
                      ]
                  ]
              ]
            ]
         ]
     ]

type alias Model =
    { navKey : Navigation.Key
    , page : Page
    , time : Float
    , timeOfInput : Float
    , navState : Navbar.State
    , wordCounts : List (Int,String)
    }

type Page
    = Home
    | NotFound


type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State
    | NoOp
    | Tick Float
    | NewText String

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
                          , wordCounts = [(5,"tree"),(10,"rock")]
                          }
    in
        ( model, Cmd.batch [ urlCmd, navCmd ] )



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [onAnimationFrame ( \ posix -> Tick ((Time.posixToMillis posix |> toFloat) * 0.001) )
         ]


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

        NewText txt -> ( {model | wordCounts = List.indexedMap ( \ idx wrd -> (idx,wrd) )
                                                 <| String.words txt
                                , timeOfInput = model.time }, Cmd.none)

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
