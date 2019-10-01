module ShapeCreator exposing (..)

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
    , shape = Circle
    , draw = Filled
    , style = Solid
    , lineWidth = 1
    , width = 10
    , height = 15
    , sides = 5
    , roundness = 5
    , angle = 30
    , mouth = 0.75
    , txt = "Hello"
    , clr = RGB
    , red = 230
    , green = 125
    , blue = 50
    , alpha = 0.5
    , hasMove = False
    , hasRotate = False
    , hasScale = False
    , hasScaleX = False
    , hasScaleY = False
    , hasMakeTransparent = False
    , scl = 2
    , sclx = 2
    , scly = 2
    , x = 50
    , y = 50
    , currentButton = None
    , buttonDownTime = 0
    }


colourAmount =
    3



-- change you app's state based on your new messages


update msg model =
    case msg of
        Tick t _ ->
            { model
                | time = t
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
                , buttonDownTime =
                    case model.currentButton of
                        None ->
                            0

                        _ ->
                            model.buttonDownTime + 0.1
            }

        ButtonDown dir ->
            { model | currentButton = dir, clr = RGB }

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
                            Solid
            }

        CycleText ->
            { model | txt = cycleTxt model.txt }

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

        TransM t ->
            t model

        SetColour clr ->
            { model | clr = clr }

        -- ran out of room for notifications, but left them here for a possible future improvement
        Notif notif ->
            { model | notify = notif }



-- make the Collage fit in VGA screen minus menu bars, for Chromebooks and iPads


view model =
    [ graphPaperCustom 10 1 (rgb 255 137 5) |> makeTransparent 0.25 -- axes and selected coordinate ticks
    , rect 512 0.5 |> filled brown
    , rect 0.5 512 |> filled brown
    , rect 4 0.5 |> filled brown |> move ( 0, 100 )
    , text "(0,100)" |> size 7 |> filled brown |> move ( 3, 100 )
    , rect 4 0.5 |> filled brown |> move ( 0, -100 )
    , text "(0,-100)" |> size 7 |> filled brown |> move ( 3, -100 )
    , rect 0.5 4 |> filled brown |> move ( -100, 0 )
    , text "(-100,0)" |> size 7 |> filled brown |> move ( -100, 3 )
    , rect 0.5 4 |> filled brown |> move ( 100, 0 )
    , text "(100,0)" |> size 7 |> filled brown |> move ( 100, 3 )
    , rect 0.5 4 |> filled brown |> move ( -200, 0 )
    , text "(-200,0)" |> size 7 |> filled brown |> move ( -200, 3 )
    , rect 0.5 4 |> filled brown |> move ( 200, 0 )
    , text "(200,0)" |> size 7 |> filled brown |> move ( 200, 3 ) -- put the drawn shape above the graph paper, but under the transparent controls
    , shapeFun model -- the selection boxes
    , stencils model |> move ( -150, 170 )
    , text "|>" |> filled black |> move ( -40, 165 )
    , stamps model |> move ( 80, 169 )
    , colours model |> move ( 230, 169 )
    , transforms model |> move ( -150, 30 )
    , tweaks |> move ( -150, -50 )
    , yourCode model |> move ( 0, -115 )
    ]



-- messages generated by the framework (Tick) and by user interactions
-- note that we let elm figure out the type of the model by making it a type parameter, m


type Msg m
    = Tick Float GetKeyState
    | Sten Stencil
    | Draw Draw
    | LStyle
    | CycleText
    | SetColour Colour
    | Toggle Transforms
    | TransM (m -> m)
    | Notif Notifications
    | ButtonDown ButtonDir


type ButtonDir
    = RedUp
    | RedDown
    | BlueUp
    | BlueDown
    | GreenUp
    | GreenDown
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
    = Black
    | Blank
    | Blue
    | Brown
    | Charcoal
    | DarkBlue
    | DarkBrown
    | DarkCharcoal
    | DarkGray
    | DarkGreen
    | DarkGrey
    | DarkOrange
    | DarkPurple
    | DarkRed
    | DarkYellow
    | Gray
    | Green
    | Grey
    | HotPink
    | LightBlue
    | LightBrown
    | LightCharcoal
    | LightGray
    | LightGreen
    | LightGrey
    | LightOrange
    | LightPurple
    | LightRed
    | LightYellow
    | Orange
    | Pink
    | Purple
    | Red
    | White
    | Yellow
    | RGB


