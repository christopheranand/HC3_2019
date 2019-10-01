module TriCreator exposing (..)

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
    , shape = Triangle
    , draw = Filled
    , style = Solid
    , lineWidth = 1
    , width = 10
    , height = 15
    , angle = 30
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
    , scl = 2
    , sclx = 2
    , scly = 2
    , x = 0
    , y = 0
    , pointOneX = 0
    , pointOneY = 0
    , pointTwoX = -20
    , pointTwoY = 30
    , pointThreeX = 40
    , pointThreeY = 10
    , angleOne = degrees 30
    , angleTwo = degrees 40
    , currentButton = None
    , buttonDownTime = 0
    }


colourAmount =
    3


type ButtonDir
    = Up
    | Down
    | Left
    | Right
    | P1Up
    | P1Down
    | P1Left
    | P1Right
    | P2Up
    | P2Down
    | P2Left
    | P2Right
    | P3Up
    | P3Down
    | P3Left
    | P3Right
    | RedUp
    | RedDown
    | BlueUp
    | BlueDown
    | GreenUp
    | GreenDown
    | RotateClock
    | RotateCounter
    | Thicker
    | Thinner
    | Wider
    | Narrower
    | Taller
    | Shorter
    | Bigger
    | Smaller
    | Ghostier
    | Solider
    | AngleUp
    | AngleDown
    | None



-- change you app's state based on your new messages


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
                , x =
                    case model.currentButton of
                        Left ->
                            model.x - accel model.buttonDownTime

                        Right ->
                            model.x + accel model.buttonDownTime

                        _ ->
                            model.x
                , y =
                    case model.currentButton of
                        Up ->
                            model.y + accel model.buttonDownTime

                        Down ->
                            model.y - accel model.buttonDownTime

                        _ ->
                            model.y
                , pointOneX =
                    case model.currentButton of
                        P1Left ->
                            model.pointOneX - accel model.buttonDownTime

                        P1Right ->
                            model.pointOneX + accel model.buttonDownTime

                        _ ->
                            model.pointOneX
                , pointOneY =
                    case model.currentButton of
                        P1Down ->
                            model.pointOneY - accel model.buttonDownTime

                        P1Up ->
                            model.pointOneY + accel model.buttonDownTime

                        _ ->
                            model.pointOneY
                , pointTwoX =
                    case model.currentButton of
                        P2Left ->
                            model.pointTwoX - accel model.buttonDownTime

                        P2Right ->
                            model.pointTwoX + accel model.buttonDownTime

                        _ ->
                            model.pointTwoX
                , pointTwoY =
                    case model.currentButton of
                        P2Down ->
                            model.pointTwoY - accel model.buttonDownTime

                        P2Up ->
                            model.pointTwoY + accel model.buttonDownTime

                        _ ->
                            model.pointTwoY
                , pointThreeX =
                    case model.currentButton of
                        P3Left ->
                            model.pointThreeX - accel model.buttonDownTime

                        P3Right ->
                            model.pointThreeX + accel model.buttonDownTime

                        _ ->
                            model.pointThreeX
                , pointThreeY =
                    case model.currentButton of
                        P3Down ->
                            model.pointThreeY - accel model.buttonDownTime

                        P3Up ->
                            model.pointThreeY + accel model.buttonDownTime

                        _ ->
                            model.pointThreeY
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
                , angle =
                    case model.currentButton of
                        RotateClock ->
                            Basics.toFloat (angleBound (model.angle - accel model.buttonDownTime))

                        RotateCounter ->
                            Basics.toFloat (angleBound (model.angle + accel model.buttonDownTime))

                        _ ->
                            Basics.toFloat (angleBound model.angle)
                , width =
                    case model.currentButton of
                        Wider ->
                            clamp 10 100 (model.width + accel model.buttonDownTime)

                        Narrower ->
                            clamp 10 100 (model.width - accel model.buttonDownTime)

                        _ ->
                            model.width
                , height =
                    case model.currentButton of
                        Taller ->
                            clamp 10 100 (model.height + accel model.buttonDownTime)

                        Shorter ->
                            clamp 10 100 (model.height - accel model.buttonDownTime)

                        _ ->
                            model.height
                , alpha =
                    case model.currentButton of
                        Solider ->
                            clamp 0 1 (model.alpha + 0.25 * accel model.buttonDownTime)

                        Ghostier ->
                            clamp 0 1 (model.alpha - 0.25 * accel model.buttonDownTime)

                        _ ->
                            model.alpha
                , angleOne =
                    case model.currentButton of
                        AngleUp ->
                            clamp (degrees -180) (degrees 180) (model.angleOne + degrees (accel model.buttonDownTime))

                        AngleDown ->
                            clamp (degrees -180) (degrees 180) (model.angleOne - degrees (accel model.buttonDownTime))

                        _ ->
                            model.angleOne
            }

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

                        _ ->
                            Solid
            }

        MouseUp ->
            { model | currentButton = None }

        ButtonDown dir ->
            { model | currentButton = dir }

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
    [ graphPaperCustom 10 1 (rgb 230 100 230) |> makeTransparent 0.25 -- axes and selected coordinate ticks
    , rect 512 0.5 |> filled pink
    , rect 0.5 512 |> filled pink
    , rect 4 0.5 |> filled pink |> move ( 0, 100 )
    , text "(0,100)" |> size 7 |> filled pink |> move ( 3, 100 )
    , rect 4 0.5 |> filled pink |> move ( 0, -100 )
    , text "(0,-100)" |> size 7 |> filled pink |> move ( 3, -100 )
    , rect 0.5 4 |> filled pink |> move ( -100, 0 )
    , text "(-100,0)" |> size 7 |> filled pink |> move ( -100, 3 )
    , rect 0.5 4 |> filled pink |> move ( 100, 0 )
    , text "(100,0)" |> size 7 |> filled pink |> move ( 100, 3 )
    , rect 0.5 4 |> filled pink |> move ( -200, 0 )
    , text "(-200,0)" |> size 7 |> filled pink |> move ( -200, 3 )
    , rect 0.5 4 |> filled pink |> move ( 200, 0 )
    , text "(200,0)" |> size 7 |> filled pink |> move ( 200, 3 ) -- put the drawn shape above the graph paper, but under the transparent controls
    , shapeFun model -- the selection boxes
    , stencils model |> move ( -150, 170 )
    , code "|>" |> move ( -40, 165 )
    , stamps model |> move ( 80, 169 )
    , colours model |> move ( 230, 169 )
    , transforms model |> move ( 225, 80 )
    , tweaks model |> move ( -150, -50 )
    , yourCode model |> move ( -20, -115 )
    , points model |> move ( 170, 95 )
    , angles model |> move ( 133, -70 )
    ]



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
    | ButtonDown ButtonDir
    | MouseUp



