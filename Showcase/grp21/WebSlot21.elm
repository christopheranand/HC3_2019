-- the only change you should need to make is to add these three lines (and change the group number) TODO


module WebSlot21 exposing (..)
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
  We used the code from word count as the foundation for our code.

  The problem we are solving with our program is to build a calculator
  to help 2FA3/3FA3 students calculate the Present Value of a Bond through
  Yield to Maturity. We also added a bar graph to show a range of nearby
  values to help the students figure out the correct Yield to Maturity
  value for multiple choice problems.

  Discoverability:
    -All the different pieces are clearly visible and easy to find
  Feedback:
    -The input box is highlighted when you click into it
    -Calculate and reset buttons light
    -The 3 numbers on the right side of the equal sign changes on successful calulation
    -The bar graph also populates on successful calculation
    -The input variable text will turn green on valid inputs and red on invalid ones
  Conceptual Model:
    -We reviewed the equations many times with our clients to make sure the equations are
     in a familar shape with identical variable naming schemes
    -The bar graph clearly resembles a bar graph when populated
  Affordances:
    -The calculate buttons affords the ability to process the intended answer
  Signifiers:
    -Input boxes are for entering values
    -The variable names are above the input boxes to display which value to enter there
    -Also have two buttons for the users to click
  Mappings:
    -The equations are mapped to the same row as their respective answer
    -Each input box is mapped to a input variable name
  Constraints:
    -The code does not accept invalid values and the variable name will be highlighted in red
    -Depending on the variable, it is restricted to a reasonable range for the values that can
     be calculated


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
import String

-- Define Title can icon size
title : String
title = "Present Value of Bond Price Calculator"
iconWidth = 1024
iconHeight = 350

