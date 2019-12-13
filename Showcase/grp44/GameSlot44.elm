-- the only change you should need to make is to add these three lines (and change the group number) TODO


module GameSlot44 exposing (..)
import FakeGetKeyState exposing (..)
import GraphicSVG exposing (..)

--  below is code copied from a Game Slot
import List
import String
import Dict exposing (Dict)



-----------------------------------------------
{-
Group44
Yousaf Shaheen
Thomas Dystra
Sandeep Arumainayagam
Aly Shah Imtiaz
-----------------------------------------------
We have written an integral visualizer, which is a tool that allows university
students to view several common functions and visualize the integral as the area
under the curve. Students can click on any individiual line of purple text to
change what is displayed, and the current option selected is highlighted by
an orange box. Any text that is not purple cannot be interacted with by the user.
Modifications to a particular function can be made by clicking the options in the
bottom right corner, which are displayed as a series of  questions that the student
might ask themselves, and can click for the answer. Relevant information about
the curve, including the original function, integral equation, and total area
of the integral (for some predetermined section) is clearly labeled and shown on
the right side of the screen. The 7 design principles have been taken into account
as follows:

DISCOVERABILITY: Options to modify function are in the form of questions, blue text
hints to what can be selected.

FEEDBACK: Graph and all information regarding graph updated instantly.

CONCEPTUAL MODEL: Six main functions, each with three different variations.

AFFORDANCES: Can interact with purple text.

SIGNIFIERS: Clickable text is pruple, orange boxes highlight the currently selected option.

MAPPING: Text directly describes how the graph will change (e.g. sin relates to the sine wave)

CONSTRAINTS: Non-purple text cannot be clicked or interacted with.
-}

myShapes model = [ --White Background
             myBackground

             --Background Lines
           , graphPaper 10 |> makeTransparent 0.4

             --Axis Markings
           , axes
           , text "-5" |> size 6 |> filled (rgb 0 0 0) |> move (-86.5, -52.5)
           , text "-4" |> size 6 |> filled (rgb 0 0 0) |> move (-86.5, -42.5)
           , text "-3" |> size 6 |> filled (rgb 0 0 0) |> move (-86.5, -32.5)
           , text "-2" |> size 6 |> filled (rgb 0 0 0) |> move (-86.5, -22.5)
           , text "-1" |> size 6 |> filled (rgb 0 0 0) |> move (-86.5, -12.5)
           , text "0" |> size 6 |> filled (rgb 0 0 0) |> move (-85, -2.5)
           , text "1" |> size 6 |> filled (rgb 0 0 0) |> move (-85, 7.5)
           , text "2" |> size 6 |> filled (rgb 0 0 0) |> move (-85, 17.5)
           , text "3" |> size 6 |> filled (rgb 0 0 0) |> move (-85, 27.5)
           , text "4" |> size 6 |> filled (rgb 0 0 0) |> move (-85, 37.5)
           , text "5" |> size 6 |> filled (rgb 0 0 0) |> move (-85, 47.5)

           --Other Functions
           , text "sin" |> size 5 |> filled purple |> move (-70, -60) |> notifyTap TapSinNothing
           , text "cos" |> size 5 |> filled purple |> move (-55, -60) |> notifyTap TapCosNothing
           , text "quad" |> size 5 |> filled purple |> move (-40, -60) |> notifyTap TapQuadNothing
           , text "line" |> size 5 |> filled purple |> move (-25, -60) |> notifyTap TapLinNothing
           , text "exp" |> size 5 |> filled purple |> move (-10, -60) |> notifyTap TapExpNothing
           , text "log" |> size 5 |> filled purple |> move (5, -60) |> notifyTap TapLogNothing
           , text "CLICK FOR OTHER FUNCTIONS" |> size 5 |> centered |> filled blue |> move (-27.5, -55)

           ]
           ++
             case model.state of
               TitleScreen -> [
                 text "Welcome to the Integral Visualizer!"
                   |> centered
                   |> size 10
                   |> filled black
                   |> move (0, 40)
                 , text "Click a function to see it visualized!"
                   |> centered
                   |> size 8
                   |> filled darkBlue
                   |> move (0, -30)
                 ]