-- the type of stencil selected, these correspond to functions exported by GraphicSVG


type Stencil
    = RightAngle
    | Triangle
    | Isosceles
    | ThreePoint
    | SideAngleSide



--  | Rounded
--  | AngleSideAngle
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
                        |> size 9
                        |> filled black
                        |> notifyTap (Sten ss)
                        |> move ( -103, -2.5 )
                        |> time1 model ss 210 10
                        |> move ( 0, y )
                )
                [ Triangle
                , RightAngle
                , Isosceles

                --, AngleSideAngle
                , SideAngleSide
                , ThreePoint
                ]
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
            , "Lighter" |> code |> move ( -90, -30 )
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
            , "Darker" |> code |> move ( -45, -30 )
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
            , "Colourful" |> code |> move ( -100, -50 )
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
            , "Colourless" |> code |> move ( -44, -50 )
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
            |> move ( 2, -8 )
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
                [ RGB
                ]
                (List.map (\x -> -10 * Basics.toFloat x) (List.range 0 40))
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


leftArrowKey tricol x y =
    polygon [ ( 0, 15 ), ( -20, 0 ), ( 0, -15 ) ] |> filled tricol |> addOutline (solid 1) (rgba 0 0 0 0.2) |> move ( x, y )


rightArrowKey tricol x y =
    polygon [ ( 0, -15 ), ( 20, 0 ), ( 0, 15 ) ] |> filled tricol |> addOutline (solid 1) (rgba 0 0 0 0.2) |> move ( x, y )


downArrowKey tricol x y =
    polygon [ ( -15, 0 ), ( 0, -20 ), ( 15, 0 ) ] |> filled tricol |> addOutline (solid 1) (rgba 0 0 0 0.2) |> move ( x, y )