-- barchart model from word count assignment
barChart model =
  let
    numWords =List.length model.wordCounts
    maxCount = List.maximum (List.map Tuple.first model.wordCounts) |> Maybe.withDefault 10
    minCount = List.minimum (List.map Tuple.first model.wordCounts) |> Maybe.withDefault 1
    scaleHeight = iconHeight / toFloat (maxCount-minCount)
    width = ((iconWidth - 10 ) / toFloat numWords)/2
    growHeight y = if y < model.time then y else model.time
    bar idx (count,word) =
      -- graph the bar Chart
        group [ GraphicSVG.rect 500 3
                  |> filled (rgb 230 125 50)
                  |> move (250 + (toFloat idx * width - 0.5 * iconWidth + 0.5 * width),20+1.0*(scaleHeight * toFloat (count-minCount)))
                ,GraphicSVG.rect width (growHeight <| scaleHeight * toFloat (count-minCount))
                  |> filled (rgb 200 0 200)
                  |> move (10,20+0.5 * growHeight ( scaleHeight * toFloat (count-minCount) ) )
                ,GraphicSVG.text  (String.slice 0 5 (String.fromFloat word))
                  |> GraphicSVG.size 40
                  |> filled black
                  |> rotate (degrees 90)
                  |> move (10,23)
                ,GraphicSVG.text (String.fromInt count)
                  |> GraphicSVG.size 25
                  |> filled black
                  |> move (-65+(toFloat idx * width - 0.5 * iconWidth + 0.5 * width),10+1.0*(scaleHeight * toFloat (count-minCount)))
              ]
          |> move (0 - (toFloat idx * width - 0.5 * iconWidth + 0.5 * width)
                  , -0.5 * toFloat iconHeight)
  in
      [
     -- Coupon Value formula
     group [  GraphicSVG.text "V" |> filled black |> move (-143, -47) |> scale 0.5
             , GraphicSVG.text "coupons" |> filled black |> move (-169, -63) |> scale 0.4
             , GraphicSVG.text "=" |> filled black |> move (-100, -47) |> scale 0.5
             , GraphicSVG.text "C" |> filled black |> move (-50, -40) |> scale 0.5
             , polygon [(0,0),(0,-1),(18,-1),(18,0)]  |> filled (rgb 230 125 50)  |> scale 1
             |> move (-32, -22)
             , GraphicSVG.text "(1+r)" |> filled black |> move (-60, -58) |> scale 0.5
             , GraphicSVG.text "t" |> filled black |> move (-42, -68) |> scale 0.4
             , GraphicSVG.text "=" |> filled black |> move (-20, -47) |> scale 0.5
             , GraphicSVG.text "=" |> filled black |> move (-20, -107) |> scale 0.5
             , GraphicSVG.text "=" |> filled black |> move (-20, -159) |> scale 0.5
             , polygon [(0,0),(0,-1),(15,-1),(15,0)]  |> filled (rgb 230 125 50)  |> scale 0.8
             |> move (-46, -15)
             , polygon [(0,-1),(2,-1),(12,-9),(12,-10)]  |> filled (rgb 230 125 50)  |> scale 0.8
             |> move (-46, -15)
             , polygon [(0,-18),(2,-18),(12,-10),(12,-9)]  |> filled (rgb 230 125 50)  |> scale 0.8
             |> move (-46, -15)
             , polygon [(0,-18),(0,-19),(15,-19),(15,-18)]  |> filled (rgb 230 125 50)  |> scale 0.8
             |> move (-46, -15)
             , GraphicSVG.text "t=1" |> filled black |> move (-106, -87) |> scale 0.4
             , GraphicSVG.text "T" |> filled black |> move (-103, -36) |> scale 0.4]
             |> move (-50, 50)
             |> scale 4
     -- graph axies
     ,group [ polygon [(0,-32),(1,-32),(1,32),(0,32)]  |> filled (rgb 230 125 50)  |> scale 5
             , polygon [(0,-31),(0,-32),(100,-32),(100,-31)]  |> filled (rgb 230 125 50)  |> scale 5
             , GraphicSVG.text "present value" |> filled black |> move (-70, 109) |> scale 1.5
             , GraphicSVG.text "discount rate" |> filled black |> move (275, -115) |> scale 1.5
             , triangle 10|> filled (rgb 230 125 50) |> scale 1 |> rotate (degrees -30) |> move (2,160)
             , triangle 10|> filled (rgb 230 125 50) |> scale 1 |> move (500,-156)]

     -- Face Value formula
     ,group [  GraphicSVG.text "V" |> filled black |> move (-57, -49) |> scale 0.5
             , GraphicSVG.text "face value" |> filled black |> move (-62, -65) |> scale 0.4
             , GraphicSVG.text "=" |> filled black |> move (-8, -49) |> scale 0.5
             , GraphicSVG.text "(1+r)" |> filled black |> move (5, -58) |> scale 0.5
             , GraphicSVG.text "F" |> filled black |> move (17, -40) |> scale 0.5
             , GraphicSVG.text "T" |> filled black |> move (37, -67) |> scale 0.4
             , polygon [(0,0),(0,-1),(18,-1),(18,0)]  |> filled (rgb 230 125 50)  |> scale 1
             |> move (1, -22)]
             |> move (-83, 20)
             |> scale 4

      -- Present Value of Bond (face value + coupons)
      ,group [
             GraphicSVG.text "V" |> filled black |> move (-62, -100) |> scale 0.5
             , GraphicSVG.text "+" |> filled black |> move (-20, -100) |> scale 0.5
             , GraphicSVG.text "coupons" |> filled black |> move (-68, -128) |> scale 0.4
             , GraphicSVG.text "V" |> filled black |> move (-8, -100) |> scale 0.5
             , GraphicSVG.text "face value" |> filled black |> move (0, -128) |> scale 0.4
             ]|> move (-83, 20)
             |> scale 4

       -- The three numerical values of the 3 equations.
           , GraphicSVG.text (String.fromInt (round model.coupon)) |> filled black |> move (-72, 34)|> scale 3
           , GraphicSVG.text (String.fromInt (round model.faceV)) |> filled black |> move (-72, -7)|> scale 3
           , GraphicSVG.text (String.fromInt (round model.coupon + round model.faceV)) |> filled black |> move (-72, -41)|> scale 3
      ]

      ++ (List.indexedMap bar model.wordCounts)
          |> group



