module PolygonCreator exposing (..)

{-
   Copyright 2017-2019 Christopher Kumar Anand and students of McMaster University

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

import Array exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import List
import ShapeCreateAssets exposing (..)
import String exposing (..)
import Tuple


init =
    { time = 0
    , flash = 1
    , notify = NotifyTap
    , shape = Triangle
    , draw = Filled
    , style = Solid
    , lineWidth = 1
    , width = 5
    , height = 5
    , sides = 5
    , roundness = 5
    , angle = 60
    , clr = RGB
    , red = 0
    , green = 182
    , blue = 255
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
    , shapex = 50
    , shapey = 50
    , x = 50
    , y = 50
    , points = [ ( 0, 0 ) ]
    , hasPolygon = True
    , hasPoints = True
    , currentPoint = -1
    , numPoints = 0
    , hasTrack = False
    , hasPoint1 = True
    , hasPoint2 = True
    , hasPoint3 = False
    , hasPoint4 = False
    , hasPoint5 = False
    , hasPoint6 = False
    , hasPoint7 = False
    , hasPoint8 = False
    , hasPoint9 = False
    , hasPoint10 = False
    , thePoints = [ True, False, False, False, False, False, False, False, False, True ]
    , point1 = ( 0, 0 )
    , point2 = ( 0, 0 )
    , point3 = ( 0, 0 )
    , point4 = ( 0, 0 )
    , point5 = ( 0, 0 )
    , point6 = ( 0, 0 )
    , point7 = ( 0, 0 )
    , point8 = ( 0, 0 )
    , point9 = ( 0, 0 )
    , point10 = ( 0, 0 )
    , buttonDownTime = 0
    , currentButton = None
    , trackpadStartPress = No
    , trackpadDown = False
    , trackpadLeft = False
    , trackpadRight = False
    }



-- added to let arrows use hold click


type ButtonDir
    = RedUp
    | RedDown
    | GreenUp
    | GreenDown
    | BlueUp
    | BlueDown
    | None


accel x =
    Basics.toFloat (round (clamp 0 12 (x ^ 2) / 4))



{- }
   changePoint model direct
                       case model.currentPoint of
                           1  -> { model| point1 = movePoint model.point1 direct, points = Array.toList (set (model.currentPoint - 1 ) (movePoint model.point1 direct) (Array.fromList model.points))}
                           2  -> { model| point2 = movePoint model.point2 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point2 direct) (Array.fromList model.points))}
                           3  -> { model| point3 = movePoint model.point3 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point3 direct) (Array.fromList model.points))}
                           4  -> { model| point4 = movePoint model.point4 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point4 direct) (Array.fromList model.points))}
                           5  -> { model| point5 = movePoint model.point5 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point5 direct) (Array.fromList model.points))}
                           6  -> { model| point6 = movePoint model.point6 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point6 direct) (Array.fromList model.points))}
                           7  -> { model| point7 = movePoint model.point7 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point7 direct) (Array.fromList model.points))}
                           8  -> { model| point8 = movePoint model.point8 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point8 direct) (Array.fromList model.points))}
                           9  -> { model| point9 = movePoint model.point9 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point9 direct) (Array.fromList model.points))}
                           10 -> { model| point10 = movePoint model.point10 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point10 direct) (Array.fromList model.points))}
                           _  -> { model | point1= model.point1}
-}


whichPoint m =
    case m.currentPoint of
        1 ->
            m.point1

        2 ->
            m.point2

        3 ->
            m.point3

        4 ->
            m.point4

        5 ->
            m.point5

        6 ->
            m.point6

        7 ->
            m.point7

        8 ->
            m.point8

        9 ->
            m.point9

        _ ->
            m.point10



-- change you app's state based on your new messages


clickHold m p pointVal direct =
    if m.currentPoint == p then
        movePoint pointVal direct

    else
        pointVal


