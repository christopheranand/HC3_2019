module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing(..)
import List
import String
import Dict exposing (Dict)
import Debug

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

-----------------------------------------------
---- this is where code from GameSlot goes ----
---- BUT MOVE "import"s above main         ----
-----------------------------------------------

-- Look at PaintInLines first!

-- DragAndDrop

-- Example of defining a list of words and target regions to drop them.

-- We need this as the first comment line, because we use the Dict module
-- Functions starting with Dict. are from that module.  See
--     https://package.elm-lang.org/packages/elm/core/latest/Dict

-- compile with
{-
➜  ExprTemplate git:(master) ✗ elm make src/Main.elm
Success!

    Main ───> index.html

➜  ExprTemplate git:(master) ✗ open index.html
-}
myShapes model =
  [ Tuple.first <| display model.highlight (model.expr,identity)
  , Debug.toString model.highlight |> text |> selectable |> filled black |> move (0,-30) ]
  ++
  -- what we draw depends on the state, this code generated by PALDraw
  case model.state of
      Waiting  ->
          -- apply drawWord to two inputs, the index in list, and the value in the wordList
          []

type Expr = Const Float | Plus Expr Expr | Mult Expr Expr | Var String

type Clickable = CConst
               | CPlus | CPlusLeft Clickable | CPlusRight Clickable
               | CMult | CMultLeft Clickable | CMultRight Clickable
               | CVar
               | CNotHere

example1 = Plus (Mult (Const 7) (Var "x")) (Var "y")

-- text formatting
txtFmt stencil = stencil |> size 4 |> fixedwidth

-- width of one character (this is a guess, because it depends on browser)
charWidth = 8

-- highlight shape
backlit width = roundedRect width 6 4 |> filled (rgb 0 255 0) |> move (0,1)

display : Clickable         -- breadcrumbs to element to highlight
        -> (Expr,Clickable -> Clickable)  -- (expr,breadcrumbs so far)
        -> (Shape Msg,Float) -- return shape, and width of shape
display highlight (expr0,mkClickable) =
  case expr0 of
      Const float -> -- probably assume positive
        let
            width = if float < 10 then charWidth
                else if float < 100 then 2*charWidth
                     else if float < 1000 then 3*charWidth
                          else 4*charWidth
        in
            ( group <|
              ( if highlight == CConst
                then (::) (backlit width)
                else identity
              )
                [text (String.fromFloat float) |> txtFmt |> centered |> filled black]
            , width
            )

      Plus expr expr2 ->
        let
            (leftRecurse, rightRecurse)
              = case highlight of
                  CPlus ->
                    (CNotHere
                    ,CNotHere
                    )
                  CPlusLeft cl ->
                    (cl,CNotHere)
                  CPlusRight cl ->
                    (CNotHere,cl)
                  otherwise ->
                    (CNotHere
                    ,CNotHere
                    )
            (left,leftWidth) = display leftRecurse (expr,mkClickable << CPlusLeft)
            (right,rightWidth) = display rightRecurse (expr2,mkClickable << CPlusRight)

            hl = if highlight == CPlus
                  then [ backlit (leftWidth + rightWidth + charWidth) |> move ( 0.5 * (rightWidth - leftWidth), 0)]
                  else []
        in
          ( group ( hl ++
                [
                  text "(" |> txtFmt |> centered |> filled orange |> move (-0.125*charWidth - leftWidth, 0)
                , left |> move (-0.5 * (0.25*charWidth + leftWidth),0)
                , text "+" |> txtFmt |> centered |> filled orange
                , circle 3 |> filled (rgba 0 0 0 0.1) |> move (0,1) |> notifyTap (Tap <| mkClickable CPlus)
                , right |> move (0.5 * (0.25*charWidth+rightWidth),0)
                , text ")" |> txtFmt |> centered |> filled orange |> move (0.125*charWidth + rightWidth,0)
                -- debug , rect (1*charWidth + leftWidth + rightWidth) 1 |> filled orange
                ]
            ) |> move ( 0.5 * (leftWidth - rightWidth), 0)
          , 1*charWidth + leftWidth + rightWidth )

      Mult expr expr2 ->
        let
            (leftRecurse, rightRecurse)
              = case highlight of
                  CMult ->
                    (CNotHere
                    ,CNotHere
                    )
                  CMultLeft cl ->
                    (cl,CNotHere)
                  CMultRight cl ->
                    (CNotHere,cl)
                  otherwise ->
                    (CNotHere,CNotHere)

            (left,leftWidth) = display leftRecurse (expr,mkClickable << CMultLeft)
            (right,rightWidth) = display rightRecurse (expr2,mkClickable << CMultRight)

            hl = if highlight == CMult
                  then [ backlit (leftWidth + rightWidth + charWidth) |> move ( 0.5 * (rightWidth - leftWidth), 0)]
                  else []
        in
          ( group ( hl ++
            [
              text "(" |> txtFmt |> centered |> filled black |> move (-0.125*charWidth - leftWidth, 0)
            , left |> move (-0.5 * (0.25*charWidth + leftWidth),0)
            , text "*" |> txtFmt |> centered |> filled black
            , circle 3 |> filled (rgba 0 0 0 0.1) |> move (0,1) |> notifyTap (Tap <| mkClickable CMult)
            , right |> move (0.5 * (0.25*charWidth+rightWidth),0)
            , text ")" |> txtFmt |> centered |> filled black |> move (0.125*charWidth + rightWidth,0)
            -- debug , rect (1*charWidth + leftWidth + rightWidth) 1 |> filled red
            ]
            ) |> move ( 0.5 * (leftWidth - rightWidth), 0)
          , 1*charWidth + leftWidth + rightWidth )

      Var string ->
        ( group <|  ( if highlight == CVar
                      then (::) (backlit charWidth)
                      else identity
                    )
                    [text string |> txtFmt |> centered |> filled black]
        , charWidth )

type Msg = Tick Float GetKeyState
         | Tap Clickable

type State = Waiting

update msg model =
    case msg of
        Tick t _ ->
            case model.state of
                Waiting -> { model | time = t }
        Tap clickable ->
          { model | highlight = clickable }

type alias Model =
    { time : Float
    , state : State
    , expr : Expr
    , highlight : Clickable
    }

init : Model
init = { time = 0
       , state = Waiting
       , expr = example1
       , highlight = CNotHere
       }