upArrowKey tricol x y =
    polygon [ ( 15, 0 ), ( 0, 20 ), ( -15, 0 ) ] |> filled tricol |> addOutline (solid 1) (rgba 0 0 0 0.2) |> move ( x, y )


tweaks model =
    group
        [ rect 140 150 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -35, -61 )
        , rect 55 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -60, 14 )
        , text "5. Tweak it!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -85, 11 )
        , group
            [ upArrowKey lightPurple -40 -85
                |> makeTransparent
                    (case model.hasMove of
                        True ->
                            0.6

                        False ->
                            0.1
                    )
                |> notifyTap
                    (case model.hasMove of
                        True ->
                            TransM (\m -> { m | y = m.y + 1 })

                        False ->
                            TransM (\m -> m)
                    )
                |> notifyMouseDown (ButtonDown Up)
                |> notifyMouseUp (ButtonDown None)
            , downArrowKey lightPurple -40 -115
                |> makeTransparent
                    (case model.hasMove of
                        True ->
                            0.6

                        False ->
                            0.1
                    )
                |> notifyTap
                    (case model.hasMove of
                        True ->
                            TransM (\m -> { m | y = m.y - 1 })

                        False ->
                            TransM (\m -> m)
                    )
                |> notifyMouseDown (ButtonDown Down)
                |> notifyMouseUp (ButtonDown None)
            , rightArrowKey lightPurple -25 -100
                |> makeTransparent
                    (case model.hasMove of
                        True ->
                            0.6

                        False ->
                            0.1
                    )
                |> notifyTap
                    (case model.hasMove of
                        True ->
                            TransM (\m -> { m | x = m.x + 1 })

                        False ->
                            TransM (\m -> m)
                    )
                |> notifyMouseDown (ButtonDown Right)
                |> notifyMouseUp (ButtonDown None)
            , leftArrowKey lightPurple -55 -100
                |> makeTransparent
                    (case model.hasMove of
                        True ->
                            0.6

                        False ->
                            0.1
                    )
                |> notifyTap
                    (case model.hasMove of
                        True ->
                            TransM (\m -> { m | x = m.x - 1 })

                        False ->
                            TransM (\m -> m)
                    )
                |> notifyMouseDown (ButtonDown Left)
                |> notifyMouseUp (ButtonDown None)
            ]
            |> move ( -7, 0 )
        , group <|
            List.map2
                (\( str, ( msg, msgd, msgu ) ) ( x, y ) ->
                    str
                        |> text
                        |> fixedwidth
                        |> size 10
                        |> filled black
                        |> notifyTap msg
                        |> notifyMouseDown msgd
                        |> notifyMouseUp msgu
                        |> move ( -68 + x, -2.5 + y )
                )
                [ ( "clockwise", ( TransM (\m -> { m | angle = Basics.toFloat (angleBound (m.angle - 1)) }), ButtonDown RotateClock, ButtonDown None ) )
                , ( "counter", ( TransM (\m -> { m | angle = Basics.toFloat (angleBound (m.angle + 1)) }), ButtonDown RotateCounter, ButtonDown None ) )
                , ( "wider"
                  , ( TransM
                        (\m ->
                            { m
                                | width =
                                    if m.width < 100 then
                                        m.width + 1

                                    else
                                        100
                            }
                        )
                    , ButtonDown Wider
                    , ButtonDown None
                    )
                  )
                , ( "narrower"
                  , ( TransM
                        (\m ->
                            { m
                                | width =
                                    if m.width > 10 then
                                        m.width - 1

                                    else
                                        10
                            }
                        )
                    , ButtonDown Narrower
                    , ButtonDown None
                    )
                  )
                , ( "taller"
                  , ( TransM
                        (\m ->
                            { m
                                | height =
                                    if m.height < 100 then
                                        m.height + 1

                                    else
                                        100
                            }
                        )
                    , ButtonDown Taller
                    , ButtonDown None
                    )
                  )
                , ( "shorter"
                  , ( TransM
                        (\m ->
                            { m
                                | height =
                                    if m.height > 10 then
                                        m.height - 1

                                    else
                                        10
                            }
                        )
                    , ButtonDown Shorter
                    , ButtonDown None
                    )
                  )
                , ( "thicker"
                  , ( TransM
                        (\m ->
                            { m
                                | lineWidth =
                                    if m.lineWidth < 10 then
                                        m.lineWidth + 0.5

                                    else
                                        10
                            }
                        )
                    , ButtonDown Thicker
                    , ButtonDown None
                    )
                  )
                , ( "thinner"
                  , ( TransM
                        (\m ->
                            { m
                                | lineWidth =
                                    if m.lineWidth > 0.5 then
                                        m.lineWidth - 0.5

                                    else
                                        0.5
                            }
                        )
                    , ButtonDown Thinner
                    , ButtonDown None
                    )
                  )
                , ( "solider"
                  , ( TransM
                        (\m ->
                            { m
                                | alpha =
                                    if m.alpha < 1 then
                                        m.alpha + 0.125

                                    else
                                        1
                            }
                        )
                    , ButtonDown Solider
                    , ButtonDown None
                    )
                  )
                , ( "ghostier"
                  , ( TransM
                        (\m ->
                            { m
                                | alpha =
                                    if m.alpha > 0 then
                                        m.alpha - 0.125

                                    else
                                        0
                            }
                        )
                    , ButtonDown Ghostier
                    , ButtonDown None
                    )
                  )
                , ( "bigger"
                  , ( TransM
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
                    , ButtonDown Bigger
                    , ButtonDown None
                    )
                  )
                , ( "smaller"
                  , ( TransM
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
                    , ButtonDown Smaller
                    , ButtonDown None
                    )
                  )
                ]
                (List.concat <| List.map (\idx -> [ ( -30, -10 * Basics.toFloat idx ), ( 40, -10 * Basics.toFloat idx ) ]) (List.range 0 20))
        ]