-------------------------------------------------------------------------------------------------
               LinearNothing ->
                 [
                 -- Function
                 linearNothingLine

                 -- Positive Area(s)
                 , linearNothingPosArea

                 -- Negative Area(s)
                 , linearNothingNegArea

                 -- Info Text
                 , text "Negative Area: 12.5 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 12.5 units^2" |> size 6 |> filled green |> move (-70, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = x-5" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = x^2/2 - 5x + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:10):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "12.5 - 12.5 = 0" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)

                 --Changes Menu
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapLinNothing
                 , text "...the slope?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapLinSlope
                 , text "...the y-intercept?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapLinIntercept

                 --Selection Rectangles
                 , rect 8 5 |> filled orange |> makeTransparent 0.3 |> move (-21.5, -58)
                 , rect 22 5 |> filled orange |> makeTransparent 0.3 |> move (42.5, -43)

                 ]
-------------------------------------------------------------------------------------------------
               LinearSlope -> [
                 -- Function
                 linearSlopeLine

                 -- Positive Area(s)
                 , linearSlopePosArea

                 -- Negative Area(s)
                 , linearSlopeNegArea

                 -- Info Text
                 , text "Negative Area: 6.25 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 6.25 units^2" |> size 6 |> filled green |> move (-70, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = x/2-2.5" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = x^2/4 - 5x/2 + C" |> size 6 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:10):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "6.25 - 6.25 = 0" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)


                 --Changes Menu
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapLinNothing
                 , text "...the slope?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapLinSlope
                 , text "...the y-intercept?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapLinIntercept

                 -- Selection Rectangle
                 , rect 8 5 |> filled orange |> makeTransparent 0.3 |> move (-21.5, -58)
                 , rect 26 5 |> filled orange |> makeTransparent 0.3 |> move (44.5, -48)
                 ]
-------------------------------------------------------------------------------------------------
               LinearIntercept -> [
                 --Function
                   linearInterceptLine

                 --Positive Area(s)
                 , linearInterceptPosArea

                 --Negative Area(s)
                 , linearInterceptNegArea

                 --Info Text
                 , text "Negative Area: 18 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 8 units^2" |> size 6 |> filled green |> move (-70, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = x-4" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = x^2/2 - 4x + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:10):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "18 - 8 = 10" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)


                 --Changes Menu
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapLinNothing
                 , text "...the slope?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapLinSlope
                 , text "...the y-intercept?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapLinIntercept

                 -- Selection Rectangle
                 , rect 8 5 |> filled orange |> makeTransparent 0.3 |> move (-21.5, -58)
                 , rect 36 5 |> filled orange |> makeTransparent 0.3 |> move (49.5, -53)
                 ]
-------------------------------------------------------------------------------------------------
               QuadraticNothing -> [
                 --Function
                 quadNothingP1
                 , quadNothingP2

                 --Positive Area(s)
                 , posAreaQuadNothing

                 --Negative Area(s)
                 --, negArea2

                 --Info Text
                 , text "Negative Area: 0 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 2.67 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = x^2" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = x^3/3 + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "0 + 2.67 = 2.67" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)

                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapQuadNothing
                 , text "...the a-term to negative?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapQuadNegative
                 , text "...the value of the a-term?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapQuadMultiply

                 --Selection Rectangles
                 , rect 10 5 |> filled orange |> makeTransparent 0.3 |> move (-35.5, -58)
                 , rect 22 5 |> filled orange |> makeTransparent 0.3 |> move (42.5, -43)
                 ]
-------------------------------------------------------------------------------------------------
               QuadraticNegative -> [
                 --Function
                 quadNegP1
                 , quadNegP2

                 --Positive Area(s)
                 --,

                 --Negative Area(s)
                 , negAreaQuadNeg

                 --Info Text
                 , text "Negative Area: -2.67 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 0 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = -x^2" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = -x^3/3 + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-2.67 + 0 = -2.67" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapQuadNothing
                 , text "...the a-term to negative?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapQuadNegative
                 , text "...the value of the a-term?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapQuadMultiply

                 --Selection Rectangles
                 , rect 10 5 |> filled orange |> makeTransparent 0.3 |> move (-35.5, -58)
                 , rect 50 5 |> filled orange |> makeTransparent 0.3 |> move (56.5, -48)
                 ]