this m p pointVal dir =
    if m.currentPoint /= 10 then
        Array.toList (set (m.currentPoint - 1) (clickHold m p pointVal dir) (Array.fromList m.points))

    else
        m.points


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
                , point1 = clickHold model 1 model.point1 model.trackpadStartPress
                , points = this model model.currentPoint (whichPoint model) model.trackpadStartPress
                , point2 = clickHold model 2 model.point2 model.trackpadStartPress --,  points =  this model 2 model.point2 model.trackpadStartPress
                , point3 = clickHold model 3 model.point3 model.trackpadStartPress --,  points = this model 3 model.point3 model.trackpadStartPress) (A
                , point4 = clickHold model 4 model.point4 model.trackpadStartPress --,  points = this model 4 model.point4 model.trackpadStartPress) (A
                , point5 = clickHold model 5 model.point5 model.trackpadStartPress --,  points = this model 5 model.point5 model.trackpadStartPress) (A
                , point6 = clickHold model 6 model.point6 model.trackpadStartPress --,  points = this model 6 model.point6 model.trackpadStartPress) (A
                , point7 = clickHold model 7 model.point7 model.trackpadStartPress --,  points = this model 7 model.point7 model.trackpadStartPress) (A
                , point8 = clickHold model 8 model.point8 model.trackpadStartPress --,  points = this model 8 model.point8 model.trackpadStartPress) (A
                , point9 = clickHold model 9 model.point9 model.trackpadStartPress --,  points = this model 9 model.point9 model.trackpadStartPress) (A
                , point10 = clickHold model 10 model.point10 model.trackpadStartPress --,  points = Array.toList (set (model.currentPoint - 1 ) (clickHold model 10 model.point10 model.trackpadStartPress) (Array.fromList model.points))

                {- }  , points = if model.trackpadStartPress == No then
                   [model.point1,model.point2,model.point3,model.point4, model.point5,model.point6,model.point7,model.point8,model.point9]
                   else
                       model.points
                -}
            }

        -- handling long click
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

        MovePoint direct ->
            case model.currentPoint of
                1 ->
                    { model | point1 = movePoint model.point1 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point1 direct) (Array.fromList model.points)) }

                2 ->
                    { model | point2 = movePoint model.point2 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point2 direct) (Array.fromList model.points)) }

                3 ->
                    { model | point3 = movePoint model.point3 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point3 direct) (Array.fromList model.points)) }

                4 ->
                    { model | point4 = movePoint model.point4 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point4 direct) (Array.fromList model.points)) }

                5 ->
                    { model | point5 = movePoint model.point5 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point5 direct) (Array.fromList model.points)) }

                6 ->
                    { model | point6 = movePoint model.point6 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point6 direct) (Array.fromList model.points)) }

                7 ->
                    { model | point7 = movePoint model.point7 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point7 direct) (Array.fromList model.points)) }

                8 ->
                    { model | point8 = movePoint model.point8 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point8 direct) (Array.fromList model.points)) }

                9 ->
                    { model | point9 = movePoint model.point9 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point9 direct) (Array.fromList model.points)) }

                10 ->
                    { model | point10 = movePoint model.point10 direct, points = Array.toList (set (model.currentPoint - 1) (movePoint model.point10 direct) (Array.fromList model.points)) }

                _ ->
                    { model | point1 = model.point1 }

        SetPoint ->
            { model | points = setPoint model, hasPolygon = True }

        Clear ->
            { model | points = [ ( 0, 0 ) ], hasPolygon = True, hasPoints = True }

        CheckPoint x ->
            { model | currentPoint = x, hasTrack = False, flash = 0 }

        AddPoint ->
            { model
                | thePoints = Array.toList (set (model.numPoints + 1) True (Array.fromList model.thePoints))
                , numPoints =
                    if model.numPoints < 8 then
                        model.numPoints + 1

                    else
                        model.numPoints
                , points =
                    if model.numPoints < 8 then
                        model.points ++ [ ( 0, 0 ) ]

                    else
                        model.points
                , hasTrack = True
                , currentPoint = -1
            }

        DeletePoint ->
            { model
                | thePoints = Array.toList (set model.numPoints False (Array.fromList model.thePoints))
                , numPoints =
                    if model.numPoints > 0 then
                        model.numPoints - 1

                    else
                        model.numPoints
                , points =
                    if model.numPoints > 0 then
                        List.take model.numPoints model.points

                    else
                        model.points
                , hasTrack = True
                , currentPoint = -1
            }

        LongPress dir ->
            case dir of
                Up ->
                    { model | trackpadStartPress = Up }

                Down ->
                    { model | trackpadStartPress = Down }

                Left ->
                    { model | trackpadStartPress = Left }

                Right ->
                    { model | trackpadStartPress = Right }

                _ ->
                    { model | trackpadStartPress = No }

        Buttondown dir ->
            { model | currentButton = dir }

        -- for hold click
        MouseUp ->
            { model | currentButton = None }



