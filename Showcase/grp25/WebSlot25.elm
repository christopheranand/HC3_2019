-- the only change you should need to make is to add these three lines (and change the group number) TODO


module WebSlot25 exposing (..)
import GraphicSVG exposing (..)
import WebExtra exposing (..)


--  below is code copied from a Web Slot
--module Grp25 exposing (Model,view,update,Msg(..),init,keywords,title,authors)

----GROUP 25
--Ibrahim Malik - 001043905
--Justin Zhou - 400032395
--Michelle Leung - 400083221
--Emilio Hajj - 001402245

-- The following code was deisgned and implemented by group 25 in efforts to solve
-- the learning problems that 2nd year science (non-engineering) students tend to face
-- when confronted with learning vectors and cross-product.
-- We have provided definitions, visual examples, quiz questions and solutions in efforts
-- to help them understand and learn the subject matter.


import Dict exposing (Dict)
import Bootstrap.Navbar as Navbar
import Browser.Navigation as Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import GraphicSVG exposing (..)
import Bootstrap.Accordion as Accordion
import Bootstrap.Modal as Modal
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Carousel as Carousel
import Url exposing (Url)
import Browser exposing (UrlRequest)
import Browser.Dom as Dom

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

--this appears at the top of the browser screen (or on the tab)


-- the following variables are for clarity and ease of coding for the sake of discoverability,
-- mapping, and the conceptual model

lg_emptyrow = Grid.row [] --this is a large empty row (to add empty space)
        [ Grid.col []
            [ Html.h6[Spacing.my5][] --change spacing number to make empty row bigger or smaller
            ]
        ]
sm_emptyrow = Grid.row [] --this is a small empty row (to add empty space)
        [ Grid.col []
            [ Html.h6[Spacing.my2][] --change spacing number to make empty row bigger or smaller
            ]
        ]
-- end of pre-declared variables

page : Model -> List (Html Msg)

