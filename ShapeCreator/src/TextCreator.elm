module TextCreator exposing (..)

{-
Copyright 2017-2019 Christopher Kumar Anand,  Adele Olejarz, Chinmay Sheth, Yaminah Qureshi, Graeme Crawley and students of McMaster University.  Based on the Shape Creator by Levin Noronha.

   Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution, and cite the paper

   @article{d_Alves_2018,
   title={Using Elm to Introduce Algebraic Thinking to K-8 Students},
   volume={270},
   ISSN={2075-2180},
   url={http://dx.doi.org/10.4204/EPTCS.270.2},
   DOI={10.4204/eptcs.270.2},
   journal={Electronic Proceedings in Theoretical Computer Science},
   publisher={Open Publishing Association},
   author={d’ Alves, Curtis and Bouman, Tanya and Schankula, Christopher and Hogg, Jenell and Noronha, Levin and Horsman, Emily and Siddiqui, Rumsha and Anand, Christopher Kumar},
   year={2018},
   month={May},
   pages={18–36}
   }

   3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR AN, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

-}

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import List
import ShapeCreateAssets exposing (..)
import String exposing (..)


init =
    { time = 0
    , notify = NotifyTap
    , shape = Text
    , draw = Filled
    , style = Solid
    , lineWidth = 1
    , width = 10
    , height = 15
    , sides = 5
    , roundness = 5
    , angle = 30
    , mouth = 0.75
    , txt = ""
    , clr = RGB
    , red = 100
    , green = 0
    , blue = 100
    , alpha = 0.5
    , hasMove = False
    , hasRotate = False
    , hasScale = False
    , hasScaleX = False
    , hasScaleY = False
    , hasMakeTransparent = False
    , hasShadow = False
    , hasSize = False
    , hasBold = False
    , hasItalic = False
    , hasUnderline = False
    , hasStrikethrough = False
    , hasSansserif = False
    , hasSerif = False
    , hasFixedwidth = False
    , hasCentered = False
    , scl = 2
    , sclx = 2
    , scly = 2
    , x = 0
    , y = 0
    , keyboard = 1
    , txtsize = 14
    , currentButton = None
    , buttonDownTime = 0
    , deleteButtondown = 0
    , nextButtonDown = 0
    }



-- change you app's state based on your new messages


colourAmount =
    3


update msg model =
    case msg of
        Tick t _ ->
            { model
                | time = t
                , buttonDownTime =
                    case model.currentButton of
                        None ->
                            0

                        _ ->
                            model.buttonDownTime + 0.1
                , red =
                    case model.currentButton of
                        RedUp ->
                            clamp 0 255 (model.red + accel model.buttonDownTime)

                        RedDown ->
                            clamp 0 255 (model.red - accel model.buttonDownTime)

                        _ ->
                            model.red
                , blue =
                    case model.currentButton of
                        BlueUp ->
                            clamp 0 255 (model.blue + accel model.buttonDownTime)

                        BlueDown ->
                            clamp 0 255 (model.blue - accel model.buttonDownTime)

                        _ ->
                            model.blue
                , green =
                    case model.currentButton of
                        GreenUp ->
                            clamp 0 255 (model.green + accel model.buttonDownTime)

                        GreenDown ->
                            clamp 0 255 (model.green - accel model.buttonDownTime)

                        _ ->
                            model.green
                , deleteButtondown =
                    case model.currentButton of
                        Delete ->
                            accel model.buttonDownTime

                        _ ->
                            0
                , nextButtonDown =
                    case model.currentButton of
                        Delete ->
                            model.nextButtonDown

                        _ ->
                            0
            }
                |> (if model.deleteButtondown > 2 then
                        \m -> { m | txt = dropRight 1 model.txt }

                    else
                        \m -> m
                   )

        MouseUp ->
            { model | currentButton = None }

        ButtonDown dir ->
            { model | currentButton = dir }

        Sten stencil ->
            { model | shape = stencil }

        Draw draw ->
            { model | draw = draw }

        LStyle ->
            { model
                | style =
                    case model.style of
                        Solid ->
                            Dotted

                        Dotted ->
                            Dashed

                        Dashed ->
                            Longdash

                        Longdash ->
                            Dotdash

                        Dotdash ->
                            Dotted
            }

        Toggle Move ->
            { model | hasMove = not model.hasMove }

        Toggle Rotate ->
            { model | hasRotate = not model.hasRotate }

        Toggle Scale ->
            { model | hasScale = not model.hasScale }

        Toggle ScaleX ->
            { model | hasScaleX = not model.hasScaleX }

        Toggle ScaleY ->
            { model | hasScaleY = not model.hasScaleY }

        Toggle MakeTransparent ->
            { model | hasMakeTransparent = not model.hasMakeTransparent }

        Toggle Shadow ->
            { model | hasShadow = not model.hasShadow }

        Toggle Size ->
            { model | hasSize = not model.hasSize }

        Toggle Bold ->
            { model | hasBold = not model.hasBold }

        Toggle Italic ->
            { model | hasItalic = not model.hasItalic }

        Toggle Underline ->
            { model | hasUnderline = not model.hasUnderline }

        Toggle Strikethrough ->
            { model | hasStrikethrough = not model.hasStrikethrough }

        Toggle Sansserif ->
            { model | hasSansserif = not model.hasSansserif }

        Toggle Serif ->
            { model | hasSerif = not model.hasSerif }

        Toggle Fixedwidth ->
            { model | hasFixedwidth = not model.hasFixedwidth }

        Toggle Centered ->
            { model | hasCentered = not model.hasCentered }

        Toggle MakeText ->
            model

        TransM t ->
            t model

        SetColour clr ->
            { model | clr = clr }

        -- ran out of room for notifications, but left them here for a possible future improvement
        Notif notif ->
            { model | notify = notif }

        Key s ->
            { model | txt = setTxt model s }

        Tab ->
            { model
                | keyboard =
                    case model.keyboard of
                        1 ->
                            2

                        2 ->
                            3

                        3 ->
                            4

                        _ ->
                            1
            }

        ClearOne ->
            { model | txt = dropRight 1 model.txt }


setTxt m s =
    m.txt ++ s



-- make the Collage fit in VGA screen minus menu bars, for Chromebooks and iPads


view model =
    [ graphPaperCustom 10 1 (rgb 50 250 130) |> makeTransparent 0.5 -- axes and selected coordinate ticks
    , rect 512 0.5 |> filled titleColour
    , rect 0.5 512 |> filled titleColour
    , rect 4 0.5 |> filled darkBlue |> move ( 0, 100 )
    , text "(0,100)" |> size 7 |> filled (rgb 0 150 100) |> move ( 3, 100 )
    , rect 4 0.5 |> filled darkBlue |> move ( 0, -100 )
    , text "(0,-100)" |> size 7 |> filled (rgb 0 150 100) |> move ( 3, -100 )
    , rect 0.5 4 |> filled darkBlue |> move ( -100, 0 )
    , text "(-100,0)" |> size 7 |> filled (rgb 0 150 100) |> move ( -100, 3 )
    , rect 0.5 4 |> filled darkBlue |> move ( 100, 0 )
    , text "(100,0)" |> size 7 |> filled (rgb 0 150 100) |> move ( 100, 3 )
    , rect 0.5 4 |> filled darkBlue |> move ( -200, 0 )
    , text "(-200,0)" |> size 7 |> filled (rgb 0 150 100) |> move ( -200, 3 )
    , rect 0.5 4 |> filled darkBlue |> move ( 200, 0 )
    , text "(200,0)" |> size 7 |> filled (rgb 0 150 100) |> move ( 200, 3 ) -- put the drawn shape above the graph paper, but under the transparent controls
    , shapeFun model -- the selection boxes
    , shadow model

    --, stencils model |> move ( -150, 170 )
    , keyboard model |> move ( -230, 146 )

    --, code "|>" |> move ( -40, 165 )
    , stamps model |> move ( 55, 169 )
    , colours model |> move ( 230, 169 )

    -- , code "|>" |> move ( 110, 165 )
    -- , colours model |> move ( 230, 169 )
    -- , transforms model |> move ( -150, 30 )
    , effects model |> move ( -150, -93 )
    , tweaks |> move ( -150, -23 )
    , yourCode model |> move ( 115, -94 )

    --, codeForEffects model |> move (190 , -60)
    ]



--150 90
-- messages generated by the framework (Tick) and by user interactions
-- note that we let elm figure out the type of the model by making it a type parameter, m


type Msg m
    = Tick Float GetKeyState
    | Sten Stencil
    | Draw Draw
    | LStyle
    | SetColour Colour
    | Toggle Transforms
    | TransM (m -> m)
    | Notif Notifications
    | Key String
    | ClearOne
    | Tab
    | ButtonDown ButtonDir
    | MouseUp


type ButtonDir
    = RedUp
    | RedDown
    | BlueUp
    | BlueDown
    | GreenUp
    | GreenDown
    | Delete
    | None



-- the type of stencil selected, these correspond to functions exported by GraphicSVG


type Stencil
    = Circle
    | Rect
    | RoundedRect
    | Oval
    | Ngon
    | Triangle
    | Wedge
    | Square
    | Text
    | BezierPath
    | Polygon
    | OpenPolygon



-- type of drawing


type Draw
    = Filled
    | Outlined


type Colour
    = RGB


type Transforms
    = Move
    | Rotate
    | Scale
    | ScaleX
    | ScaleY
    | MakeTransparent
    | Shadow
    | Bold
    | Italic
    | Underline
    | Strikethrough
    | Sansserif
    | Serif
    | Fixedwidth
    | Size
    | Centered
    | MakeText


type Notifications
    = NotifyTap
    | NotifyTapAt
    | NotifyEnter
    | NotifyEnterAt
    | NotifyLeave
    | NotifyLeaveAt
    | NotifyMouseMoveAt
    | NotifyMouseDown
    | NotifyMouseDownAt
    | NotifyMouseUp
    | NotifyMouseUpAt
    | NotifyTouchStart
    | NotifyTouchStartAt
    | NotifyTouchEnd
    | NotifyTouchEndAt
    | NotifyTouchMoveAt


type LineStyle
    = Solid
    | Dotted
    | Dashed
    | Longdash
    | Dotdash


cyan =
    rgb 0 150 150



-- this case catches every other string and turns it into Hello
-- since there are an infinite number of Strings, we need a catch-all case
-- main view components


keyboard model =
    group
        [ rect 170 120 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( 60, -23 )
        , rect 89 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( 60, 37 )
        , text "1. Choose Your Text!" |> serif |> italic |> size 10 |> filled titleColour |> move ( 18, 34 )
        , rect 20 20 |> filled red

        -- , text "X" |> filled black |> move (113, -60) |> notifyTap (Clear)
        , rect 20 20 |> filled white |> notifyTap Tab |> move ( 100, -57 )
        , text "Aa" |> filled grey |> move ( 93, -60 ) |> notifyTap Tab
        , if model.keyboard <= 2 then
            group <|
                List.map2
                    (\y z ->
                        rect 20 25 |> filled cyan |> move ( y, z + 6 )
                    )
                    (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 25))
                    (List.map (\x -> Basics.toFloat (-21 * (x // 7))) (List.range 0 25))

          else
            group <|
                List.map2
                    (\y z ->
                        rect 20 25 |> filled cyan |> move ( y, z + 6 )
                    )
                    (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 20))
                    (List.map (\x -> Basics.toFloat (-21 * (x // 7))) (List.range 0 20))
        , if model.keyboard == 1 then
            group <|
                List.map3
                    (\ss y z ->
                        text ss |> centered |> size 18 |> filled white |> move ( y, z )
                    )
                    [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ]
                    (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 25))
                    (List.map (\x -> Basics.toFloat (-20 * (x // 7))) (List.range 0 25))
                    ++ List.map3
                        (\y z ss ->
                            rect 20 25 |> filled white |> move ( y, z + 6 ) |> makeTransparent 0 |> notifyTap (Key ss)
                        )
                        (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 25))
                        (List.map (\x -> Basics.toFloat (-21 * (x // 7))) (List.range 0 25))
                        [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ]

          else if model.keyboard == 2 then
            group <|
                List.map3
                    (\ss y z ->
                        text ss |> centered |> size 18 |> filled white |> move ( y, z )
                    )
                    [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" ]
                    (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 25))
                    (List.map (\x -> Basics.toFloat (-20 * (x // 7))) (List.range 0 25))
                    ++ List.map3
                        (\y z ss ->
                            rect 20 25 |> filled white |> move ( y, z + 6 ) |> makeTransparent 0 |> notifyTap (Key ss)
                        )
                        (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 25))
                        (List.map (\x -> Basics.toFloat (-21 * (x // 7))) (List.range 0 25))
                        [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" ]

          else if model.keyboard == 3 then
            group <|
                List.map3
                    (\ss y z ->
                        text ss |> centered |> size 18 |> filled white |> move ( y, z )
                    )
                    [ "`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "[", "]", "\"", ";", "'", ",", ".", "/" ]
                    (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 25))
                    (List.map (\x -> Basics.toFloat (-20 * (x // 7))) (List.range 0 25))
                    ++ List.map3
                        (\y z ss ->
                            rect 20 25 |> filled white |> move ( y, z + 6 ) |> makeTransparent 0 |> notifyTap (Key ss)
                        )
                        (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 20))
                        (List.map (\x -> Basics.toFloat (-21 * (x // 7))) (List.range 0 20))
                        [ "`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "[", "]", "\"", ";", "'", ",", ".", "/" ]
                    ++ [ rect 100 25 |> filled cyan |> move ( 40, Basics.toFloat (-21 * (21 // 7)) + 6 )
                       , text "SPACE" |> filled white |> move ( 20, Basics.toFloat (-21 * (21 // 7)) )
                       , rect 100 25 |> filled white |> makeTransparent 0 |> move ( 40, Basics.toFloat (-21 * (21 // 7)) + 6 ) |> notifyTap (Key " ")
                       ]

          else
            group <|
                List.map3
                    (\ss y z ->
                        text ss |> centered |> size 18 |> filled white |> move ( y, z )
                    )
                    [ "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", "{", "}", "|", "", ":", "<", ">", "?" ]
                    -- missing "
                    (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 25))
                    (List.map (\x -> Basics.toFloat (-20 * (x // 7))) (List.range 0 25))
                    ++ List.map3
                        (\y z ss ->
                            rect 20 25 |> filled white |> move ( y, z + 6 ) |> makeTransparent 0 |> notifyTap (Key ss)
                        )
                        (List.map (\x -> Basics.toFloat (20 * (x |> modBy 7))) (List.range 0 20))
                        (List.map (\x -> Basics.toFloat (-21 * (x // 7))) (List.range 0 20))
                        [ "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", "{", "}", "|", "", ":", "<", ">", "?" ]
        , group [ circle 10 |> filled red, rect 5 15 |> filled white |> rotate (degrees 45), rect 5 15 |> filled white |> rotate (degrees -45) ]
            |> notifyTap ClearOne
            |> move ( 120, -57 )
            |> notifyMouseDown (ButtonDown Delete)
            |> notifyMouseUp (ButtonDown None)
        ]


colours model =
    group
        [ rect 130 75 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -40, -22 )
        , rect 100 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -30, 14 )
        , text "3. Change the Colour!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -75, 11 )
        , group
            [ triangle 8
                |> filled (rgb 255 10 10)
                |> rotate (degrees -30)
                |> move ( -95, -10 )
                |> notifyTap
                    (TransM
                        (\m ->
                            { m
                                | red =
                                    if m.red < 254 then
                                        m.red + 1

                                    else
                                        255
                            }
                        )
                    )
                |> notifyMouseDown (ButtonDown RedUp)
                |> notifyMouseUp (ButtonDown None)
            , triangle 8
                |> filled (rgb 180 140 140)
                |> rotate (degrees 30)
                |> move ( -84, -9 )
                |> notifyTap
                    (TransM
                        (\m ->
                            { m
                                | red =
                                    if m.red > 1 then
                                        m.red - 1

                                    else
                                        0
                            }
                        )
                    )
                |> notifyMouseDown (ButtonDown RedDown)
                |> notifyMouseUp (ButtonDown None)
            , triangle 8
                |> filled (rgb 10 255 10)
                |> rotate (degrees -30)
                |> move ( -65, -10 )
                |> notifyTap
                    (TransM
                        (\m ->
                            { m
                                | green =
                                    if m.green < 254 then
                                        m.green + 1

                                    else
                                        255
                            }
                        )
                    )
                |> notifyMouseDown (ButtonDown GreenUp)
                |> notifyMouseUp (ButtonDown None)
            , triangle 8
                |> filled (rgb 140 180 140)
                |> rotate (degrees 30)
                |> move ( -54, -9 )
                |> notifyTap
                    (TransM
                        (\m ->
                            { m
                                | green =
                                    if m.green > 1 then
                                        m.green - 1

                                    else
                                        0
                            }
                        )
                    )
                |> notifyMouseDown (ButtonDown GreenDown)
                |> notifyMouseUp (ButtonDown None)
            , triangle 8
                |> filled (rgb 10 10 255)
                |> rotate (degrees -30)
                |> move ( -35, -10 )
                |> notifyTap
                    (TransM
                        (\m ->
                            { m
                                | blue =
                                    if m.blue < 254 then
                                        m.blue + 1

                                    else
                                        255
                            }
                        )
                    )
                |> notifyMouseDown (ButtonDown BlueUp)
                |> notifyMouseUp (ButtonDown None)
            , triangle 8
                |> filled (rgb 140 140 180)
                |> rotate (degrees 30)
                |> move ( -24, -9 )
                |> notifyTap
                    (TransM
                        (\m ->
                            { m
                                | blue =
                                    if m.blue > 1 then
                                        m.blue - 1

                                    else
                                        0
                            }
                        )
                    )
                |> notifyMouseDown (ButtonDown BlueDown)
                |> notifyMouseUp (ButtonDown None)
            , text "Lighter" |> size 10 |> filled black |> move ( -90, -30 )
            , rect 32 10
                |> filled blank
                |> move ( -75, -27 )
                |> notifyTap
                    (TransM
                        (\m ->
                            { m
                                | red = clamp 0 255 (m.red + 5)
                                , blue = clamp 0 255 (m.blue + 5)
                                , green = clamp 0 255 (m.green + 5)
                            }
                        )
                    )
            , text "Darker" |> size 10 |> filled black |> move ( -45, -30 )
            , rect 32 10
                |> filled blank
                |> move ( -30, -27 )
                |> notifyTap
                    (TransM
                        (\m ->
                            { m
                                | red = clamp 0 255 (m.red - 5)
                                , blue = clamp 0 255 (m.blue - 5)
                                , green = clamp 0 255 (m.green - 5)
                            }
                        )
                    )
            , text "Colourful" |> size 10 |> filled black |> move ( -100, -50 )
            , rect 40 10
                |> filled blank
                |> move ( -80, -47 )
                |> notifyTap
                    (TransM
                        (\m ->
                            case getBrightest model.red model.green model.blue of
                                All ->
                                    m

                                BrRed ->
                                    { m
                                        | red = clamp 0 255 (m.red + colourAmount * 2)
                                        , blue = clamp 0 255 (m.blue - colourAmount)
                                        , green = clamp 0 255 (m.green - colourAmount)
                                    }

                                BrGreen ->
                                    { m
                                        | red = clamp 0 255 (m.red - colourAmount)
                                        , blue = clamp 0 255 (m.blue - colourAmount)
                                        , green = clamp 0 255 (m.green + colourAmount * 2)
                                    }

                                BrBlue ->
                                    { m
                                        | red = clamp 0 255 (m.red - colourAmount)
                                        , blue = clamp 0 255 (m.blue + colourAmount * 2)
                                        , green = clamp 0 255 (m.green - colourAmount)
                                    }

                                RedAndGreen ->
                                    { m
                                        | red = clamp 0 255 (m.red + colourAmount)
                                        , blue = clamp 0 255 (m.blue - colourAmount * 2)
                                        , green = clamp 0 255 (m.green + colourAmount)
                                    }

                                RedAndBlue ->
                                    { m
                                        | red = clamp 0 255 (m.red + colourAmount)
                                        , blue = clamp 0 255 (m.blue + colourAmount)
                                        , green = clamp 0 255 (m.green - colourAmount * 2)
                                    }

                                BlueAndGreen ->
                                    { m
                                        | red = clamp 0 255 (m.red - colourAmount * 2)
                                        , blue = clamp 0 255 (m.blue + colourAmount)
                                        , green = clamp 0 255 (m.green + colourAmount)
                                    }
                        )
                    )
            , text "Colourless" |> size 10 |> filled black |> move ( -44, -50 )
            , rect 44 10
                |> filled blank
                |> move ( -23, -47 )
                |> notifyTap
                    (TransM
                        (\m ->
                            case getBrightest model.red model.green model.blue of
                                All ->
                                    m

                                BrRed ->
                                    { m
                                        | red = clamp 0 255 (m.red - colourAmount * 2)
                                        , blue = clamp 0 255 (m.blue + colourAmount)
                                        , green = clamp 0 255 (m.green + colourAmount)
                                    }

                                BrGreen ->
                                    { m
                                        | red = clamp 0 255 (m.red + colourAmount)
                                        , blue = clamp 0 255 (m.blue + colourAmount)
                                        , green = clamp 0 255 (m.green - colourAmount * 2)
                                    }

                                BrBlue ->
                                    { m
                                        | red = clamp 0 255 (m.red + colourAmount)
                                        , blue = clamp 0 255 (m.blue - colourAmount * 2)
                                        , green = clamp 0 255 (m.green + colourAmount)
                                    }

                                RedAndGreen ->
                                    { m
                                        | red = clamp 0 255 (m.red - colourAmount)
                                        , blue = clamp 0 255 (m.blue + colourAmount * 2)
                                        , green = clamp 0 255 (m.green - colourAmount)
                                    }

                                RedAndBlue ->
                                    { m
                                        | red = clamp 0 255 (m.red - colourAmount)
                                        , blue = clamp 0 255 (m.blue - colourAmount)
                                        , green = clamp 0 255 (m.green + colourAmount * 2)
                                    }

                                BlueAndGreen ->
                                    { m
                                        | red = clamp 0 255 (m.red + colourAmount * 2)
                                        , blue = clamp 0 255 (m.blue - colourAmount)
                                        , green = clamp 0 255 (m.green - colourAmount)
                                    }
                        )
                    )
            ]
            |> move ( 2, 0 )
        ]


stencils model =
    group
        [ rect 210 120 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( 0, -47 )
        , rect 75 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( 0, 13 )
        , text "1. Pick a Stencil!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -35, 10 )
        , group <|
            List.map2
                (\ss y ->
                    stencilString model ss
                        |> text
                        |> fixedwidth
                        |> size 10
                        |> filled black
                        |> notifyTap (Sten ss)
                        |> move ( -103, -2.5 )
                        |> time1 model ss 210 10
                        |> move ( 0, y )
                )
                [ Circle, Square, Rect, RoundedRect, Text, Ngon, Triangle, Wedge, Oval, BezierPath, Polygon, OpenPolygon ]
                (List.map (\x -> 10 * Basics.toFloat x) (List.range 0 20))
        ]


stamps model =
    group
        [ rect 130 30 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -40, -1 )
        , rect 95 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -40, 14 )
        , text "2. Fill it or Outline it!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -85, 11 )
        , group <|
            List.map2
                (\ss y ->
                    stampString model ss
                        |> text
                        |> fixedwidth
                        |> size 10
                        |> filled black
                        |> notifyTap (Draw ss)
                        |> move ( -63, -2.5 )
                        |> time2 model ss 130 10
                        |> move ( -40, y )
                )
                [ Filled, Outlined ]
                (List.map (\x -> -10 * Basics.toFloat x) (List.range 0 20))
        , styleString model |> text |> fixedwidth |> size 10 |> filled black |> move ( -43, -12.5 ) |> notifyTap LStyle
        ]


transforms model =
    group
        [ rect 140 70 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -35, -21 )
        , rect 95 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -45, 14 )
        , text "5. Apply Transforms!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -85, 11 )
        , group <|
            List.map2
                (\ss y ->
                    transformString model ss
                        |> text
                        |> fixedwidth
                        |> size 10
                        |> filled black
                        |> notifyTap (Toggle ss)
                        |> move ( -68, -2.5 )
                        |> time4 model ss 140 10
                        |> move ( -35, y )
                )
                [ Scale, ScaleX, ScaleY, Rotate, Move, MakeTransparent ]
                (List.map (\x -> -10 * Basics.toFloat x) (List.range 0 20))
        ]


effects model =
    group
        [ rect 140 99 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -35, -37 )
        , rect 95 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -45, 14 )
        , text "5. Apply Effects!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -85, 11 )
        , group <|
            List.map2
                (\ss y ->
                    transformString model ss
                        |> text
                        |> fixedwidth
                        |> size 10
                        |> filled black
                        |> notifyTap (Toggle ss)
                        |> move ( -68, -2.5 )
                        |> time4 model ss 140 10
                        |> move ( -35, y )
                )
                [ Size, Bold, Italic, Underline, Sansserif, Serif, Strikethrough, Fixedwidth, Centered ]
                (List.map (\x -> -10 * Basics.toFloat x) (List.range 0 20))
        ]


tweaks =
    group
        [ rect 157 40 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -26, -6 )
        , rect 55 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -60, 14 )
        , text "4. Tweak it!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -85, 11 )
        , group <|
            List.map2
                (\( str, msg ) ( x, y ) ->
                    str
                        |> text
                        |> fixedwidth
                        |> size 10
                        |> filled black
                        |> notifyTap msg
                        |> move ( -68 + x, -2.5 + y )
                )
                [ {- } ( "up", TransM (\m -> { m | y = m.y + 10 }) )
                     , ( "down", TransM (\m -> { m | y = m.y - 10 }) )
                     , ( "left", TransM (\m -> { m | x = m.x - 10 }) )
                     , ( "right", TransM (\m -> { m | x = m.x + 10 }) )
                     , ( "clockwise", TransM (\m -> { m | angle = m.angle - 30 }) )
                     , ( "counter", TransM (\m -> { m | angle = m.angle + 30 }) )
                     , ( "wider"
                       , TransM
                             (\m ->
                                 { m
                                     | width =
                                         if m.width < 100 then
                                             m.width + 10
                                         else
                                             100
                                 }
                             )
                       )
                     , ( "narrower"
                       , TransM
                             (\m ->
                                 { m
                                     | width =
                                         if m.width > 10 then
                                             m.width - 10
                                         else
                                             10
                                 }
                             )
                       )
                     , ( "taller"
                       , TransM
                             (\m ->
                                 { m
                                     | height =
                                         if m.height < 100 then
                                             m.height + 10
                                         else
                                             100
                                 }
                             )
                       )
                     , ( "shorter"
                       , TransM
                             (\m ->
                                 { m
                                     | height =
                                         if m.height > 10 then
                                             m.height - 10
                                         else
                                             10
                                 }
                             )
                       )


                     ,
                  -}
                  ( "thicker"
                  , TransM
                        (\m ->
                            { m
                                | lineWidth =
                                    if m.lineWidth < 10 then
                                        m.lineWidth + 0.5

                                    else
                                        10
                            }
                        )
                  )
                , ( "thinner"
                  , TransM
                        (\m ->
                            { m
                                | lineWidth =
                                    if m.lineWidth > 0.5 then
                                        m.lineWidth - 0.5

                                    else
                                        0.5
                            }
                        )
                  )
                , ( "bigger"
                  , TransM
                        (\m ->
                            { m
                                | txtsize =
                                    if m.txtsize < 40 then
                                        m.txtsize + 2

                                    else
                                        8
                            }
                        )
                  )
                , ( "smaller"
                  , TransM
                        (\m ->
                            { m
                                | txtsize =
                                    if m.txtsize > 8 then
                                        m.txtsize - 2

                                    else
                                        40
                            }
                        )
                  )
                , ( "Add Shadow"
                  , TransM
                        (\m ->
                            { m
                                | hasShadow = True
                            }
                        )
                  )
                , ( "Remove Shadow"
                  , TransM
                        (\m ->
                            { m
                                | hasShadow = False
                            }
                        )
                  )

                {-
                   , ( "solider"
                     , TransM
                           (\m ->
                               { m
                                   | alpha =
                                       if m.alpha < 1 then
                                           m.alpha + 0.125
                                       else
                                           1
                               }
                           )
                     )
                   , ( "ghostier"
                     , TransM
                           (\m ->
                               { m
                                   | alpha =
                                       if m.alpha > 0 then
                                           m.alpha - 0.125
                                       else
                                           0
                               }
                           )
                     )
                   , ( "bigger"
                     , TransM
                           (\m ->
                               { m
                                   | scl =
                                       if m.scl < 3 then
                                           m.scl + 0.25
                                       else
                                           3
                                   , sclx =
                                       if m.sclx < 3 then
                                           m.sclx + 0.25
                                       else
                                           3
                                   , scly =
                                       if m.scly < 3 then
                                           m.scly + 0.25
                                       else
                                           3
                               }
                           )
                     )
                   , ( "smaller"
                     , TransM
                           (\m ->
                               { m
                                   | scl =
                                       if m.scl > -3 then
                                           m.scl - 0.25
                                       else
                                           -3
                                   , sclx =
                                       if m.sclx > -3 then
                                           m.sclx - 0.25
                                       else
                                           -3
                                   , scly =
                                       if m.scly > -3 then
                                           m.scly - 0.25
                                       else
                                           -3
                               }
                           )
                     )
                -}
                ]
                (List.concat <| List.map (\idx -> [ ( -30, -10 * Basics.toFloat idx ), ( 40, -10 * Basics.toFloat idx ) ]) (List.range 0 20))
        ]


codeForEffects m =
    if m.hasShadow then
        group
            [ rect 160 140 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -20, -58 )
            , rect 84 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -51, 14 )
            , text "6. Code For Effects" |> serif |> italic |> size 10 |> filled titleColour |> move ( -90, 11 )
            , move ( -85, 0 ) <|
                group <|
                    [ stencilString m m.shape |> code |> move ( -10, 0 )
                    , "  |> "
                        ++ stampString m m.draw
                        ++ (if m.draw == Outlined then
                                styleString m ++ " "

                            else
                                ""
                           )
                        ++ clrString m m.clr
                        |> code
                        |> move ( 0, -10 )
                    ]
                        ++ List.map2 (\str y -> str |> code |> move ( 0, y ))
                            (List.concat <|
                                List.map
                                    (\( flag, t ) ->
                                        if flag then
                                            [ "  " ++ transformString m t ]

                                        else
                                            []
                                    )
                                    [ ( m.hasScale, Scale )
                                    , ( m.hasSize, Size )
                                    , ( m.hasBold, Bold )
                                    , ( m.hasItalic, Italic )
                                    , ( m.hasUnderline, Underline )
                                    , ( m.hasStrikethrough, Strikethrough )
                                    , ( m.hasSansserif, Sansserif )
                                    , ( m.hasSerif, Serif )
                                    , ( m.hasFixedwidth, Fixedwidth )
                                    , ( m.hasCentered, Centered )
                                    , ( True, Move )
                                    , ( True, MakeTransparent )
                                    , ( True, Scale )
                                    ]
                            )
                            [ -20, -30, -40, -50, -60, -70, -80, -90, -100, -110, -120 ]
            ]

    else
        text "" |> filled black


yourCode m =
    group
        [ rect 250 180 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( 15, -75 )
        , rect 80 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -55, 14 )
        , text "6. Your code!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -90, 11 )
        , "-- Add this new definition to your code" |> copiable |> move ( -105, 0 )
        , "myStr =" |> copiable |> move ( -105, -10 )
        , move ( -45, -10 ) <|
            group <|
                [ stencilString m m.shape |> copiable |> move ( -10, 0 )
                ]
                    ++ List.map2 (\str y -> str |> copiable |> move ( 0, y ))
                        (List.concat <|
                            List.map
                                (\( flag, t ) ->
                                    if flag then
                                        [ "" ++ transformString m t ]

                                    else
                                        []
                                )
                                [ ( m.hasScale, Scale )
                                , ( m.hasSize, Size )
                                , ( m.hasBold, Bold )
                                , ( m.hasItalic, Italic )
                                , ( m.hasUnderline, Underline )
                                , ( m.hasStrikethrough, Strikethrough )
                                , ( m.hasSansserif, Sansserif )
                                , ( m.hasSerif, Serif )
                                , ( m.hasFixedwidth, Fixedwidth )
                                , ( m.hasCentered, Centered )
                                , ( True, MakeText )
                                ]
                        )
                        [ -10, -20, -30, -40, -50, -60, -70, -80, -90, -100, -110, -120 ]
        , "-- Add the following code to your shapes:" |> copiable |> move ( -105, -30 - howDown m * 10 )
        , (if m.hasShadow then
            codeForShadow

           else
            "myStr" |> copiable
          )
            |> move ( -105, -40 - howDown m * 10 )
            |> move ( 20, 0 )
        ]
        |> move ( 0, 70 )


howDown m =
    let
        add condition =
            if condition then
                1

            else
                0
    in
    add m.hasSize
        + add m.hasBold
        + add m.hasItalic
        + add m.hasUnderline
        + add m.hasSansserif
        + add m.hasSerif
        + add m.hasStrikethrough
        + add m.hasFixedwidth
        + add m.hasCentered


codeForShadow =
    group
        [ "group [ myStr " |> code
        , "      , myStr |> move (1,-2)" |> code |> move ( 0, -10 )
        , "              |> makeTransparent 0.25" |> code |> move ( 0, -20 )

        --   , "              |> scale 1.25 ]" |> code |> move (0,-30)
        , "      ]" |> code |> move ( 0, -30 )
        ]



-- check if the drawn text is the selected function, and if so group a beating rectangle behind it
-- stagger the heartbeats of selected elements to so that they indicate the order of selection


time1 model ss w h shape =
    if ss == model.shape then
        group [ rect w h |> filled (rgba 0 200 200 (0.6 + 0.4 * sin (5 * model.time))), shape ]

    else
        shape


time2 model ss w h shape =
    if ss == model.draw then
        group [ rect w h |> filled (rgba 0 200 200 (0.6 + 0.4 * sin (5 * model.time - 0.5))), shape ]

    else
        shape


time3 model ss w h shape =
    if ss == model.clr then
        group [ rect w h |> filled (rgba 0 200 200 (0.6 + 0.4 * sin (5 * model.time - 1))), shape ]

    else
        shape


time4 model t w h shape =
    if
        case t of
            Move ->
                model.hasMove

            Rotate ->
                model.hasRotate

            Scale ->
                model.hasScale

            ScaleX ->
                model.hasScaleX

            ScaleY ->
                model.hasScaleY

            MakeTransparent ->
                model.hasMakeTransparent

            Shadow ->
                model.hasShadow

            Size ->
                model.hasSize

            Bold ->
                model.hasBold

            Italic ->
                model.hasItalic

            Underline ->
                model.hasUnderline

            Strikethrough ->
                model.hasStrikethrough

            Sansserif ->
                model.hasSansserif

            Serif ->
                model.hasSerif

            Fixedwidth ->
                model.hasFixedwidth

            Centered ->
                model.hasCentered

            MakeText ->
                False
    then
        group [ rect w h |> filled (rgba 0 200 200 (0.6 + 0.4 * sin (5 * model.time - 1.5))), shape ]

    else
        shape



-- view helpers


stencilString m shape =
    case shape of
        Circle ->
            "circle " ++ String.fromFloat m.width

        Square ->
            "square " ++ String.fromFloat m.width

        Rect ->
            "rect " ++ String.fromFloat m.width ++ " " ++ String.fromFloat m.height

        RoundedRect ->
            "roundedRect " ++ String.fromFloat m.width ++ " " ++ String.fromFloat m.height ++ " " ++ String.fromFloat m.roundness

        Oval ->
            "oval " ++ String.fromFloat m.width ++ " " ++ String.fromFloat m.height

        Ngon ->
            "ngon " ++ String.fromInt m.sides ++ " " ++ String.fromFloat m.width

        Triangle ->
            "triangle " ++ String.fromFloat m.width

        Wedge ->
            "wedge " ++ String.fromFloat m.width ++ " " ++ String.fromFloat m.mouth

        BezierPath ->
            "curve (0,0) [Pull (10,0) (20,-10)]"

        Polygon ->
            "polygon [(0,0),(0,-10),(30,0)]"

        OpenPolygon ->
            "openPolygon [(0,0),(0,-10),(30,0)]"

        Text ->
            "text \"" ++ m.txt ++ "\""


stencilFun m =
    case m.shape of
        Circle ->
            circle m.width

        Square ->
            square m.width

        Rect ->
            rect m.width m.height

        RoundedRect ->
            roundedRect m.width m.height m.roundness

        Oval ->
            oval m.width m.height

        Ngon ->
            ngon m.sides m.width

        Triangle ->
            triangle m.width

        Wedge ->
            wedge m.width m.mouth

        BezierPath ->
            curve ( 0, 0 ) [ Pull ( 10, 0 ) ( 20, -10 ) ]

        Polygon ->
            polygon [ ( 0, 0 ), ( 0, -10 ), ( 30, 0 ) ]

        OpenPolygon ->
            openPolygon [ ( 0, 0 ), ( 0, -10 ), ( 30, 0 ) ]

        Text ->
            text m.txt


stampString m stamp =
    case stamp of
        Filled ->
            "filled "

        Outlined ->
            "outlined "


shadow m =
    if m.hasShadow then
        shapeFun m |> move ( m.x + 1, m.y - 2 ) |> makeTransparent 0.25

    else
        rect 20 20 |> filled white |> makeTransparent 0


shapeFun m =
    (text m.txt
        |> (if m.hasSize then
                size m.txtsize

            else
                \x -> x
           )
        |> (if m.hasItalic then
                italic

            else
                \x -> x
           )
        |> (if m.hasBold then
                bold

            else
                \x -> x
           )
        |> (if m.hasUnderline then
                underline

            else
                \x -> x
           )
        |> (if m.hasCentered then
                centered

            else
                \x -> x
           )
        |> (if m.hasStrikethrough then
                strikethrough

            else
                \x -> x
           )
        |> (if m.hasSansserif then
                sansserif

            else
                \x -> x
           )
        |> (if m.hasSerif then
                serif

            else
                \x -> x
           )
        |> (if m.hasFixedwidth then
                fixedwidth

            else
                \x -> x
           )
        |> (if m.draw == Filled then
                filled (colourFun m)

            else
                outlined (lineStyleFun m) (colourFun m)
           )
    )
        |> (if m.hasMove then
                move ( m.x, m.y )

            else
                \x -> x
           )
        |> (if m.hasRotate then
                rotate (degrees m.angle)

            else
                \x -> x
           )
        |> (if m.hasScale then
                scale m.scl

            else
                \x -> x
           )
        |> (if m.hasScaleX then
                scaleX m.scl

            else
                \x -> x
           )
        |> (if m.hasScaleY then
                scaleY m.scl

            else
                \x -> x
           )
        |> (if m.hasMakeTransparent then
                makeTransparent m.alpha

            else
                \x -> x
           )


clrString m clr =
    case clr of
        RGB ->
            "(rgb " ++ String.fromFloat m.red ++ " " ++ String.fromFloat m.green ++ " " ++ String.fromFloat m.blue ++ ")"


colourFun m =
    case m.clr of
        RGB ->
            rgb m.red m.green m.blue


transformString m t =
    case t of
        Move ->
            "|> move (" ++ String.fromFloat (m.x + 2) ++ "," ++ String.fromFloat (m.y - 3) ++ ")"

        Rotate ->
            "|> rotate (degrees " ++ String.fromFloat m.angle ++ ")"

        Scale ->
            "|> scale 1.25"

        ScaleX ->
            "|> scaleX " ++ String.fromFloat m.sclx

        ScaleY ->
            "|> scaleY " ++ String.fromFloat m.scly

        MakeTransparent ->
            "|> makeTransparent 0.25"

        Bold ->
            "|> bold"

        Italic ->
            "|> italic"

        Underline ->
            "|> underline"

        Strikethrough ->
            "|> strikethrough"

        Sansserif ->
            "|> sansserif"

        Serif ->
            "|> serif"

        Fixedwidth ->
            "|> fixedwidth"

        Size ->
            "|> size " ++ String.fromFloat m.txtsize

        Shadow ->
            "-- Add a Shadow!"

        Centered ->
            "|> centered"

        MakeText ->
            "|> "
                ++ stampString m m.draw
                ++ (if m.draw == Outlined then
                        styleString m ++ " "

                    else
                        ""
                   )
                ++ clrString m m.clr


styleString m =
    "("
        ++ (case m.style of
                Solid ->
                    "solid "

                Dotted ->
                    "dotted "

                Dashed ->
                    "dashed "

                Longdash ->
                    "longdash "

                Dotdash ->
                    "dotdash "
           )
        ++ String.fromFloat m.lineWidth
        ++ ")"



--


lineStyleFun m =
    case m.style of
        Solid ->
            solid m.lineWidth

        Dotted ->
            dotted m.lineWidth

        Dashed ->
            dashed m.lineWidth

        Longdash ->
            longdash m.lineWidth

        Dotdash ->
            dotdash m.lineWidth



-- format a string as code


titleColour =
    cyan


code str =
    str |> text |> fixedwidth |> size 9 |> filled black
