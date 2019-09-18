module DoubleDiamond exposing (..)

import GraphicSVG exposing(..)
import GraphicSVG.EllieApp exposing (..)
import List

myShapes model = [ 
                    diamond |> move (15,0)
                   , diamond |> move (74,0)
                   , textOnDiamond 
                   , doubleArrow 27 19 "discover" Discover (-45,-30) green |> move (-45,-30)
                   , doubleArrow 27 14 "define" Define (-15,-30) green |> move (-15,-30)
                   , doubleArrow 27 18 "develop" Develop (15,-30) green |> move (15,-30)
                   , doubleArrow 27 15 "deliver" Deliver (45,-30) green |> move (45,-30)
                   , doubleArrow 36 23 "inspiration" Inspiration (-55,-40) (rgb 0 191 255) |> move (-55,-40)
                   , doubleArrow 53 18 "ideation" Ideation (-15,-40) (rgb 0 191 255) |> move (-7,-40)
                   , doubleArrow 45 33 "implementation" Implementation (45,-40) (rgb 0 191 255) |> move (45,-40)
                   ]
                ++ 
                    case model.state of 
                        PopUp stage (x,y) col-> [card stage (x,y) col
                                              ]

                        otherwise -> []

type State = NoPopUp | PopUp Stages (Float,Float) Color  

type Stages = Discover | Define | Develop | Deliver | Inspiration | Ideation | Implementation

type Msg = Tick Float GetKeyState
          | Clicked Stages (Float,Float) Color
          | Exit 

card stage (x,y) col= group [rect 42 45 |> filled col |> makeTransparent 0.9
                                        , square 5 |> filled col |> makeTransparent 0.9 |> move (18,20) |> notifyTap Exit
                                        , cross |> notifyTap Exit |> move (18,20)
                                        , txt (strStage stage)
                                      ] |> move (x,y)

diamond = group (List.map (\(x,y,deg) -> arrow x y deg ) [(-60,20,45), (-60,-8,-45), (-30,22,-45),(-30,-10,45)])

txt lst =  group (List.indexedMap (\idx line -> text line 
                                                        |> size 6 
                                                        |> centered 
                                                        |> filled black 
                                                        |> move (0,14-7*(toFloat idx))) lst)

cross = group [rect 1 5 |> filled red |> rotate (degrees 45)
               , rect 1 5 |> filled red |> rotate (degrees (-45)) 
                ]
curvedArrow = group [curve (-12,0) [Pull (0,-10) (12,0)] 
                        |> outlined (solid 1) black
                        |> move (2,-10)
                   , ngon 3 2 |> filled black |> rotate (degrees (10))
                      |> move (-10,-10)]

doubleArrow len rectLen str stage (x,y) col = group [rect len 1 |> filled black
                        , ngon 3 2 |> filled black |> move ((len/2),0)
                        , ngon 3 2 |> filled black |> rotate (degrees (180)) |> move ((-len/2),0)
                        , rect rectLen 2 |> filled white
                        , text str |> centered |> size 5 |> filled black 
                            |> move (0,-1)
                            |> notifyTap (Clicked stage (x,y) col )
                        ] 
arrow x y deg= group [rect 40 1 |> filled black 
                , ngon 3 2 |> filled black |> move (20,0)
                ] |> rotate (degrees deg) |> move (x,y)

strStage stage = case stage of 
                  Discover -> ["Discover", "the problem", "through", "interviewing", "the end user." ]
                  Define -> ["Define","the right" , "problem through", "converging to", "an idea."]
                  Develop -> ["Develop", "prototypes,", "test them", "and iterate", "this process."]
                  Deliver -> ["Deliver", "The product", "is finalized", "and launched", "to the market."]
                  Inspiration -> ["Inspiration", "Learn how", "to better", "understand", "people."]
                  Ideation -> ["Ideation", "Organize and", "analyze research", "to generate ideas", "and refine", "solutions."]
                  Implementation -> ["Implementation", "Bring your", "solution to", "life and", "maximize its", "impact."]

{-
discovering the problem through empathizing
and research, as well as defining the right problem, are 
integral to the process. The develop stage involves
developing prototype, testing, and iterating. Finally, 
the deliver stage is when the product is finalized,
produced, and launched
-}

textOnDiamond = group [ text "define" |> size 5 |> filled black 
                         |> move (-22,5)
                       , text "Design the Right Thing" |> centered |> size 5 
                        |> filled black |> addOutline (solid 0.2) black
                        |> move (-28,40)
                   , text "Design Things Right" |> centered |> size 5 
                        |> filled black |> addOutline (solid 0.2) black
                        |> move (28,40)
                   , text "diverge" |> size 5 |> filled black 
                        |> rotate (degrees 45) |> move (-52,17)
                   , text "converge" |> size 5 |> filled black 
                        |> rotate (degrees (-45)) |> move (-20,31)  
                   , text "diverge" |> size 5 |> filled black 
                        |> rotate (degrees 45) |> move (7,17)
                   , text "converge" |> size 5 |> filled black 
                        |> rotate (degrees (-45)) |> move (39,31)  
                   , text "research" |> size 5 |> filled black 
                        |> rotate (degrees 45) |> move (-45,8) 
                   , text "empathize" |> size 5 |> filled black 
                         |> rotate (degrees (-45)) |> move (-45,2) 
                   , text "ideate" |> size 5 |> filled black 
                        |> rotate (degrees 45) |> move (14,8) 
                   , text "prototype" |> size 5 |> filled black 
                        |> rotate (degrees (-45)) |> move (14,2) 
                   , text "validate" |> size 5 |> filled black 
                         |> move (37,5)
                   , text "frame" |> size 5 |> filled black 
                         |> rotate (degrees 90) |> move (-67,0)
                   , text "share" |> size 5 |> filled black 
                         |> rotate (degrees 90) |> move (67,0)
                   , curvedArrow
                   , text "iterate" |> centered |> size 5 |> filled black |> move (2,-20)
                ]

update msg model = case msg of
                     Tick t _ -> { model | time = t }
                     Clicked stage (x,y) col -> {model | state = PopUp stage (x,y) col }
                     Exit -> {model | state = NoPopUp }

init = {time = 0, state = NoPopUp }
main = gameApp Tick { model = init, view = view, update = update, title = "DoubleDiamond" }

view model = collage 192 128 (myShapes model)