yourCode m =
    group
        [ rect 260 85 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( 30, -30 )
        , rect 80 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -55, 14 )
        , text "8. Your code!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -90, 11 )
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


points model =
    group
        [ text "6. Move the Points!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -390, 8 )
        , group
            [ text "Point 1" |> serif |> size 10 |> filled black |> move ( -410, -21 )
            , group
                [ upArrowKey lightPurple -40 -80
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointOneY = m.pointOneY + 1 }))
                    |> notifyMouseDown (ButtonDown P1Up)
                    |> notifyMouseUp (ButtonDown None)
                , downArrowKey lightPurple -40 -120
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointOneY = m.pointOneY - 1 }))
                    |> notifyMouseDown (ButtonDown P1Down)
                    |> notifyMouseUp (ButtonDown None)
                , rightArrowKey lightPurple -20 -100
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointOneX = m.pointOneX + 1 }))
                    |> notifyMouseDown (ButtonDown P1Right)
                    |> notifyMouseUp (ButtonDown None)
                , leftArrowKey lightPurple -60 -100
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointOneX = m.pointOneX - 1 }))
                    |> notifyMouseDown (ButtonDown P1Left)
                    |> notifyMouseUp (ButtonDown None)
                ]
                |> scale 0.55
                |> move ( -375, 37 )
            ]
        , group
            [ text "Point 2" |> serif |> size 10 |> filled black |> move ( -410, -21 )
            , group
                [ upArrowKey lightPurple -40 -80
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointTwoY = m.pointTwoY + 1 }))
                    |> notifyMouseDown (ButtonDown P2Up)
                    |> notifyMouseUp (ButtonDown None)
                , downArrowKey lightPurple -40 -120
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointTwoY = m.pointTwoY - 1 }))
                    |> notifyMouseDown (ButtonDown P2Down)
                    |> notifyMouseUp (ButtonDown None)
                , rightArrowKey lightPurple -20 -100
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointTwoX = m.pointTwoX + 1 }))
                    |> notifyMouseDown (ButtonDown P2Right)
                    |> notifyMouseUp (ButtonDown None)
                , leftArrowKey lightPurple -60 -100
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointTwoX = m.pointTwoX - 1 }))
                    |> notifyMouseDown (ButtonDown P2Left)
                    |> notifyMouseUp (ButtonDown None)
                ]
                |> scale 0.55
                |> move ( -375, 37 )
            ]
            |> move ( 55, 0 )
        , group
            [ text "Point 3" |> serif |> size 10 |> filled black |> move ( -410, -21 )
            , group
                [ upArrowKey lightPurple -40 -80
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointThreeY = m.pointThreeY + 1 }))
                    |> notifyMouseDown (ButtonDown P3Up)
                    |> notifyMouseUp (ButtonDown None)
                , downArrowKey lightPurple -40 -120
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointThreeY = m.pointThreeY - 1 }))
                    |> notifyMouseDown (ButtonDown P3Down)
                    |> notifyMouseUp (ButtonDown None)
                , rightArrowKey lightPurple -20 -100
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointThreeX = m.pointThreeX + 1 }))
                    |> notifyMouseDown (ButtonDown P3Right)
                    |> notifyMouseUp (ButtonDown None)
                , leftArrowKey lightPurple -60 -100
                    |> makeTransparent 0.4
                    |> notifyTap (TransM (\m -> { m | pointThreeX = m.pointThreeX - 1 }))
                    |> notifyMouseDown (ButtonDown P3Left)
                    |> notifyMouseUp (ButtonDown None)
                ]
                |> scale 0.55
                |> move ( -375, 37 )
            ]
            |> move ( 110, 0 )
        ]
        |> move ( 5, 0 )