page : Model -> List (Html Msg)
page model =
    [ div [ style "margin" "1%" ]
        [ CDN.stylesheet
        , Html.node "link" [ attribute "rel" "stylesheet", attribute "crossorigin" "anonymous", href "https://use.fontawesome.com/releases/v5.7.2/css/all.css" ] []
        , h1 [] [ Html.text "Present Value of Bond Price Calculator" ]
        , Html.div [style "display" "flex", style "flex-direction" "row"]
            [ Html.div [style "width" "100%", style "position" "abosulte",  style "top" "5%"] -- change the width of the icon
                [
                   Widget.icon "myIcon" iconWidth iconHeight
                        [
                            barChart model
                        ]
                ]
            ]

        -- Input box for Face Value
        , Html.div [style "width" "40%",style "color" model.fvColor, style "position" "absolute",  style "top" "65%"]
            [Form.form []
            [Form.group []
                  [ Form.label [ for "fvarea"] [ Html.text "F  Face Value"]
                  , Input.text[ Input.id "facevalue", Input.value model.fv, Input.placeholder "Please input Face Value", Input.small,Input.onInput FaceValue]]]]
        -- Input box for YTM
        , Html.div [style "width" "40%",style "color" model.ytmColor, style "position" "absolute",  style "top" "80%"]
            [Form.form []
            [Form.group []
                  [ Form.label [ for "ymarea"] [ Html.text "r Yeild to Maturity Percent (0 - 100)"]
                  , Input.text[ Input.id "yeildtomaturity", Input.value model.ytm, Input.placeholder "Please input Yeild to Maturity", Input.small,Input.onInput YeildtoMaturity]]]]
        -- Input box for number of Periods
        , Html.div [style "width" "40%",style "color" model.npColor, style "position" "absolute",  style "top" "95%"]
            [Form.form []
            [Form.group []
                  [ Form.label [ for "noparea"] [ Html.text "T # of Periods (Integer only)"]
                  , Input.text[ Input.id "noperiods", Input.value model.np, Input.placeholder "Please input number of Periods",Input.small,Input.onInput Noperiods]]]]
        -- Input box for Coupon Payment
        , Html.div [style "width" "40%",style "color" model.cpColor, style "position" "absolute",  style "top" "110%"]
            [Form.form []
            [Form.group []
                  [ Form.label [ for "cparea"] [ Html.text "C Coupon Payment"]
                  , Input.text[ Input.id "couponpayment", Input.value model.cp, Input.placeholder "Please input Coupon Payment",Input.small,Input.onInput Couponpayment]]]]
        -- Input box for Increment for bargraph
        ,Html.div [style "width" "40%",style "color" model.icColor, style "position" "absolute",  style "top" "125%"]
            [Form.form []
            [Form.group []
                  [ Form.label [ for "icarea"] [ Html.text "Increment for bargraph"]
                  , Input.text[ Input.id "Increment", Input.value model.ic, Input.placeholder "This increment is based on YTM input (r)", Input.small,Input.onInput  IncrementScale]]]]
        -- Reset button
       , Html.div [style "position" "absolute",  style "right" "15%" ,style "top" "120%"]
        [Button.button
            [ Button.outlineDanger
            , Button.attrs [ onClick <| Clear , style "color" "black" ]
           ]
            [ Html.text "Reset" ]]
        -- Calculate button
        , Html.div [style "position" "absolute",  style "right" "13%" , style "top" "100%"]
        [Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick <| Calculate , style "color" "black" ]
            ]
            [ Html.text "Calculate" ]]
          ]
        ]


-- Define State
type State = NotSet
           | SetStart String String String String String
           | Set Float Float