-------------------------------------------------------------------------------------------------
               QuadraticMultiply -> [
                 --Function
                 quadMultiplyP1
                 , quadMultiplyP2

                 --Positive Area(s)
                 , posAreaQuadMultiply

                 --Negative Area(s)
                 --, negArea2

                 --Info Text
                 , text "Negative Area: 0 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 5.34 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = 2x^2" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = 2x^3/3 + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "0 + 5.34 = 5.34" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapQuadNothing
                 , text "...the a-term to negative?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapQuadNegative
                 , text "...the value of the a-term?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapQuadMultiply

                 --Selection Rectangles
                 , rect 10 5 |> filled orange |> makeTransparent 0.3 |> move (-35.5, -58)
                 , rect 52 5 |> filled orange |> makeTransparent 0.3 |> move (57.5, -53)
                 ]
-------------------------------------------------------------------------------------------------
               SineNothing -> [
                 --Function
                 sinNothingP1
                 , sinNothingP2

                 --Positive Area(s)
                 , posAreaSinNothing

                 --Negative Area(s)
                 , negAreaSinNothing

                 --Info Text
                 , text "Negative Area: -2 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 2 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = sin(x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = -cos(x) + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2p):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-2 + 2 = 0" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapSinNothing
                 , text "...the amplitude?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapSinAmplitude
                 , text "...the frequency?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapSinFrequency

                 --Selection Rectangles
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (-67, -58)
                 , rect 22 5 |> filled orange |> makeTransparent 0.3 |> move (42.5, -43)
                 ]
-------------------------------------------------------------------------------------------------
               SineAmplitude -> [
                 --Function
                 sinAmpP1
                 , sinAmpP2

                 --Positive Area(s)
                 , posAreaSinAmp

                 --Negative Area(s)
                 , negAreaSinAmp

                 --Info Text
                 , text "Negative Area: -4 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 4 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = 2sin(x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = -2cos(x) + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2p):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-4 + 4 = 0" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapSinNothing
                 , text "...the amplitude?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapSinAmplitude
                 , text "...the frequency?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapSinFrequency

                 --Selection Rectangles
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (-67, -58)
                 , rect 34 5 |> filled orange |> makeTransparent 0.3 |> move (48.5, -48)
                 ]
-------------------------------------------------------------------------------------------------
               SineFrequency -> [
                 --Function
                 sinFreqP1
                 , sinFreqP2

                 --Positive Area(s)
                 , posAreaSinFreq

                 --Negative Area(s)
                 , negAreaSinFreq

                 --Info Text
                 , text "Negative Area: -1 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 1 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = sin(2x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = -cos(2x)/2 + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:p):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-1 + 1 = 0" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapSinNothing
                 , text "...the amplitude?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapSinAmplitude
                 , text "...the frequency?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapSinFrequency

                 --Selection Rectangles
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (-67, -58)
                 , rect 34 5 |> filled orange |> makeTransparent 0.3 |> move (48.5, -53)
                 ]
-------------------------------------------------------------------------------------------------
               CosineNothing -> [
                 --Function
                 cosNothingP1
                 , cosNothingP2
                 , cosNothingP3

                 --Positive Area(s)
                 , posAreaCosNothingP1
                 , posAreaCosNothingP2

                 --Negative Area(s)
                 , negAreaCosNothing

                 --Info Text
                 , text "Negative Area: -2 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 2 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = cos(x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = sin(x) + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2p):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-2 + 2 = 0" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapCosNothing
                 , text "...the amplitude?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapCosAmplitude
                 , text "...the frequency?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapCosFrequency


                 -- Selection Rectangle
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (-52, -58)
                 , rect 22 5 |> filled orange |> makeTransparent 0.3 |> move (42.5, -43)
                 ]
-------------------------------------------------------------------------------------------------
               CosineAmplitude -> [
                 --Function
                 cosAmpP1
                 , cosAmpP2
                 , cosAmpP3

                 --Positive Area(s)
                 , posAreaCosAmpP1
                 , posAreaCosAmpP2

                 --Negative Area(s)
                 , negAreaCosAmp

                 --Info Text
                 , text "Negative Area: -4 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 4 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = 2cos(x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = 2sin(x) + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2p):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-4 + 4 = 0" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapCosNothing
                 , text "...the amplitude?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapCosAmplitude
                 , text "...the frequency?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapCosFrequency

                 -- Selection Rectangle
                 , rect 10 5 |> filled orange |> makeTransparent 0.3 |> move (-52.5, -58)
                 , rect 34 5 |> filled orange |> makeTransparent 0.3 |> move (48.5, -48)
                 ]