angles model =
    group
        [ text "7. Change the Angle!" |> serif |> italic |> size 10 |> filled titleColour
        , group
            [ text "Angle"
                |> serif
                |> size 10
                |> filled black
                |> move
                    (case model.shape of
                        SideAngleSide ->
                            case model.hasMove of
                                True ->
                                    ( model.x - 175, model.y + 60 )

                                False ->
                                    ( -175, 60 )

                        -- AngleSideAngle -> ( case model.hasMove of
                        --                      True  -> (model.x - 175 ,model.y + 60)
                        --                      False -> (-175,60))
                        _ ->
                            ( 0, -20 )
                    )
            , group
                [ wideAngle |> scale 0.8 |> makeTransparent 0.7
                , rect 22 18 |> filled blank |> makeTransparent 0.3 |> move ( 9.5, 5 )
                ]
                |> move
                    (case model.shape of
                        SideAngleSide ->
                            case model.hasMove of
                                True ->
                                    ( model.x - 170, model.y + 75 )

                                False ->
                                    ( -170, 75 )

                        --  AngleSideAngle -> ( case model.hasMove of
                        --                        True  ->(model.x - 150 ,model.y + 75)
                        --                       False ->(-150,75)
                        --                 )
                        _ ->
                            ( 42, -19 )
                    )
                |> notifyTap (TransM (\m -> { m | angleOne = clamp (degrees -180) (degrees 180) (m.angleOne + degrees 5) }))
                |> notifyMouseDown (ButtonDown AngleUp)
                |> notifyMouseUp MouseUp
            , group
                [ narrowAngle |> scale 0.8 |> makeTransparent 0.7
                , rect 22 18 |> filled blank |> move ( 9.5, 5 )
                ]
                |> move
                    (case model.shape of
                        SideAngleSide ->
                            case model.hasMove of
                                True ->
                                    ( model.x - 150, model.y + 50 )

                                False ->
                                    ( -150, 50 )

                        -- AngleSideAngle -> ( case model.hasMove of
                        --                     True  ->(model.x - 130 ,model.y + 60)
                        --                     False ->(-130,60)
                        --                  )
                        _ ->
                            ( 72, -19 )
                    )
                |> notifyTap (TransM (\m -> { m | angleOne = clamp (degrees -180) (degrees 180) (m.angleOne - degrees 5) }))
                |> notifyMouseDown (ButtonDown AngleDown)
                |> notifyMouseUp MouseUp
            ]

        {--, group [ text "Angle 2" |> serif |> size 10 |> filled black |> move (0,-20)
                  , group[ rect 17 3 |> filled black |> move (50,-17)
                         , rect 3 17 |> filled black |> move (50,-17)
                         ] |> notifyTap (TransM (\m -> { m | angleTwo = m.angleTwo + (degrees 5) }))
                  , rect 17 4 |> filled black |> move (72,-17) |> notifyTap (TransM (\m -> { m | angleTwo = m.angleTwo - (degrees 5) }))
                  ] |> move(0,-40)
--}
        ]