-- The conceptual model requires us to generate various titles and text definitions to
-- provide a proper undertanding of the system to our target users
page model =
    [-- DEFINITION
    -- this section provides a brief brief definition about cross-prodcut

    --title
    Html.h3 [Spacing.mt5, Spacing.mb2, style "color" "black"] [ Html.text "Cross Product of two vectors" ]

    --definition title
    , Grid.row []
        [ Grid.col [Col.sm3] --increase number after sm to make this column bigger (range 1-12)
            [ Html.h5 [ style "font-weight" "bold"][ Html.text "Definition"]
            ]
        ]
    --definition
    , Grid.row []
        [ Grid.col [] --increase number after offsetSm to make the offset bigger (range 0-11)
            [ Html.text "In mathematics, the cross product or vector product (occasionally directed area product to emphasize the geometric significance) is a binary operation on two vectors in three-dimensional space  R^3 and is denoted by the symbol  x . Given two linearly independent vectors  a and  b, the cross product,  a ◊ b, is a vector that is perpendicular to both  a and  b and thus normal to the plane containing them."
            ]
        ]
    ,lg_emptyrow --add a large space

    --EDUCATION
    -- the section focuses on educating the users with brief examples

    , Html.h2 [Spacing.mt3, Spacing.mb2] [Html.text "Calculation & Examples"]
    -- adding a selectable text that can link the user to an external website for
    -- deeper learning purposes. It's an affordance and it is bolded and underlined
    -- for the sake of discoverability
    , Grid.row []
        [ Grid.col [Col.sm8] --increase number after sm to make this column bigger (range 1-12)
            [ --use 'a [target "_blank", href "link"] [text/picture]' to create a link
            Html.a [target "_blank", href "https://betterexplained.com/articles/cross-product/"] [Html.h5 [ style "font-weight" "bold"][ Html.text "Click me to see more"]]
            ]
        ]
    -- the following is a selectable graphic for visual learners
    , Grid.row []
        [ Grid.col []
            [Html.a [target "_blank", href "https://betterexplained.com/articles/cross-product/"] [Html.img [style "width" "250px", src "http://www.learningaboutelectronics.com/images/Cross-product-formula.png?fbclid=IwAR0UfQDbYv3fAb7NEl5koGWnlyf2wn5pn0M2QPTIO-n5Ies1v4dZohgBymo"] []]
            ]
        ]
    , sm_emptyrow --add a small space

    -- the following is a selectable graphic for visual learners
    , Grid.row []
        [ Grid.col []
            [Html.a [target "_blank", href "https://betterexplained.com/articles/cross-product/"] [Html.img [style "width" "350px", src "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQwvshP7cl-gkXyFrQohCGuaaq-WATNXx90zN_zsjCqYpCWJySV&s&fbclid=IwAR0sZNMGf03yLuWzSQiDf66573NU9T5V99B3bB7TQCF1u57TGcoz6jqBsec"] []]
            ]
        ]
    , lg_emptyrow --add a large space

    --ADD ACCORDION - edit what your accordion looks like

    -- The following code represents the quiz portion of the system
    , Html.h2 [Spacing.mt3, Spacing.mb2] [Html.text "Quizzes"]
    , Grid.row []
        [ Grid.col []
            [ Accordion.config (AccordionMsg 0) -- the ID number of the accordion
                |> Accordion.withAnimation
                |> Accordion.cards
                    [ Accordion.card
                        { id = "card1" --each accordion card needs an id
                        , options = []
                        --QUESTION 1
                        -- included is a toggle used to signify that it is selectable
                        , header =
                            Accordion.header [] <| Accordion.toggle [] [ Html.text "Question 1" ]
                        , blocks =
                            [ Accordion.block [] --the quiz question
                                [ Block.text [] [ Html.text "(1,2,3) " ]
                                ,Block.text [] [ Html.text "  x " ]
                                ,Block.text [] [ Html.text "(4,5,6)" ] ]
                            ]
                        }
                    , Accordion.card
                        { id = "card2"
                        , options = []
                        , header =
                            --QUESTION 2
                            -- included is a toggle used to signify that it is selectable
                            Accordion.header [] <| Accordion.toggle [] [ Html.text "Question 2" ]
                         ,blocks =
                            [ Accordion.block [] --the quiz question
                                [ Block.text [] [ Html.text "(-4,5,-11) " ]
                                ,Block.text [] [ Html.text "x " ]
                                ,Block.text [] [ Html.text "(2,-5,3)" ] ]
                            ]
                        }
                    , Accordion.card
                        { id = "card3"
                        , options = []
                        , header =
                            --QUESTION 3
                            -- included is a toggle used to signify that it is selectable
                            Accordion.header [] <| Accordion.toggle [] [ Html.text "Question 3" ]
                        , blocks =
                            [ Accordion.block [] --the quiz question
                                [ Block.text [] [ Html.text "(-2/3,5/7,1/2)" ]
                                ,Block.text [] [ Html.text "x" ]
                                ,Block.text [] [ Html.text "(1/2,1/4,3)" ] ]
                            ]
                        }
                     -- The following code represents the solutions portion of the system
                    , Accordion.card
                        { id = "card4"
                        , options = []
                        , header =
                            -- ANSWERS FOR ALL QUIZE QUESTIONS
                            -- included is a toggle used to signify that it is selectable
                            Accordion.header []
                                (Accordion.toggle [] [ Html.text " Answers for Quiz1  \n& Quiz 2  \n & Quiz 3"] )
                        , blocks =
                            [ Accordion.block []
                                [ Block.text [] [ Html.text "Quiz 1 = (-3, 6, -3)"]
                                 ,Block.text [] [ Html.text "Quiz 2 = (-40, -10, 10)"]
                                 ,Block.text [] [ Html.text "Quiz 3 = (113/56, 9/4, -11/21)"]
                                ]
                            ]

                        }
                    ]

                |> Accordion.view (accordionState 0 {-same id as above-} model.accordionStates)
            ]
        ]
        -- this is a carousel

        -- the following is step-by-step solutions to deepend a user's understanding
        -- each button is an affordance containing a solution. The buttons contain signifiers
        -- that makes the button turn green to signify that it is selectable.
        -- the following also abides by the principles of discoverability and mapping.
        , Html.h2 [] [Html.text "To see Answers step by step"]
      , Html.div []
        [Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick <| ShowModal 0, style "color" "black" ]
            ]
            --SOLUTION FOR QUIZ 1
            [ Html.text "Step-by-Step Solution for Quiz 1" ]

      , sm_emptyrow   --add small space

        , Modal.config (CloseModal 0)
            |> Modal.small
            |> Modal.hideOnBackdropClick True
            |> Modal.h3 [] [ Html.text "Step-by-Step Solution" ]
            |> Modal.body [] [ Html.p [] [ Html.text "(1,2,3) x (4,5,6) = ((2 x 6) - (3 x 5)), ((3 x 4) - (1 x 6)), ((1 x 5) - (2 x 4))  ", Html.text "= (-3, 6, -3)"] ]
            |> Modal.footer []
            -- to exit the pop-up solution 2 affordances are provided. An X in the top right
            -- and a 'close' button in the bottom right
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
            --SOLUTION FOR QUIZ 2
            [ Html.text "Step-by-Step Solution for Quiz 2" ]
        , sm_emptyrow  --add small space

        --To add another pop-up, you must increase the numPopUps, and include a unique id for each one
        , Modal.config (CloseModal 1)
            |> Modal.small
            |> Modal.hideOnBackdropClick True
            |> Modal.h3 [] [ Html.text "Step-by-Step Solution" ]
            |> Modal.body [] [ Html.p [] [ Html.text "(-4, 5, -11) x (2, -5, 3) = ((5 x 3) - (-11 x -5)), ((-11 x 2) - (-4 x 3)), ((-4 x -5)-(5 x 2))", Html.text " = (-40, -10, 10)"] ]
            |> Modal.footer []
            -- to exit the pop-up solution 2 affordances are provided. An X in the top right
            -- and a 'close' button in the bottom right
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick (CloseModal 1), style "color" "blue" ]
                    ]
                    [ Html.text "Close" ]
                ]
            |> Modal.view (modalVisibility 1 model.modalVisibilities)
        ]

        , Html.div []
        [Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick <| ShowModal 2, style "color" "black" ]
            ]
            --SOLUTION FOR QUIZ 3
            [ Html.text "Step-by-Step Solution for Quiz 3" ]
        , sm_emptyrow    --add small space

        --To add another pop-up, you must increase the numPopUps, and include a unique id for each one
        , Modal.config (CloseModal 2)
            |> Modal.small
            |> Modal.hideOnBackdropClick True
            |> Modal.h3 [] [ Html.text "Step-By-Step Solution" ]
            |> Modal.body [] [ Html.p [] [ Html.text "(-2/3, 5/7, 1/2) x (1/2, 1/4, 3) = ((5/7 x 3) - (-1/2 x 1/4)), ((1/2 x 1/2) - (-2/3 x 3)), ((-2/3 x 1/4) - (5/7 x 1/2)) = (113/56, 9/4, -11/21)"] ]
            |> Modal.footer []
            -- to exit the pop-up solution 2 affordances are provided. An X in the top right
            -- and a 'close' button in the bottom right
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick (CloseModal 2), style "color" "blue" ]
                    ]
                    [ Html.text "Close" ]
                ]
            |> Modal.view (modalVisibility 2 model.modalVisibilities)
        ]


    ]