-- make the Collage fit in VGA screen minus menu bars, for Chromebooks and iPads


movePointX m d =
    case d of
        Left ->
            m - 5

        Right ->
            m + 5

        _ ->
            m


movePointY m d =
    case d of
        Down ->
            m - 5

        Up ->
            m + 5

        _ ->
            m


movePoint2 m d =
    case d of
        Left ->
            (\( x, y ) -> ( x - 1, y )) m

        Right ->
            (\( x, y ) -> ( x + 1, y )) m

        Up ->
            (\( x, y ) -> ( x, y + 1 )) m

        Down ->
            (\( x, y ) -> ( x, y - 1 )) m

        No ->
            m


movePoint m d =
    case d of
        Left ->
            (\( x, y ) -> ( x - 1, y )) m

        Right ->
            (\( x, y ) -> ( x + 1, y )) m

        Up ->
            (\( x, y ) -> ( x, y + 1 )) m

        Down ->
            (\( x, y ) -> ( x, y - 1 )) m

        No ->
            m


setPoint m =
    m.points ++ [ ( m.x, m.y ) ]


view model =
    [ graphPaper 10 -- axes and selected coordinate ticks
    , rect 512 0.5 |> filled darkBlue
    , rect 0.5 512 |> filled darkBlue
    , rect 4 0.5 |> filled darkBlue |> move ( 0, 100 )
    , text "(0,100)" |> size 7 |> filled darkBlue |> move ( 3, 100 )
    , rect 4 0.5 |> filled darkBlue |> move ( 0, -100 )
    , text "(0,-100)" |> size 7 |> filled darkBlue |> move ( 3, -100 )
    , rect 0.5 4 |> filled darkBlue |> move ( -100, 0 )
    , text "(-100,0)" |> size 7 |> filled darkBlue |> move ( -100, 3 )
    , rect 0.5 4 |> filled darkBlue |> move ( 100, 0 )
    , text "(100,0)" |> size 7 |> filled darkBlue |> move ( 100, 3 )
    , rect 0.5 4 |> filled darkBlue |> move ( -200, 0 )
    , text "(-200,0)" |> size 7 |> filled darkBlue |> move ( -200, 3 )
    , rect 0.5 4 |> filled darkBlue |> move ( 200, 0 )
    , text "(200,0)" |> size 7 |> filled darkBlue |> move ( 200, 3 ) -- put the drawn shape above the graph paper, but under the transparent control
    , shapeFun model

    --       , tracker model
    , vertices model
    , code "|>" |> move ( -45, 165 )
    , stamps model |> move ( 80, 169 )

    --, code "|>" |> move ( 95, 165 )
    , colours model |> move ( 230, 139 )

    -- , transforms model |> move ( -150, 30 )
    , tweaks |> move ( -150, -70 )
    , rect 80 12 |> outlined (solid 1) red |> move ( -190, 135 ) |> makeTransparent (model.flash * abs (sin (3 * model.time)))
    , clickhere model |> move ( 1, 56 ) |> makeTransparent (model.flash * abs (sin model.time)) |> move ( -180, 100 ) |> scale (abs (sin model.time))
    , polyCode model |> move ( -155, -115 ) |> move ( 0, 280 )

    --, yourCode model |> move ( -155, -115 ) |> move (155, -10)
    , flash model
    , keypad (moveTrack model.hasTrack model) (rgba 49 49 129 0.2) |> move ( 5, 0 )
    , button model
    , yourCode1 model |> move ( 0, -120 )

    --   , text (String.fromFloat model.thePoints) |> filled black |> move (-20,0)
    --  , text (String.fromFloat model.points)  |> filled black |> move (0,-20)
    -- , text (String.fromFloat model.numPoints)  |> filled black |> move (0,-40)
    ]



--"polygon " ++ (String.fromFloat m.points)++(String.fromFloat m.point10)