type Transforms
    = Move
    | Rotate
    | Scale
    | ScaleX
    | ScaleY
    | MakeTransparent


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



-- update helper


cycleTxt s =
    case s of
        "Hello" ->
            "Bonjour"

        "Bonjour" ->
            "Namaste"

        "Namaste" ->
            "Gutten Tag"

        "Gutten Tag" ->
            "Jó napot"

        "Jó napot" ->
            "Dobro utro"

        "Dobro utro" ->
            "Sat Shri Akaal"

        -- "Sat Shri Akaal" ->
        _ ->
            "Hello"



-- this case catches every other string and turns it into Hello
-- since there are an infinite number of Strings, we need a catch-all case
-- main view components


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
                (List.map (\x -> -10 * Basics.toFloat x) (List.range 0 20))
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


colours model =
    group
        [ rect 130 370 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -40, -170 )
        , rect 75 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -40, 14 )
        , text "3. Pick a Colour!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -75, 11 )
        , group <|
            List.map2
                (\ss y ->
                    clrString model ss
                        |> text
                        |> fixedwidth
                        |> size 10
                        |> filled black
                        |> notifyTap (SetColour ss)
                        |> move ( -63, -2.5 )
                        |> time3 model ss 130 10
                        |> move ( -40, y )
                )
                [ Black
                , White
                , Blank
                , Blue
                , DarkBlue
                , LightBlue
                , Brown
                , DarkBrown
                , LightBrown
                , Charcoal
                , DarkCharcoal
                , LightCharcoal
                , Gray
                , DarkGray
                , LightGray
                , Green
                , DarkGreen
                , LightGreen
                , Orange
                , DarkOrange
                , LightOrange
                , Pink
                , HotPink
                , Purple
                , DarkPurple
                , LightPurple
                , Yellow
                , DarkYellow
                , LightYellow
                , Red
                , DarkRed
                , LightRed
                ]
                (List.map (\x -> -10 * Basics.toFloat x) (List.range 0 40))
        , rect 130 46
            |> filled (rgba 1 1 1 0)
            |> notifyTap (SetColour RGB)
            |> time3 model RGB 130 46
            |> move ( -40, -338 )
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
            , "lighter" |> code |> move ( -90, -25 )
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
            , "darker" |> code |> move ( -45, -25 )
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
            , "colourful" |> code |> move ( -100, -40 )
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
            , "colourless" |> code |> move ( -44, -40 )
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
            |> move ( 0, -315 )
        ]


transforms model =
    group
        [ rect 140 70 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -35, -21 )
        , rect 95 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -45, 14 )
        , text "4. Apply Transforms!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -85, 11 )
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


