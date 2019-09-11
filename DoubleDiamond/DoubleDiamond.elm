module DoubleDiamond exposing (..)

import GraphicSVG exposing(..)
import GraphicSVG.EllieApp exposing (..)
import List

myShapes model = [ 
                    text "Discover" |> filled red |> notifyTap (Clicked Discover)
                   , group (List.map (\(x,y,deg) -> arrow |> rotate (degrees deg) |> move (x,y) ) [(-30,0,45)])
                 ]
                ++ 
                    case model.state of 
                        PopUp stage -> [rect 40 50 |> filled green 
                                        , cross |> notifyTap Exit |> move (15,20)
                                        , txt stage (strStage stage)
                                      
                                        ]

                        otherwise -> []

type State = NoPopUp | PopUp Stages  

type Stages = Discover | Define | Develop | Deliver 

type Msg = Tick Float GetKeyState
          | Clicked Stages 
          | Exit 

txt stage lst =  group (List.indexedMap (\idx line -> text line 
                                                        |> size 8 
                                                        |> centered 
                                                        |> filled black 
                                                        |> move (0,10-10*(toFloat idx))) lst)

cross = group [rect 2 7 |> filled red |> rotate (degrees 45)
               , rect 2 7 |> filled red |> rotate (degrees (-45)) 
                ]

arrow = group [rect 40 1 |> filled black 
                , ngon 3 2 |> filled black |> move (20,0)
                ] 

strStage stage = case stage of 
                  Discover -> ["Discover", "stuff" ]
                  Define -> ["Define"]
                  Develop -> ["Develop"]
                  Deliver -> ["Deliver"]

update msg model = case msg of
                     Tick t _ -> { model | time = t }
                     Clicked stage -> {model | state = PopUp stage }
                     Exit -> {model | state = NoPopUp }

init = {time = 0, state = NoPopUp }
main = gameApp Tick { model = init, view = view, update = update, title = "DoubleDiamond" }

view model = collage 192 128 (myShapes model)