type alias Model = --Setup model in the shape of the varaibles we require.
    { navKey : Navigation.Key
    , page : Page
    , time : Float
    , timeOfInput : Float
    , navState : Navbar.State
    , wordCounts : List (Int,Float)
    , fv : String
    , ytm : String
    , np : String
    , cp : String
    , ic : String
    , fvColor : String
    , ytmColor : String
    , npColor : String
    , cpColor : String
    , icColor : String
    , state : State
    , coupon : Float
    , faceV : Float
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
    | FaceValue String
    | YeildtoMaturity String
    | Noperiods String
    | Couponpayment String
    | IncrementScale String
    | Clear
    | Calculate


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg
        ( model, urlCmd ) =
            urlUpdate url { navKey = key --initialize variables
                          , navState = navState
                          , page = Home
                          , time = 0
                          , timeOfInput = 0
                          , wordCounts = []
                          , fv = ""        -- initialize face value
                          , ytm = ""       -- initialize Yeild to Matruity
                          , np = ""        -- initialize number of periods
                          , cp = ""        -- initialize coupon payment
                          , ic = ""        -- initialize increment for bargraph
                          -- initialize font color
                          , fvColor = "Black"
                          , ytmColor = "Black"
                          , npColor = "Black"
                          , cpColor = "Black"
                          , icColor = "Black"
                          , state = NotSet
                          , coupon = 0.0         -- initialize result 1
                          , faceV = 0.0          -- initialize result 2
                          }

    in
        ( model, Cmd.batch [ urlCmd, navCmd ] )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [onAnimationFrame ( \ posix -> Tick ((Time.posixToMillis posix |> toFloat) * 0.001) )]

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

        -- Model message for Fave Value input
        FaceValue f ->
                -- It will check two things 1. is input a number or string
                --                          2. is input a positive number
                case checkFV f of
                    -- If return true, it will set the font color to green, set the value and set state.
                   True ->  ( {model | fvColor = "Green", fv = f, state = SetStart model.fvColor model.ytmColor model.npColor model.cpColor model.icColor} , Cmd.none)
                   -- If return false, it will set the font color to green, set the value and set state.
                   False -> ( {model |  fvColor = "Red", state = NotSet, fv = f}, Cmd.none)

        -- Model message for YTM input
        YeildtoMaturity v ->
                   -- It will check two things 1. is input a number or string
                   --                            2. is input
                   case checkYTM v of
                   True ->  ( {model | ytmColor = "Green" , ytm = v, state = SetStart model.fvColor model.ytmColor model.npColor model.cpColor model.icColor} , Cmd.none)
                   False -> ( {model |  ytmColor = "Red", state = NotSet, ytm = v}, Cmd.none)

       -- Model message for number of peroids
        Noperiods n ->
                   -- It will check three things 1. is input a number or string
                   --                            2. is input a integer
                   --                            3. is input a positive number
                  case checkTP n of
                   True ->  ( {model | npColor = "Green", np = n, state = SetStart model.fvColor model.ytmColor model.npColor model.cpColor model.icColor} , Cmd.none)
                   False -> ( {model |  npColor = "Red", state = NotSet, np = n}, Cmd.none)

        -- Model message for coupon Payment
        Couponpayment  c ->
                   -- It will check two things 1. is input a number or string
                   --                          2. is input a positive number
                  case checkCP c of
                   True ->  ( {model | cpColor = "Green", cp = c, state = SetStart model.fvColor model.ytmColor model.npColor model.cpColor model.icColor} , Cmd.none)
                   False -> ( {model |  cpColor = "Red", state = NotSet, cp = c}, Cmd.none)

        -- Model message for Increment for bargraph
        IncrementScale  icc ->
                   -- It will check four things 1. is input a number or string
                   --                           2. is input a positive number
                   --                           3. is 4 times input plus ytm greater than 100
                   --                           4. is 4 times input minus ytm less than 0
                  case checkIB icc model.ytm of
                   True ->  ( {model | icColor = "Green",  ic = icc, state = SetStart model.fvColor model.ytmColor model.npColor model.cpColor model.icColor} , Cmd.none)
                   False -> ( {model | icColor = "Red", state = NotSet,  ic = icc}, Cmd.none)

        -- Define the clear state, set all the value to empty and all the font color to black
        Clear -> ({ model | state = NotSet, fv="",ytm="", cp="", np="", ic="", fvColor = "Black"
                          , ytmColor = "Black"
                          , npColor = "Black"
                          , cpColor = "Black"
                          , icColor = "Black"
                          ,coupon = 0
                          , faceV= 0, wordCounts=[] }, Cmd.none)

        -- Define the Calculate state
        Calculate -> case model.state of
                -- If the state is NotSet, it won't do anything
                NotSet ->
                    ({ model | state = NotSet}, Cmd.none)
                -- If the state is SetStart, it will check the font color. Only all the font colors are green will
                -- trigger the Calculate process
                SetStart fvColor ytmColor npColor cpColor icColor->
                  if checkFV model.fv && checkYTM model.ytm && checkTP model.np && checkCP model.cp && checkIB model.ic model.ytm then
                    let --calculate all the required values for equations and bar graph
                      vc = fromJust(String.toFloat(model.cp))*(1 - (1+(fromJust(String.toFloat(model.ytm))/100.0))^(-1*fromJust(String.toFloat(model.np))))/(fromJust(String.toFloat(model.ytm))/100.0)
                      vf = fromJust(String.toFloat(model.fv))/((1+(fromJust(String.toFloat(model.ytm))/100.0))^(fromJust(String.toFloat(model.np))))
                      rx1 = (fromJust(String.toFloat(model.ytm))-4*fromJust(String.toFloat(model.ic)))/100
                      rx2 = (fromJust(String.toFloat(model.ytm))-3*fromJust(String.toFloat(model.ic)))/100
                      rx3 = (fromJust(String.toFloat(model.ytm))-2*fromJust(String.toFloat(model.ic)))/100
                      rx4 = (fromJust(String.toFloat(model.ytm))-1*fromJust(String.toFloat(model.ic)))/100
                      rx5 = (fromJust(String.toFloat(model.ytm)))/100
                      rx6 = (fromJust(String.toFloat(model.ytm))+1*fromJust(String.toFloat(model.ic)))/100
                      rx7 = (fromJust(String.toFloat(model.ytm))+2*fromJust(String.toFloat(model.ic)))/100
                      rx8 = (fromJust(String.toFloat(model.ytm))+3*fromJust(String.toFloat(model.ic)))/100
                      rx9 = (fromJust(String.toFloat(model.ytm))+4*fromJust(String.toFloat(model.ic)))/100
                    in
                      ({ model | state = Set vc vf, coupon = vc, faceV = vf, wordCounts = [(round (fromJust(String.toFloat(model.cp))*(1 - (1+rx1)^(-1*fromJust(String.toFloat(model.np))))/rx1 + fromJust(String.toFloat(model.fv))/((1+rx1)^(fromJust(String.toFloat(model.np))))), round2 (rx1*100))
                                                                                          ,(round (fromJust(String.toFloat(model.cp))*(1 - (1+rx2)^(-1*fromJust(String.toFloat(model.np))))/rx2 + fromJust(String.toFloat(model.fv))/((1+rx2)^(fromJust(String.toFloat(model.np))))), round2 (rx2*100))
                                                                                          ,(round (fromJust(String.toFloat(model.cp))*(1 - (1+rx3)^(-1*fromJust(String.toFloat(model.np))))/rx3 + fromJust(String.toFloat(model.fv))/((1+rx3)^(fromJust(String.toFloat(model.np))))), round2 (rx3*100))
                                                                                          ,(round (fromJust(String.toFloat(model.cp))*(1 - (1+rx4)^(-1*fromJust(String.toFloat(model.np))))/rx4 + fromJust(String.toFloat(model.fv))/((1+rx4)^(fromJust(String.toFloat(model.np))))), round2 (rx4*100))
                                                                                          ,(round (fromJust(String.toFloat(model.cp))*(1 - (1+rx5)^(-1*fromJust(String.toFloat(model.np))))/rx5 + fromJust(String.toFloat(model.fv))/((1+rx5)^(fromJust(String.toFloat(model.np))))), round2 (rx5*100))
                                                                                          ,(round (fromJust(String.toFloat(model.cp))*(1 - (1+rx6)^(-1*fromJust(String.toFloat(model.np))))/rx6 + fromJust(String.toFloat(model.fv))/((1+rx6)^(fromJust(String.toFloat(model.np))))), round2 (rx6*100))
                                                                                          ,(round (fromJust(String.toFloat(model.cp))*(1 - (1+rx7)^(-1*fromJust(String.toFloat(model.np))))/rx7 + fromJust(String.toFloat(model.fv))/((1+rx7)^(fromJust(String.toFloat(model.np))))), round2 (rx7*100))
                                                                                          ,(round (fromJust(String.toFloat(model.cp))*(1 - (1+rx8)^(-1*fromJust(String.toFloat(model.np))))/rx8 + fromJust(String.toFloat(model.fv))/((1+rx8)^(fromJust(String.toFloat(model.np))))), round2 (rx8*100))
                                                                                          ,(round (fromJust(String.toFloat(model.cp))*(1 - (1+rx9)^(-1*fromJust(String.toFloat(model.np))))/rx9 + fromJust(String.toFloat(model.fv))/((1+rx9)^(fromJust(String.toFloat(model.np))))), round2 (rx9*100))]}, Cmd.none)
                  else
                      ({ model | state = NotSet }, Cmd.none)
                otherwise ->
                    ({ model | state = NotSet }, Cmd.none)

-- Function for changing Maybe Float to Float
fromJust : Maybe Float -> Float
fromJust x = case x of
    Just y -> y
    Nothing -> 1.0


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

-- Function for rounding a float into 2 digits
round2: Float -> Float
round2 b =
   0.01 * toFloat (round (b*100.0))

-- Function for checking the Face Value input value
checkFV : String -> Bool
checkFV a   =
  if (String.toFloat a /= Nothing  && fromJust(String.toFloat a) > 0)then True
          else False

-- Function for checking the YTM input value
checkYTM : String -> Bool
checkYTM a   =
  if (String.toFloat a /= Nothing  && fromJust(String.toFloat a) > 0 && fromJust(String.toFloat a) < 100 )then True
          else False

-- Function for checking number of periods input value
checkTP : String -> Bool
checkTP a   =
  if (String.toInt a /= Nothing  && fromJust(String.toFloat a) > 0)then True
          else False

-- Function for checking coupon payment input value
checkCP : String -> Bool
checkCP a   =
  if (String.toFloat a /= Nothing  && fromJust(String.toFloat a) > 0)then True
          else False

-- Function for checking increment for bargraph input value
checkIB : String -> String-> Bool
checkIB a b  =
  if (String.toFloat a /= Nothing  && fromJust(String.toFloat a) > 0
  && 4* fromJust(String.toFloat a) + fromJust(String.toFloat b) <= 100
  && fromJust(String.toFloat b) -  4 * fromJust(String.toFloat a)  > 0 )then True
          else False