yourCode1 m =
    group
        [ rect 490 85 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( 0, -30 )
        , rect 110 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -145, 14 )
        , text "5. Your (copiable) code! Use cmd/ctrl-A, cmd/ctrl-C. " |> serif |> italic |> size 10 |> filled titleColour |> move ( -190, 11 )
        , pullsText1 m |> scale 0.33 |> move ( -240, 0 )
        , move ( -220, 0 ) <|
            group <|
                [ "      |> "
                    ++ stampString m m.draw
                    ++ (if m.draw == Outlined then
                            styleString m ++ " "

                        else
                            ""
                       )
                    ++ clrString m m.clr
                    |> copiable
                    |> scale 0.33
                    |> move ( 0, -5 )
                ]
                    ++ List.map2 (\str y -> str |> code |> move ( 0, y ))
                        (List.concat <|
                            List.map
                                (\( flag, t ) ->
                                    if flag then
                                        [ " " ++ transformString m t ]

                                    else
                                        []
                                )
                                [ ( m.hasScale, Scale )
                                , ( m.hasScaleX, ScaleX )
                                , ( m.hasScaleY, ScaleY )
                                , ( m.hasRotate, Rotate )
                                , ( m.hasMakeTransparent, MakeTransparent )
                                ]
                        )
                        [ -20, -30, -40, -50, -60, -70, -80 ]
        ]
        |> move (0,-40)


pullsText1 m =
    group [ copiable ("polygon [" ++ (String.join "," <| List.map ptCode (m.points ++ [ m.point10 ])) ++ "]")  ]


keypad location colour =
    group
        [ polygon [ ( 0, 0 ), ( 80, 0 ), ( 40, 10 ), ( 0, 0 ) ] |> filled colour |> addOutline (solid 1) colour |> notifyTap (MovePoint Up) |> notifyMouseDown (LongPress Up) |> notifyMouseUp (LongPress No)
        , polygon [ ( 0, 0 ), ( 0, -12 ), ( -10, -6 ), ( 0, 0 ) ] |> filled colour |> addOutline (solid 1) colour |> notifyTap (MovePoint Left) |> notifyMouseDown (LongPress Left) |> notifyMouseUp (LongPress No)
        , polygon [ ( 0, -12 ), ( 80, -12 ), ( 40, -22 ), ( 0, -12 ) ] |> filled colour |> addOutline (solid 1) colour |> notifyTap (MovePoint Down) |> notifyMouseDown (LongPress Down) |> notifyMouseUp (LongPress No)
        , polygon [ ( 80, -12 ), ( 80, 0 ), ( 90, -6 ) ] |> filled colour |> addOutline (solid 1) colour |> notifyTap (MovePoint Right) |> notifyMouseDown (LongPress Right) |> notifyMouseUp (LongPress No)
        ]
        |> move location



-- |> move (moveTrack m.hasTrack m)


moveTrack u m =
    if u then
        ( -500, 85 )

    else
        case m.currentPoint of
            0 ->
                ( -500, 161 )

            -- FIXME was -1, was that a bug?
            1 ->
                ( -235, 161 )

            2 ->
                ( -235, 141 )

            3 ->
                ( -235, 121 )

            4 ->
                ( -235, 101 )

            5 ->
                ( -235, 81 )

            6 ->
                ( -235, 61 )

            7 ->
                ( -235, 41 )

            8 ->
                ( -235, 21 )

            9 ->
                ( -235, 1 )

            _ ->
                ( -235, -20 * Basics.toFloat m.numPoints + 140 )


clickhere model =
    group
        [ triangle 5 |> filled red |> rotate (degrees 180) |> move ( -5, 0 )
        , rect 15 2 |> filled red
        , text "Click here!" |> size 10 |> filled black |> move ( 15, -2 )
        ]
        |> move ( 50, -20 )



-- messages generated by the framework (Tick) and by user interactions
-- note that we let elm figure out the type of the model by making it a type parameter, m


type Msg m
    = Tick Float GetKeyState
    | Draw Draw
    | LStyle
    | SetColour Colour
    | Toggle Transforms
    | TransM (m -> m)
    | Notif Notifications
    | MovePoint Direction
    | SetPoint
    | Clear
    | CheckPoint Int
    | AddPoint
    | DeletePoint
    | Buttondown ButtonDir
    | MouseUp
    | LongPress Direction



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