tweaks =
    group
        [ rect 140 150 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -35, -61 )
        , rect 55 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -60, 14 )
        , text "5. Tweak it!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -85, 11 )
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
                [ ( "up", TransM (\m -> { m | y = m.y + 10 }) )
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
                , ( "mouthier"
                  , TransM
                        (\m ->
                            { m
                                | mouth =
                                    if m.mouth > 0 then
                                        m.mouth - 0.125

                                    else
                                        0
                            }
                        )
                  )
                , ( "mouthiless"
                  , TransM
                        (\m ->
                            { m
                                | mouth =
                                    if m.mouth < 1 then
                                        m.mouth + 0.125

                                    else
                                        1
                            }
                        )
                  )
                , ( "rounder"
                  , TransM
                        (\m ->
                            { m
                                | roundness =
                                    if m.roundness < 50 then
                                        m.roundness + 5

                                    else
                                        50
                            }
                        )
                  )
                , ( "sharper"
                  , TransM
                        (\m ->
                            { m
                                | roundness =
                                    if m.roundness > 0 then
                                        m.roundness - 5

                                    else
                                        0
                            }
                        )
                  )
                , ( "thicker"
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
                , ( "more red"
                  , TransM
                        (\m ->
                            { m
                                | red =
                                    if m.red < 248 then
                                        m.red + 7

                                    else
                                        255
                            }
                        )
                  )
                , ( "less red"
                  , TransM
                        (\m ->
                            { m
                                | red =
                                    if m.red > 8 then
                                        m.red - 8

                                    else
                                        0
                            }
                        )
                  )
                , ( "more green"
                  , TransM
                        (\m ->
                            { m
                                | green =
                                    if m.green < 248 then
                                        m.green + 7

                                    else
                                        255
                            }
                        )
                  )
                , ( "less green"
                  , TransM
                        (\m ->
                            { m
                                | green =
                                    if m.green > 8 then
                                        m.green - 8

                                    else
                                        0
                            }
                        )
                  )
                , ( "more blue"
                  , TransM
                        (\m ->
                            { m
                                | blue =
                                    if m.blue < 248 then
                                        m.blue + 7

                                    else
                                        255
                            }
                        )
                  )
                , ( "less blue"
                  , TransM
                        (\m ->
                            { m
                                | blue =
                                    if m.blue > 8 then
                                        m.blue - 8

                                    else
                                        0
                            }
                        )
                  )
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
                , ( "hello?", TransM (\m -> { m | txt = cycleTxt m.txt }) )
                , ( "take sides"
                  , TransM
                        (\m ->
                            { m
                                | sides =
                                    if m.sides > 20 then
                                        3

                                    else
                                        m.sides + 1
                            }
                        )
                  )
                ]
                (List.concat <| List.map (\idx -> [ ( -30, -10 * Basics.toFloat idx ), ( 40, -10 * Basics.toFloat idx ) ]) (List.range 0 20))
        ]


yourCode m =
    group
        [ rect 160 85 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -20, -30 )
        , rect 80 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -55, 14 )
        , text "5. Your code!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -90, 11 )
        , move ( -85, 0 ) <|
            group <|
                [ stencilString m m.shape |> copiable |> move ( -10, 0 )
                , "  |> "
                    ++ stampString m m.draw
                    ++ (if m.draw == Outlined then
                            styleString m ++ " "

                        else
                            ""
                       )
                    ++ clrString m m.clr
                    |> copiable
                    |> move ( 0, -10 )
                ]
                    ++ List.map2 (\str y -> str |> copiable |> move ( 0, y ))
                        (List.concat <|
                            List.map
                                (\( flag, t ) ->
                                    if flag then
                                        [ "  " ++ transformString m t ]

                                    else
                                        []
                                )
                                [ ( m.hasScale, Scale )
                                , ( m.hasScaleX, ScaleX )
                                , ( m.hasScaleY, ScaleY )
                                , ( m.hasRotate, Rotate )
                                , ( m.hasMove, Move )
                                , ( m.hasMakeTransparent, MakeTransparent )
                                ]
                        )
                        [ -20, -30, -40, -50, -60, -70, -80 ]
        ]



-- check if the drawn text is the selected function, and if so group a beating rectangle behind it
-- stagger the heartbeats of selected elements to so that they indicate the order of selection


time1 model ss w h shape =
    if ss == model.shape then
        group [ rect w h |> filled (rgba 255 137 5 (0.6 + 0.4 * sin (5 * model.time))), shape ]

    else
        shape


time2 model ss w h shape =
    if ss == model.draw then
        group [ rect w h |> filled (rgba 255 137 5 (0.6 + 0.4 * sin (5 * model.time - 0.5))), shape ]

    else
        shape


time3 model ss w h shape =
    if ss == model.clr then
        group [ rect w h |> filled (rgba 255 137 5 (0.6 + 0.4 * sin (5 * model.time - 1))), shape ]

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
    then
        group [ rect w h |> filled (rgba 255 137 5 (0.6 + 0.4 * sin (5 * model.time - 1.5))), shape ]

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