-- check if the drawn text is the selected function, and if so group a beating rectangle behind it
-- stagger the heartbeats of selected elements to so that they indicate the order of selection


time1 model ss w h shape =
    if ss == model.shape then
        group [ rect w h |> filled (rgba 230 100 230 (0.6 + 0.4 * sin (5 * model.time))), shape ]

    else
        shape


time2 model ss w h shape =
    if ss == model.draw then
        group [ rect w h |> filled (rgba 230 100 230 (0.6 + 0.4 * sin (5 * model.time - 0.5))), shape ]

    else
        shape


time3 model ss w h shape =
    if ss == model.clr then
        group [ rect w h |> filled (rgba 230 100 230 (0.6 + 0.4 * sin (5 * model.time - 1))), shape ]

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
        group [ rect w h |> filled (rgba 230 100 230 (0.6 + 0.4 * sin (5 * model.time - 1.5))), shape ]

    else
        shape



-- view helpers


stencilString m shape =
    case shape of
        Triangle ->
            "triangle " ++ String.fromFloat m.width

        RightAngle ->
            "rightTriangle " ++ String.fromFloat m.width ++ " " ++ String.fromFloat m.height

        Isosceles ->
            "isosceles " ++ String.fromFloat m.width ++ " " ++ String.fromFloat m.height

        --  AngleSideAngle ->
        --      "aSATriangle (degrees " ++ String.fromFloat (toDegrees m.angleOne) ++ ") " ++ String.fromFloat m.width ++ " (degrees " ++ String.fromFloat (toDegrees m.angleTwo) ++ ")"
        SideAngleSide ->
            "sideAngleSide " ++ String.fromFloat m.height ++ " (degrees " ++ String.fromInt (toDegrees m.angleOne) ++ ") " ++ String.fromFloat m.width

        ThreePoint ->
            "polygon [("
                ++ String.fromFloat m.pointOneX
                ++ ","
                ++ String.fromFloat m.pointOneY
                ++ "),("
                ++ String.fromFloat m.pointTwoX
                ++ ","
                ++ String.fromFloat m.pointTwoY
                ++ "),("
                ++ String.fromFloat m.pointThreeX
                ++ ","
                ++ String.fromFloat m.pointThreeY
                ++ ")]"



--   Rounded ->
--     "roundedTriangle " ++ String.fromFloat m.width


stencilFun m =
    case m.shape of
        Triangle ->
            triangle m.width

        Isosceles ->
            isosceles m.width m.height

        RightAngle ->
            rightTriangle m.width m.height

        --  AngleSideAngle ->
        --    aSATriangle m.angleOne m.width m.angleTwo
        -- this might have been defined wrong... will have to revisit
        SideAngleSide ->
            sideAngleSide m.height m.angleOne m.width

        ThreePoint ->
            polygon [ ( m.pointOneX, m.pointOneY ), ( m.pointTwoX, m.pointTwoY ), ( m.pointThreeX, m.pointThreeY ) ]



--   Rounded ->
--     roundedTriangle m.width


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
        RGB ->
            "(rgb " ++ String.fromFloat m.red ++ " " ++ String.fromFloat m.green ++ " " ++ String.fromFloat m.blue ++ ")"


colourFun m =
    case m.clr of
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
    rgb 150 20 170


code str =
    str |> text |> fixedwidth |> size 10 |> filled black


toDegrees : Float -> Int
toDegrees radianValue =
    radianValue * 180 / pi |> round


wideAngle =
    group
        [ arrow ( 10, 5 ) ( 3, 11 ) green 2
        , line ( 0, 0 ) ( 20, 0 ) |> outlined (solid 2) black
        , line ( 0, 0 ) ( 16, 8 ) |> outlined (solid 2) black
        ]


narrowAngle =
    group
        [ line ( 0, 0 ) ( 20, 0 ) |> outlined (solid 2) black
        , line ( 0, 0 ) ( 13, 13 ) |> outlined (solid 2) black
        , arrow ( 10, 10 ) ( 16, 4 ) red 2
        ]


roundedTriangle size =
    curve ( 0.5 * size, 0 )
        [ Pull ( 0, size ) ( -0.5 * size, 0 )
        , Pull ( -1 * size, -1 * size ) ( 0, -1 * size )
        , Pull ( size, -1 * size ) ( 0.5 * size, 0 )
        ]