-------------------------------------------------------------------------------------------------
               CosineFrequency -> [
                 --Function
                 cosFreqP1
                 , cosFreqP2
                 , cosFreqP3

                 --Positive Area(s)
                 , posAreaCosFreqP1
                 , posAreaCosFreqP2

                 --Negative Area(s)
                 , negAreaCosFreq

                 --Info Text
                 , text "Negative Area: -1 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 1 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = cos(2x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = sin(2x)/2 + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:p):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-1 + 1 = 0" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapCosNothing
                 , text "...the amplitude?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapCosAmplitude
                 , text "...the frequency?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapCosFrequency

                 -- Selection Rectangle
                 , rect 10 5 |> filled orange |> makeTransparent 0.3 |> move (-52.5, -58)
                 , rect 34 5 |> filled orange |> makeTransparent 0.3 |> move (48.5, -53)
                 ]
-------------------------------------------------------------------------------------------------
               ExponentialNothing -> [
                 --Function
                 expNothingP1
                 , expNothingP2

                 --Positive Area(s)
                 , posAreaExpNothing

                 --Negative Area(s)
                 --, negArea5

                 --Info Text
                 , text "Negative Area: 0 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 1.72 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = e^x" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = e^x + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:1):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "0 + 1.72 = 1.72" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)

                 --Info Text
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapExpNothing
                 , text "...the base?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapExpMultiply
                 , text "...the exponent?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapExpExponent


                 -- Selection Rectangle
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (-6.5, -58)
                 , rect 22 5 |> filled orange |> makeTransparent 0.3 |> move (42.5, -43)
                 ]
-------------------------------------------------------------------------------------------------
               ExponentialMultiply -> [
                 --Function
                 expMultiplyP1
                 , expMultiplyP2

                 --Positive Area(s)
                 , posAreaExpMultiply

                 --Negative Area(s)

                 --Info Text
                 , text "Negative Area: 0 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 3.44 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = 2e^x" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = 2e^x + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:1):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "0 + 3.44 = 3.44" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapExpNothing
                 , text "...the base?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapExpMultiply
                 , text "...the exponent?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapExpExponent

                 -- Selection Rectangle
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (-6.5, -58)
                 , rect 23 5 |> filled orange |> makeTransparent 0.3 |> move (43, -48)
                 ]
-------------------------------------------------------------------------------------------------
               ExponentialExponent -> [
                 --Function
                 expExponentP1
                 , expExponentP2

                 --Positive Area(s)
                 , posAreaExpExponent

                 --Negative Area(s)

                 --Info Text
                 , text "Negative Area: 0 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 3.19 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = e^(2x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = e^(2x)/2 + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:1):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "0 + 3.19 = 3.19" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapExpNothing
                 , text "...the base?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapExpMultiply
                 , text "...the exponent?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapExpExponent

                 -- Selection Rectangle
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (-6.5, -58)
                 , rect 33 5 |> filled orange |> makeTransparent 0.3 |> move (48, -53)
                 ]
-------------------------------------------------------------------------------------------------
               LogarithmicNothing -> [
                 --Function
                 logNothingP1
                 , logNothingP2

                 --Positive Area(s)
                 , posAreaLogNothing

                 --Negative Area(s)
                 , negAreaLogNothing

                 --Info Text
                 , text "Negative Area: -0.43 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 0.17 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = log10(x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = x(log10(x)-1) + C" |> size 6 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-0.43 + 0.17 = -0.26" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapLogNothing
                 , text "...the base?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapLogBase
                 , text "...the multiplicity?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapLogMultiply

                 -- Selection Rectangle
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (8, -58)
                 , rect 22 5 |> filled orange |> makeTransparent 0.3 |> move (42.5, -43)
                 ]
-------------------------------------------------------------------------------------------------
               LogarithmicBase -> [
                 --Function
                 logBasegP1
                 , logBaseP2

                 --Positive Area(s)
                 , posAreaLogBase

                 --Negative Area(s)
                 , negAreaLogBase

                 --Info Text
                 , text "Negative Area: -1 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 0.38 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = ln(x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = x(ln(x)-1) + C" |> size 8 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-1 + 0.38 = -0.62" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapLogNothing
                 , text "...the base?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapLogBase
                 , text "...the multiplicity?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapLogMultiply

                 -- Selection Rectangle
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (8, -58)
                 , rect 23 5 |> filled orange |> makeTransparent 0.3 |> move (43, -48)
                 ]