shapeFun m =
    (case m.draw of
        Filled ->
            filled (colourFun m) (stencilFun m)

        Outlined ->
            outlined (lineStyleFun m) (colourFun m) (stencilFun m)
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
        Black ->
            "black"

        Blank ->
            "blank"

        Blue ->
            "blue"

        Brown ->
            "brown"

        Charcoal ->
            "charcoal"

        DarkBlue ->
            "darkBlue"

        DarkBrown ->
            "darkBrown"

        DarkCharcoal ->
            "darkCharcoal"

        DarkGray ->
            "darkGray"

        DarkGreen ->
            "darkGreen"

        DarkGrey ->
            "darkGrey"

        DarkOrange ->
            "darkOrange"

        DarkPurple ->
            "darkPurple"

        DarkRed ->
            "darkRed"

        DarkYellow ->
            "darkYellow"

        Gray ->
            "gray"

        Green ->
            "green"

        Grey ->
            "grey"

        HotPink ->
            "hotPink"

        LightBlue ->
            "lightBlue"

        LightBrown ->
            "lightBrown"

        LightCharcoal ->
            "lightCharcoal"

        LightGray ->
            "lightGray"

        LightGreen ->
            "lightGreen"

        LightGrey ->
            "lightGrey"

        LightOrange ->
            "lightOrange"

        LightPurple ->
            "lightPurple"

        LightRed ->
            "lightRed"

        LightYellow ->
            "lightYellow"

        Orange ->
            "orange"

        Pink ->
            "pink"

        Purple ->
            "purple"

        Red ->
            "red"

        White ->
            "white"

        Yellow ->
            "yellow"

        RGB ->
            "(rgb " ++ String.fromFloat m.red ++ " " ++ String.fromFloat m.green ++ " " ++ String.fromFloat m.blue ++ ")"


colourFun m =
    case m.clr of
        Black ->
            black

        Blank ->
            blank

        Blue ->
            blue

        Brown ->
            brown

        Charcoal ->
            charcoal

        DarkBlue ->
            darkBlue

        DarkBrown ->
            darkBrown

        DarkCharcoal ->
            darkCharcoal

        DarkGray ->
            darkGray

        DarkGreen ->
            darkGreen

        DarkGrey ->
            darkGrey

        DarkOrange ->
            darkOrange

        DarkPurple ->
            darkPurple

        DarkRed ->
            darkRed

        DarkYellow ->
            darkYellow

        Gray ->
            gray

        Green ->
            green

        Grey ->
            grey

        HotPink ->
            hotPink

        LightBlue ->
            lightBlue

        LightBrown ->
            lightBrown

        LightCharcoal ->
            lightCharcoal

        LightGray ->
            lightGray

        LightGreen ->
            lightGreen

        LightGrey ->
            lightGrey

        LightOrange ->
            lightOrange

        LightPurple ->
            lightPurple

        LightRed ->
            lightRed

        LightYellow ->
            lightYellow

        Orange ->
            orange

        Pink ->
            pink

        Purple ->
            purple

        Red ->
            red

        White ->
            white

        Yellow ->
            yellow

        RGB ->
            rgb m.red m.green m.blue


transformString m t =
    case t of
        Move ->
            "|> move (" ++ String.fromFloat m.x ++ "," ++ String.fromFloat m.y ++ ")"

        Rotate ->
            "|> rotate (degrees " ++ String.fromFloat m.angle ++ ")"

        Scale ->
            "|> scale " ++ String.fromFloat m.scl

        ScaleX ->
            "|> scaleX " ++ String.fromFloat m.sclx

        ScaleY ->
            "|> scaleY " ++ String.fromFloat m.scly

        MakeTransparent ->
            "|> makeTransparent " ++ String.fromFloat m.alpha


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
    rgb 255 112 0


copiable str =
    str |> text |> selectable |> fixedwidth |> size 10 |> filled black


code str =
    str |> text |> fixedwidth |> size 10 |> filled black
