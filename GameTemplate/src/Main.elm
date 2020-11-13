module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing(..)
import List
import String
import Dict exposing (Dict)

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

init = { time = 0} 

update msg model = 
  case msg of 
    Tick t _ -> { model | time = t }

type Msg = Tick Float GetKeyState

-------------------------------------------------
---- this is where code from the Slides goes ----
---- BUT MOVE "import"s above main           ----
-------------------------------------------------

player t = 
  group 
    [ circle 5
        |> filled red
        |> move (7,12)
    , wedge 30 ( 0.75 + 0.1 * sin t )
        |> outlined (solid 4.5) hotPink
    ]
    
myShapes model = 
  [ player model.time
  ] 