type Direction
    = Up
    | Down
    | Left
    | Right
    | No


button model =
    group
        [ "More" |> code
        , rect 28 15 |> filled grey |> makeTransparent 0 |> move ( 13, 4 ) |> notifyTap AddPoint
        , group
            [ "Less" |> code
            , rect 28 15 |> filled grey |> makeTransparent 0 |> move ( 13, 4 ) |> notifyTap DeletePoint
            ]
            |> move ( 0, -25 )
        ]
        |> move ( -130, 150 )



--   ,leftArrowKey (rgba 0 0 0 0.2) (rgba 117 184 135 0.2) (model.trackpadx * clamp 0 2 model.time + 78) (model.trackpady * clamp 0 2 model.time + -15)


vertices model =
    if model.hasPoints then
        group
            [ group <|
                List.map3
                    (\ss y n ->
                        filled red (circle 2)
                            |> move ss
                            |> makeTransparent
                                (if n == model.currentPoint then
                                    0

                                 else
                                    1
                                )
                     --   |> time1 model ss 210 10
                    )
                    (model.points ++ [ model.point10 ])
                    (List.map (\x -> -10 * Basics.toFloat x) (List.range 0 20))
                    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
            ]

    else
        rect 20 20 |> filled white |> makeTransparent 0


flash model =
    if model.currentPoint == 1 then
        group [ filled blue (circle 2) |> move model.point1 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, 156 ) ]

    else if model.currentPoint == 2 then
        group [ filled blue (circle 2) |> move model.point2 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, 136 ) ]

    else if model.currentPoint == 3 then
        group [ filled blue (circle 2) |> move model.point3 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, 116 ) ]

    else if model.currentPoint == 4 then
        group [ filled blue (circle 2) |> move model.point4 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, 96 ) ]

    else if model.currentPoint == 5 then
        group [ filled blue (circle 2) |> move model.point5 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, 76 ) ]

    else if model.currentPoint == 6 then
        group [ filled blue (circle 2) |> move model.point6 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, 56 ) ]

    else if model.currentPoint == 7 then
        group [ filled blue (circle 2) |> move model.point7 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, 36 ) ]

    else if model.currentPoint == 8 then
        group [ filled blue (circle 2) |> move model.point8 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, 16 ) ]

    else if model.currentPoint == 9 then
        group [ filled blue (circle 2) |> move model.point9 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, -4 ) ]

    else if model.currentPoint == 10 then
        group [ filled blue (circle 2) |> move model.point10 |> scale (abs (sin (model.time * 2) / 2 + 1.5)), rect 80 12 |> filled blue |> makeTransparent (abs (sin model.time) * 0.25) |> move ( -190, 164 ) |> move ( 0, -20 * Basics.toFloat model.numPoints - 30 ) ]

    else
        filled blue (circle 2) |> makeTransparent 0


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
                        |> size 9
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
        [ rect 130 90 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -40, 0 )
        , rect 75 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -40, 44 )
        , text "3. Pick a Colour!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -75, 41 )
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
                |> notifyMouseDown (Buttondown RedUp)
                |> notifyMouseUp (Buttondown None)
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
                |> notifyMouseDown (Buttondown RedDown)
                |> notifyMouseUp (Buttondown None)
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
                |> notifyMouseDown (Buttondown GreenUp)
                |> notifyMouseUp (Buttondown None)
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
                |> notifyMouseDown (Buttondown GreenDown)
                |> notifyMouseUp (Buttondown None)
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
                |> notifyMouseDown (Buttondown BlueUp)
                |> notifyMouseUp (Buttondown None)
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
                |> notifyMouseDown (Buttondown BlueDown)
                |> notifyMouseUp (Buttondown None)
            ]
            |> move ( 2, 22 )
        , group <|
            List.map2
                (\ss y ->
                    clrString model ss
                        |> text
                        |> fixedwidth
                        |> size 9
                        |> filled black
                        |> notifyTap (SetColour ss)
                        |> move ( -63, -2.5 )
                        |> time3 model ss 130 10
                        |> move ( -40, y )
                        |> move ( 0, 30 )
                )
                [ RGB
                ]
                (List.map (\x -> -10 * Basics.toFloat x) (List.range 0 40))
        ]


