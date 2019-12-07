module Main exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)

myShapes model = [codeBlocks model
                 , graph model |> scale 0.6 |> move (45,0)
                 , buttons model
                 ]

type Msg = Tick Float GetKeyState 
            | Box1 
            | Box2 
            | Box3 
            | ForLoop 
            | NestedForLoop 
            | TwoNestedForLoop
            | ClearBox1
            | ClearBox2
            | ClearBox3
            | Nada
            | EnterFor
            | EnterNestedFor
            | EnterTwoNestedFor
            | LeaveFor
            | LeaveNestedFor
            | LeaveTwoNestedFor
            
                
whichText model complexity = 
                let 
                  forLoopTxt = group [
                                      text "for i in range(0,n):" |> size 5 |> filled black |> move (-13,-5)
                                      , text ". . ." |> size 5 |> filled black |> move (-8, -10)
                                      ]
                  nestedForLoopTxt = group [
                                    text "for i in range(0,n):" |> size 5 |> filled black |> move (-13,-5)
                                   ,text "for j in range(0,n):" |> size 5 |> filled black |> move (-8, -10)
                                   , text ". . ." |> size 5 |> filled black |> move (-3,-15)
                                    ]
                  twoNestedForLoopTxt = group [
                                    text "for i in range(0,n):" |> size 5 |> filled black |> move (-13,-5)
                                   ,text "for j in range(0,n):" |> size 5 |> filled black |> move (-8, -10)
                                   ,text "for . . ." |> size 5 |> filled black |> move (-3, -15)
                                    ]
                in
                  case complexity of 
                    "n"        -> forLoopTxt
                    "nSquared" -> nestedForLoopTxt
                    "nCubed"   -> twoNestedForLoopTxt
                    _          -> text "" |> size 5 |> filled black |> makeTransparent 0

codeBlocks model = 
        let 
          
          selectionBox col = roundedRect 52 27 2|> filled col
          
          selectionBoxCol = case model.currentBox of 
                              Box1 -> blue
                              Box2 -> green
                              Box3 -> yellow
                              _    -> black
          
          selectionBoxCoordinates = case model.currentBox of 
                                      Box1 -> (model.x, model.y)
                                      Box2 -> (model.x, model.y - 35)
                                      Box3 -> (model.x, model.y - 70)
                                      _    -> (500, 0)
                    
          bigBlock = roundedRect 50 25 1 |> filled grey
          
          deleteButton = 
            group [
              circle 3 |> filled red
              , rect 1 5 |> filled white |> rotate (degrees 45)
              , rect 1 5 |> filled white |> rotate (degrees -45)
            ]
            
        in
          group
          [ selectionBox selectionBoxCol |> move selectionBoxCoordinates
          , bigBlock     |> move (model.x, model.y) |> notifyTap Box1
          , model.box1Text |> move (model.x - 10, model.y + 5) |> notifyTap Box1
          , deleteButton |> move (model.x - 18, model.y + 8) |> notifyTap ClearBox1
          , bigBlock     |> move (model.x, model.y - 35) |> notifyTap Box2
          , model.box2Text |> move (model.x - 10, model.y + 5 - 35) |> notifyTap Box2
          , deleteButton |> move (model.x - 18, model.y + 8 - 35) |> notifyTap ClearBox2
          , bigBlock     |> move (model.x, model.y - 70) |> notifyTap Box3
          , model.box3Text |> move (model.x - 10, model.y + 5 - 70) |> notifyTap Box3
          , deleteButton |> move (model.x - 18, model.y + 8 - 70) |> notifyTap ClearBox3
          ]
          
          
drawFunction model complexity =
      let
           lineCol = case model.currentBox of 
                              Box1 -> blue
                              Box2 -> green
                              Box3 -> yellow
                              _    -> black
          
        
      
           quadratic = group [
                               curve (110,110) [Pull (90,0) (0,0)] |> outlined (solid 1) lineCol |> move (-85,-55)
                               , text "O(n^2)" |> size 10 |> filled lineCol |> move (55,85)
                             ]
           cubic = group [
                           curve (90, 110) [Pull (95,0) (0,0)] |> outlined (solid 1) lineCol |> move (-85, -55) 
                           , text "O(n^3)" |> size 10 |> filled lineCol |> move (55,95)
                         ]
           line = group [
                         rect 1 190 |> filled lineCol |> rotate (degrees -70) |> move (5, -22)
                        , text "O(n)" |> size 10 |> filled lineCol |> move (55,75)
                        ]
           one = rect 168 0.5 |> filled lineCol 
           
       in
                       case complexity of 
                             "nSquared" -> quadratic
                             "n"        -> line
                             "nCubed"   -> cubic
                             _          -> circle 1  |> filled black |> makeTransparent 0
               
graph model = 
        let
        
           yAxis = group [
                           rect 2 115 |> filled black |> move (-85,0)
                         , text "Time" |> size 10 |> filled black |> rotate (degrees 90) |> move (-90,0)
                         ]
           xAxis = group [
                           rect 180 2 |> filled black |> move (0,-55)
                         , text "n" |> size 10 |> filled black |> move (0,-63)
                         ]
           
        in
            group [
                      (graphPaper 10)
                    , yAxis
                    , xAxis
                    , model.box1Graph
                    , model.box2Graph
                    , model.box3Graph
                    
                  ]             