-------------------------------------------------------------------------------------------------
               LogarithmicMultiply -> [
                 --Function
                 logMultiplyP1
                 , logMultiplyP2

                 --Positive Area(s)
                 , posAreaLogMultiply

                 --Negative Area(s)
                 , negAreaLogMultiply

                 --Info Text
                 , text "Negative Area: -0.86 units^2" |> size 6 |> filled red |> move (-50, -40)
                 , text "Positive Area: 0.34 units^2" |> size 6 |> filled green |> move (-50, 40)
                 , text "Function:" |> size 8 |> underline |> filled black |> move (40, 40)
                 , text "f(x) = 2log10(x)" |> size 8 |> filled (rgb 50 50 50) |> move (40, 30)
                 , text "Integral:" |> size 8 |> underline |> filled black |> move (40, 10)
                 , text "f(x) = 2x(log10(x)-1) + C" |> size 6 |> filled (rgb 50 50 50) |> move (30, 0)
                 , text "Total Area (0:2):" |> size 8 |> underline |> filled black |> move (40, -20)
                 , text "-0.86 + 0.34 = -0.52" |> size 8 |> filled (rgb 50 50 50) |> move (30, -30)
                 , text "What if I change..." |> size 5 |> filled blue |> move (30, -40)
                 , text "...nothing?" |> size 5 |> filled purple |> move (32, -45) |> notifyTap TapLogNothing
                 , text "...the base?" |> size 5 |> filled purple |> move (32, -50) |> notifyTap TapLogBase
                 , text "...the multiplicity?" |> size 5 |> filled purple |> move (32, -55) |> notifyTap TapLogMultiply

                 -- Selection Rectangle
                 , rect 7 5 |> filled orange |> makeTransparent 0.3 |> move (8, -58)
                 , rect 37 5 |> filled orange |> makeTransparent 0.3 |> move (50, -53)
                 ]

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

axes = openPolygon [ (20, 0), (-80, 0), (-80, 50), (-80, -50)]
               |> outlined (solid 1) (rgb 0 0 0)

mySquare = square 10
             |> filled pink
             |> makeTransparent 0.5  -- value between 0 and 1

myBackground = square 200 |> filled white

-----------------------------------------------------------------------------------------------------

linearNothingLine = openPolygon [(0, 0), (100, 100)]
                     |> outlined (solid 1) (rgb 250 150 0)
                     |> move (-80, -50)

linearNothingPosArea = polygon [(-30, 0), (20, 0), (20, 50)]
                         |> filled lightGreen
                         |> makeTransparent 0.2

linearNothingNegArea = polygon [(-80, -50), (-80, 0), (-30, 0)]
                         |> filled red
                         |> makeTransparent 0.2

linearSlopeLine = openPolygon [(0, 0), (100, 50)]
                    |> outlined (solid 1) (rgb 250 150 0)
                    |> move (-80, -25)

linearSlopePosArea = polygon[(-30, 0), (20, 0), (20, 25)]
                       |> filled lightGreen
                       |> makeTransparent 0.2

linearSlopeNegArea = polygon [(-80, -25), (-80, 0), (-30, 0)]
                         |> filled red
                         |> makeTransparent 0.2

linearInterceptLine = openPolygon [(0, 0), (100, 100)]
                     |> outlined (solid 1) (rgb 250 150 0)
                     |> move (-80, -40)

linearInterceptPosArea = polygon [(-40, 0), (20, 0), (20, 60)]
                         |> filled lightGreen
                         |> makeTransparent 0.2

linearInterceptNegArea = polygon [(-80, -40), (-80, 0), (-40, 0)]
                         |> filled red
                         |> makeTransparent 0.2

-------------------------------------------------------------------------------------------------