transforms model =
    group
        [ rect 140 70 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( 340, 30 )
        , rect 95 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( 340, 68 )
        , text "4. Apply Transforms!" |> serif |> italic |> size 10 |> filled titleColour |> move ( 300, 65 )
        , group <|
            List.map2
                (\ss y ->
                    transformString model ss
                        |> text
                        |> fixedwidth
                        |> size 10
                        |> filled black
                        |> notifyTap (Toggle ss)
                        |> move ( 307, 50 )
                        |> time4 model ss 140 10
                        |> move ( -35, y )
                )
                [ Scale, ScaleX, ScaleY, Rotate, MakeTransparent ]
                (List.map (\x -> -10 * Basics.toFloat x) (List.range 0 20))
        ]


tweaks =
    group
        [ rect 140 25 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -35, 1 )
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
                [ {- ( "clockwise", TransM (\m -> { m | angle = m.angle - 30 }) )
                     , ( "counter", TransM (\m -> { m | angle = m.angle + 30 }) )
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

                {- }
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


yourCode m =
    group
        [ rect 350 85 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( 80, -30 )
        , rect 80 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -55, 14 )
        , text "5. Your code!" |> serif |> italic |> size 10 |> filled titleColour |> move ( -90, 11 )
        , pullsText m
        , move ( -85, 0 ) <|
            group <|
                [ "  |> "
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
                                , ( m.hasScaleX, ScaleX )
                                , ( m.hasScaleY, ScaleY )
                                , ( m.hasRotate, Rotate )
                                , ( m.hasMakeTransparent, MakeTransparent )
                                ]
                        )
                        [ -20, -30, -40, -50, -60, -70, -80 ]
        ]


pullsText model =
    group
        [ code "-- Copy the code from Polygon Points " |> move ( -85, 0 )
        ]


polyCode m =
    group
        [ rect 160 215 |> filled (rgba 255 255 255 0.5) |> addOutline (solid 1) lightGrey |> move ( -19.5, -90 )
        , rect 80 12 |> filled white |> addOutline (solid 1) lightGrey |> move ( -40, 19 )
        , text "1. Polygon Points" |> serif |> italic |> size 10 |> filled titleColour |> move ( -75, 16 )
        , move ( -80, 0 ) <|
            group <|
                [ "polygon" |> code |> move ( -10, 0 )
                , "[" |> code |> move ( -2, -12 )
                , "(" |> code |> move ( 4, -12 )
                , String.fromFloat (Tuple.first m.point1) |> code |> move ( 10, -13 )
                , "," |> code |> move ( 40, -13 )
                , String.fromFloat (Tuple.second m.point1) |> code |> move ( 49, -13 )
                , ")" |> code |> move ( 78, -12 )
                , rect 80 10 |> filled black |> move ( 45, -10 ) |> makeTransparent 0 |> notifyTap (CheckPoint 1)

                {- , "  |> "
                   ++ stampString m m.draw
                   ++ (if m.draw == Outlined then
                           styleString m ++ " "
                       else
                           ""
                      )
                   ++ clrString m m.clr
                   |> code
                   |> move ( 0, -10 )
                -}
                ]
                    --, ((" [" ++ String.fromFloat m.point1) |> code |> move (-20,0) )
                    ++ List.map2 (\str y -> str |> move ( 0, y * 2 ) |> notifyTap (CheckPoint (round (y / -10))))
                        --List.concat <|
                        (List.map
                            (\( flag, t, w ) ->
                                if flag then
                                    if w then
                                        rect 0 0 |> filled white

                                    else
                                        group
                                            [ "," |> code |> move ( -2, -2 )
                                            , "(" |> code |> move ( 4, -2 )
                                            , String.fromFloat (Tuple.first t) |> code |> move ( 10, -3 )
                                            , "," |> code |> move ( 40, -3 )
                                            , String.fromFloat (Tuple.second t) |> code |> move ( 49, -3 )
                                            , ")" |> code |> move ( 78, -2 )
                                            , rect 80 10 |> filled black |> move ( 45, 0 ) |> makeTransparent 0

                                            -- ++ String.fromFloat t
                                            ]

                                else
                                    rect 0 0 |> filled white
                            )
                            [ --( m.hasPoint1, m.point1),
                              ( Maybe.withDefault False (get 1 (Array.fromList m.thePoints)), m.point2, False )
                            , ( Maybe.withDefault False (get 2 (Array.fromList m.thePoints)), m.point3, False )
                            , ( Maybe.withDefault False (get 3 (Array.fromList m.thePoints)), m.point4, False )
                            , ( Maybe.withDefault False (get 4 (Array.fromList m.thePoints)), m.point5, False )
                            , ( Maybe.withDefault False (get 5 (Array.fromList m.thePoints)), m.point6, False )
                            , ( Maybe.withDefault False (get 6 (Array.fromList m.thePoints)), m.point7, False )
                            , ( Maybe.withDefault False (get 7 (Array.fromList m.thePoints)), m.point8, False )
                            , ( Maybe.withDefault False (get 8 (Array.fromList m.thePoints)), m.point9, False )

                            --      , ( True, m.point10, True)
                            ]
                        )
                        [ -15, -25, -35, -45, -55, -65, -75, -85, -95, -105 ]
                    ++ [ group
                            [ "," |> code |> move ( -2, -2 )
                            , "(" |> code |> move ( 4, -2 )
                            , String.fromFloat (Tuple.first m.point10) |> code |> move ( 10, -3 )
                            , "," |> code |> move ( 40, -3 )
                            , String.fromFloat (Tuple.second m.point10) |> code |> move ( 49, -3 )
                            , ")" |> code |> move ( 78, -2 )
                            , "]" |> code |> move ( 84, -2 )
                            , rect 80 10 |> filled black |> move ( 45, 0 ) |> makeTransparent 0
                            ]
                            |> move ( 0, -20 * Basics.toFloat m.numPoints - 30 )
                            |> notifyTap (CheckPoint 10)
                       ]

        --|> move (0, -10* Basics.toFloat(m.numPoints) - 20)|> notifyTap (CheckPoint 10 )
        -- ++ String.fromFloat t
        -- ( "  ,"++String.fromFloat m.point10 ++ "]") |> code |> move (0, -10* Basics.toFloat(m.numPoints) - 20) |> notifyTap (CheckPoint 10 )]
        ]