buttons model = 
    let
      button l w txt = group           
              [ 
                roundedRect l w 1
                  |> filled red
                  |> rotate (degrees -90)
                  |> addOutline (solid 0.25) black
                , text txt
                  |> centered
                  |> size 6
                  |> filled white
                ]
    
    in

      group [
              button (15 + model.forLoopEnlarge) (30 + model.forLoopEnlarge) "For Loop" |> move (model.buttonX, model.buttonY) |> notifyTap ForLoop |> notifyEnter EnterFor |> notifyLeave LeaveFor
            , button (15 + model.nestedForLoopEnlarge) (45 + model.nestedForLoopEnlarge) "Nested For Loop" |> move (model.buttonX + 50, model.buttonY) |> notifyTap NestedForLoop |> notifyEnter EnterNestedFor |> notifyLeave LeaveNestedFor
            , button (15 + model.twoNestedForLoopEnlarge) (60 + model.twoNestedForLoopEnlarge) "2Nested For Loop" |> move (model.buttonX + 110, model.buttonY) |> notifyTap TwoNestedForLoop |> notifyEnter EnterTwoNestedFor |> notifyLeave LeaveTwoNestedFor
            ]
                  

update msg model = case msg of
                     Tick t _         -> {model | time = t }
                     Box1             -> {model | currentBox = Box1}
                     Box2             -> {model | currentBox = Box2}
                     Box3             -> {model | currentBox = Box3}
                     ForLoop          -> {model | box1Graph = case model.currentBox of
                                                                 Box1 -> drawFunction model "n"
                                                                 _    -> model.box1Graph
                                                , box2Graph = case model.currentBox of
                                                                 Box2 -> drawFunction model "n"
                                                                 _    -> model.box2Graph
                                                , box3Graph = case model.currentBox of
                                                                 Box3 -> drawFunction model "n"
                                                                 _    -> model.box3Graph
                                                , box1Text = case model.currentBox of
                                                                 Box1 -> whichText model "n"
                                                                 _    -> model.box1Text
                                                , box2Text = case model.currentBox of
                                                                 Box2 -> whichText model "n"
                                                                 _    -> model.box2Text
                                                , box3Text = case model.currentBox of
                                                                 Box3 -> whichText model "n"
                                                                 _    -> model.box3Text
                                                                 }
                     NestedForLoop    -> {model | box1Graph = case model.currentBox of
                                                                 Box1 -> drawFunction model "nSquared"
                                                                 _    -> model.box1Graph
                                                , box2Graph = case model.currentBox of
                                                                 Box2 -> drawFunction model "nSquared"
                                                                 _    -> model.box2Graph
                                                , box3Graph = case model.currentBox of
                                                                 Box3 -> drawFunction model "nSquared"
                                                                 _    -> model.box3Graph
                                                , box1Text = case model.currentBox of
                                                                 Box1 -> whichText model "nSquared"
                                                                 _    -> model.box1Text
                                                , box2Text = case model.currentBox of
                                                                 Box2 -> whichText model "nSquared"
                                                                 _    -> model.box2Text
                                                , box3Text = case model.currentBox of
                                                                 Box3 -> whichText model "nSquared"
                                                                 _    -> model.box3Text
                                                                 }
                     TwoNestedForLoop -> {model |box1Graph = case model.currentBox of
                                                                 Box1 -> drawFunction model "nCubed"
                                                                 _    -> model.box1Graph
                                                , box2Graph = case model.currentBox of
                                                                 Box2 -> drawFunction model "nCubed"
                                                                 _    -> model.box2Graph
                                                , box3Graph = case model.currentBox of
                                                                 Box3 -> drawFunction model "nCubed"
                                                                 _    -> model.box3Graph
                                                , box1Text = case model.currentBox of
                                                                 Box1 -> whichText model "nCubed"
                                                                 _    -> model.box1Text
                                                , box2Text = case model.currentBox of
                                                                 Box2 -> whichText model "nCubed"
                                                                 _    -> model.box2Text
                                                , box3Text = case model.currentBox of
                                                                 Box3 -> whichText model "nCubed"
                                                                 _    -> model.box3Text
                                                                 }
                     ClearBox1         -> {model | box1Graph = circle 1 |> filled black |> makeTransparent 0
                                                 , box1Text = circle 1 |> filled black |> makeTransparent 0}
                     ClearBox2         -> {model | box2Graph = circle 1 |> filled black |> makeTransparent 0
                                                 ,box2Text = circle 1 |> filled black |> makeTransparent 0}
                     ClearBox3         -> {model | box3Graph = circle 1 |> filled black |> makeTransparent 0
                                                 ,box3Text = circle 1 |> filled black |> makeTransparent 0}
                     EnterFor          -> {model | forLoopEnlarge = 2}
                     LeaveFor          -> {model | forLoopEnlarge = 0}
                     EnterNestedFor    -> {model | nestedForLoopEnlarge = 2}
                     LeaveNestedFor    -> {model | nestedForLoopEnlarge = 0}
                     EnterTwoNestedFor -> {model | twoNestedForLoopEnlarge = 2}
                     LeaveTwoNestedFor -> {model | twoNestedForLoopEnlarge = 0}
                     _                 -> {model | currentBox = Nada}
                     

init = { time = 0
         , currentBox = Nada
         , x = -70
         , y = 30
         , complexity = ""
         , buttonX = -70
         , buttonY = 55
         , box1Graph = circle 1 |> filled black |> makeTransparent 0
         , box2Graph = circle 1 |> filled black |> makeTransparent 0
         , box3Graph = circle 1 |> filled black |> makeTransparent 0
         , box1Text = circle 1 |> filled black |> makeTransparent 0
         , box2Text = circle 1 |> filled black |> makeTransparent 0
         , box3Text = circle 1 |> filled black |> makeTransparent 0
         , forLoopEnlarge = 0
         , nestedForLoopEnlarge = 0
         , twoNestedForLoopEnlarge = 0
        
       }

main = gameApp Tick {model = init, view = view, update = update, title = "Game Slot"}
view model = collage 192 128 (myShapes model)