{- The number of accordions, carousels and pop ups.
   To add more than one of each, you must increase these numbers and then make sure to
   put the correct id in the code where you add it. The ids start at 0 and go up from there
   (0, 1, 2, 3, etc.)
-}
numAccordions = 1
numCarousels = 2
numPopUps = 1


                -- FOR NORMAL WEB PAGES YOU DO NOT EDIT BELOW HERE --
                -- the following code is standard webpage formatting --
         --includes error handling and basic features for the conceptual model--

type alias Model =
    { navKey : Navigation.Key
    , page : Page
    , time : Float
    , navState : Navbar.State
    , accordionStates : Dict Int Accordion.State --ADD ACCORDION
    , carouselStates : Dict Int Carousel.State -- ADD CAROUSEL
    , modalVisibilities : Dict Int Modal.Visibility -- ADD MODAL
    }

type Page
    = Home
    | NotFound


type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State
    | NoOp
    | AccordionMsg Int Accordion.State --ADD ACCORDION
    | CarouselMsg Int Carousel.Msg --ADD CAROUSEL
    | CloseModal Int
    | ShowModal Int
    | Tick Float

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
                          , accordionStates = Dict.fromList <| List.map (\n -> (n,Accordion.initialStateCardOpen "")) (List.range 0 (numAccordions-1)) --ADD ACCORDION - what does accordion look like when you open the page?
                            --Accordion.initialStateCardOpen "card1" -- if you put a card id, the accordion starts with that card open
                          , carouselStates = Dict.fromList <| List.map (\n -> (n,Carousel.initialState)) (List.range 0 (numCarousels-1))
                          , modalVisibilities = Dict.fromList <| List.map (\n -> (n,Modal.hidden)) (List.range 0 (numPopUps-1))
                          }
    in
        ( model, Cmd.batch [ urlCmd, navCmd ] )



subscriptions : Model -> Sub Msg
subscriptions model =
    --ADD ACCORDION - now that there are multiple subscriptions, they need to be grouped in Sub.batch
    Sub.batch [Navbar.subscriptions model.navState NavMsg
    , Sub.batch <| List.map (\(n, s) -> Accordion.subscriptions s (AccordionMsg n)) <| Dict.toList model.accordionStates
    , Sub.batch <| List.map (\(n, s) -> Carousel.subscriptions s (CarouselMsg n)) <| Dict.toList model.carouselStates
    , onAnimationFrame ( \ posix -> Tick ((Time.posixToMillis posix |> toFloat) * 0.001) )
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

        --ADD ACCORDION
        AccordionMsg id state ->
            ( { model | accordionStates = Dict.insert id state model.accordionStates }
            , Cmd.none
            )

        --ADD CAROUSEL
        CarouselMsg id cMsg ->
            ( {model | carouselStates = Dict.update id
                                            (\m -> case m of
                                                    Just s -> Just <| Carousel.update cMsg s
                                                    Nothing -> Nothing
                                            ) model.carouselStates

             }
            , Cmd.none
            )

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