-- check if the drawn text is the selected function, and if so group a beating rectangle behind it
-- stagger the heartbeats of selected elements to so that they indicate the order of selection
--


time1 model ss w h shape =
    if ss == model.shape then
        group [ rect w h |> filled (rgba 0 182 255 (0.6 + 0.4 * sin (5 * model.time))), shape ]

    else
        shape


time2 model ss w h shape =
    if ss == model.draw then
        group [ rect w h |> filled (rgba 0 182 255 (0.6 + 0.4 * sin (5 * model.time - 0.5))), shape ]

    else
        shape


time3 model ss w h shape =
    if ss == model.clr then
        group [ rect w h |> filled (rgba 0 182 255 (0.6 + 0.4 * sin (5 * model.time - 1))), shape ]

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


polygonString m shape =
    "polygon " ++ String.fromFloat m.points


directString m shape =
    case shape of
        Up ->
            "Up " ++ String.fromFloat m.width

        Down ->
            "Down " ++ String.fromFloat m.width

        Left ->
            "Left " ++ String.fromFloat m.width

        Right ->
            "right " ++ String.fromFloat m.width

        No ->
            "no"


stampString m stamp =
    case stamp of
        Filled ->
            "filled "

        Outlined ->
            "outlined "


tracker m =
    if m.hasPoints then
        filled red (triangle 5) |> rotate (degrees 30) |> move ( m.x, m.y )

    else
        rect 20 20 |> filled white |> makeTransparent 0


shapeFun m =
    case m.draw of
        Filled ->
            filled (colourFun m) (polygon (m.points ++ [ m.point10 ]))

        Outlined ->
            outlined (lineStyleFun m) (colourFun m) (polygon (m.points ++ [ m.point10 ]))
                |> (if m.hasMove then
                        move ( m.shapex, m.shapey )

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


polygonFun m =
    if m.hasPolygon then
        filled darkBlue (polygon (m.points ++ m.point10))

    else
        rect 20 20 |> filled white |> makeTransparent 0


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
    rgb 0 84 212


code str =
    str |> text |> fixedwidth |> size 13 |> filled black