quadNothingP1 = curve (8,81) [Pull (-5,0) (-20,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-60,0)

quadNothingP2 = curve (-8,81) [Pull (5,0) (20,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-100,0)

posAreaQuadNothing = openPolygon [(-30, 0), (-25,2.5), (-20, 10), (-15, 22.5), (-10, 40), (-10, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

quadNegP1 = curve (8,-81) [Pull (-5,0) (-20,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-60,0)

quadNegP2 = curve (-8,-81) [Pull (5,0) (20,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-100,0)

negAreaQuadNeg = openPolygon [(-30, 0), (-25,-2.5), (-20, -10), (-15, -22.5), (-10, -40), (-10, 0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

quadMultiplyP1 = curve (8,162) [Pull (-5,0) (-20,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-60,0)
quadMultiplyP2 = curve (-8,162) [Pull (5,0) (20,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-100,0)
posAreaQuadMultiply = openPolygon [(-30, 0), (-25,5), (-20, 20), (-15, 45), (-10, 80), (-10, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

-------------------------------------------------------------------------------------------------

expNothingP1 = curve (20,74) [Pull (15,28) (0,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

expNothingP2 = curve (-20,74) [Pull (-15,28) (-0,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

posAreaExpNothing = openPolygon [(-30, 0), (-25,10), (-20, 22.5), (-20, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

expMultiplyP1 = curve (20,148) [Pull (15,56) (0,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

expMultiplyP2 = curve (-20,148) [Pull (-15,56) (-0,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

posAreaExpMultiply = openPolygon [(-30, 0), (-25,20), (-20, 45), (-20, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

expExponentP1 = curve (20,201) [Pull (15,76) (0,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

expExponentP2 = curve (-20,201) [Pull (-15,76) (0,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

posAreaExpExponent = openPolygon [(-30, 0), (-25,27), (-20, 61), (-20, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

-------------------------------------------------------------------------------------------------

logNothingP1 = curve (10,0) [Pull (3,-10) (3,-50) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move(-80,0)

logNothingP2 = curve (100,10) [Pull (40,10) (10,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move(-80,0)

posAreaLogNothing = openPolygon [(-20, 0), (-10,3), (-10, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

negAreaLogNothing = openPolygon [(-30, 0), (-30,-50), (-27, -50), (-25, -20), (-23,-10), (-20,0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

logBasegP1 = curve (10,0) [Pull (5,-10) (3,-50) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move(-80,0)

logBaseP2 = curve (100,23) [Pull (30,23) (10,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move(-80,0)

posAreaLogBase = openPolygon [(-20, 0), (-10,9), (-10, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

negAreaLogBase = openPolygon [(-30, 0), (-30,-50), (-27, -50), (-25, -20), (-23,-10), (-20,0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

logMultiplyP1 = curve (10,0) [Pull (5,-10) (4,-50) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move(-80,0)

logMultiplyP2 = curve (100,20) [Pull (30,20) (10,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move(-80,0)

posAreaLogMultiply  = openPolygon [(-20, 0), (-10,8), (-10, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

negAreaLogMultiply  = openPolygon [(-30, 0), (-30,-50), (-26, -50), (-25, -20), (-23,-10), (-20,0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

-------------------------------------------------------------------------------------------------

sinNothingP1 = curve (31,0) [Pull (16,20) (0,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

sinNothingP2 = curve (63,0) [Pull (47,-20) (31,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

posAreaSinNothing =  openPolygon [(-30, 0), (-23, 8), (-15,10), (-5,7), (0, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

negAreaSinNothing =  openPolygon [(1, 0), (10, -8), (17,-10), (22,-9), (27, -6), (33, 0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

sinAmpP1 = curve (31,0) [Pull (16,40) (0,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

sinAmpP2 = curve (63,0) [Pull (47,-40) (31,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

posAreaSinAmp =  openPolygon [(-30, 0), (-23, 16), (-15,20), (-5,14), (0, 0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

negAreaSinAmp =  openPolygon [(1, 0), (10, -16), (17,-20), (22,-18), (27, -12), (33, 0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

sinFreqP1 = curve (15,0) [Pull (8,20) (0,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

sinFreqP2  = curve (32,0) [Pull (24,-20) (15,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

posAreaSinFreq  =  openPolygon [(-30, 0), (-23,10), (-19,8), (-15,0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

negAreaSinFreq =  openPolygon [(-15, 0), (-10,-8), (-5,-10), (-1,-6), (2,0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

-------------------------------------------------------------------------------------------------

cosNothingP1 = curve (16,0) [Pull (10,10) (0,10) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

cosNothingP2 = curve (16,0) [Pull (32,-20) (47,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

cosNothingP3 = curve (63,10) [Pull (55,10) (47,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move(-80,0)

posAreaCosNothingP1 =  openPolygon [(-30,0), (-30,10), (-20,7), (-15,0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

posAreaCosNothingP2 =  openPolygon [(18, 0), (24,7), (33,10), (33,0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

negAreaCosNothing =  openPolygon [(-16, 0), (-5,-8), (2,-10), (10,-7), (17,0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

cosAmpP1 = curve (16,0) [Pull (10,20) (0,20) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

cosAmpP2 = curve (16,0) [Pull (32,-40) (47,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

cosAmpP3 = curve (63,20) [Pull (55,20) (47,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move(-80,0)

posAreaCosAmpP1 =  openPolygon [(-30,0), (-30,20), (-20,14), (-15,0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

posAreaCosAmpP2 =  openPolygon [(18, 0), (24,14), (33,20), (33,0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

negAreaCosAmp =  openPolygon [(-16, 0), (-5,-16), (2,-20), (10,-14), (17,0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

cosFreqP1 = curve (8,0) [Pull (5,10) (0,10) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

cosFreqP2 = curve (8,0) [Pull (16,-20) (24,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move (-80,0)

cosFreqP3 = curve (32,10) [Pull (27,10) (24,0) ]
             |> outlined (solid 1) (rgb 250 150 0)
             |> move(-80,0)

posAreaCosFreqP1 =  openPolygon [(-30,0), (-30,10), (-26,7), (-22,0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

posAreaCosFreqP2 =  openPolygon [(-7, 0), (-4,7), (3,10), (3,0)]
             |> filled lightGreen
             |> makeTransparent 0.2
             |> move(-50,0)

negAreaCosFreq =  openPolygon [(-22, 0), (-17,-8), (-15,-10), (-11,-9), (-7,0)]
             |> filled lightRed
             |> makeTransparent 0.2
             |> move(-50,0)

----------------------------------------------------------------------

type Msg = Tick Float GetKeyState
         | TapLinNothing
         | TapLinSlope
         | TapLinIntercept
         | TapSinNothing
         | TapSinAmplitude
         | TapSinFrequency
         | TapCosNothing
         | TapCosAmplitude
         | TapCosFrequency
         | TapQuadNothing
         | TapQuadNegative
         | TapQuadMultiply
         | TapExpNothing
         | TapExpMultiply
         | TapExpExponent
         | TapLogNothing
         | TapLogMultiply
         | TapLogBase

type State = LinearNothing
           | LinearSlope
           | LinearIntercept
           | QuadraticNothing
           | QuadraticNegative
           | QuadraticMultiply
           | SineNothing
           | SineAmplitude
           | SineFrequency
           | CosineNothing
           | CosineAmplitude
           | CosineFrequency
           | ExponentialNothing
           | ExponentialMultiply
           | ExponentialExponent
           | LogarithmicNothing
           | LogarithmicMultiply
           | LogarithmicBase
           | TitleScreen

update msg model =
    case msg of
        Tick t _ ->
            { model | time = t }
        TapSinNothing ->
            { model | state = SineNothing}
        TapSinAmplitude ->
            { model | state = SineAmplitude}
        TapSinFrequency ->
            { model | state = SineFrequency}

        TapCosNothing ->
            { model | state = CosineNothing}
        TapCosAmplitude ->
            { model | state = CosineAmplitude}
        TapCosFrequency ->
            { model | state = CosineFrequency}

        TapQuadNothing ->
            { model | state = QuadraticNothing }
        TapQuadNegative ->
            { model | state = QuadraticNegative }
        TapQuadMultiply ->
            { model | state = QuadraticMultiply }

        TapLinNothing ->
            { model | state = LinearNothing }
        TapLinSlope ->
            { model | state = LinearSlope }
        TapLinIntercept ->
            { model | state = LinearIntercept }

        TapExpNothing ->
            { model | state = ExponentialNothing }
        TapExpMultiply ->
            { model | state = ExponentialMultiply }
        TapExpExponent ->
            { model | state = ExponentialExponent }

        TapLogNothing ->
            { model | state = LogarithmicNothing }
        TapLogMultiply ->
            { model | state = LogarithmicMultiply }
        TapLogBase ->
            { model | state = LogarithmicBase }

type alias Model =
    { time : Float
    , state : State
    }

init : Model
init = { time = 0
       , state = TitleScreen
       }

-----------------------------------------------
