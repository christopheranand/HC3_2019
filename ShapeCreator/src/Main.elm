module Main exposing (main)

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

import ArcCreator
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import List
import PolygonCreator
import ShapeCreator
import SinCreator exposing (..)
import TextCreator exposing (..)
import TriCreator



main =
    gameApp Tick
        { model = init -- init is the value in the field model
        , title = "Shape Creator"
        , view = view
        , update = update
        }


type Pages
    = ShapeCreator
    | TriCreator
    | PolygonCreator
    | ArcCreator
    | SinCreator
    | TextCreator


init =
    { page = ShapeCreator
    , model1 = ShapeCreator.init
    , model2 = TriCreator.init
    , model3 = PolygonCreator.init
    , model4 = ArcCreator.init
    , model5 = SinCreator.init
    , model6 = TextCreator.init
    , oneSat = 1
    , twoSat = 0
    , threeSat = 0
    , fourSat = 0
    , fiveSat = 0
    , sixSat = 0
    , currentPage = 1
    }


oneColour model =
    hsl (degrees 30) model.oneSat 0.85


oneAccent model =
    hsl (degrees 22) model.oneSat 0.6


twoColour model =
    hsl (degrees 285) model.twoSat 0.85


twoAccent model =
    hsl (degrees 280) model.twoSat 0.6


threeColour model =
    hsl (degrees 250) model.threeSat 0.9


threeAccent model =
    hsl (degrees 245) model.threeSat 0.6


fourColour model =
    hsl (degrees 135) model.fourSat 0.9


fourAccent model =
    hsl (degrees 130) model.fourSat 0.6


fiveColour model =
    hsl (degrees 0) model.fiveSat 0.9


fiveAccent model =
    hsl (degrees 355) model.fiveSat 0.75


sixColour model =
    hsl (degrees 180) model.sixSat 0.85


sixAccent model =
    hsl (degrees 180) model.sixSat 0.5


type Msg m1 m2 m3 m4 m5 m6
    = Tick Float GetKeyState
    | Msg1 (ShapeCreator.Msg m1)
    | Msg2 (TriCreator.Msg m2)
    | Msg3 (PolygonCreator.Msg m3)
    | Msg4 (ArcCreator.Msg m4)
    | Msg5 (SinCreator.Msg m5)
    | Msg6 (TextCreator.Msg m6)
    | Goto1
    | Goto2
    | Goto3
    | Goto4
    | Goto5
    | Goto6
    | In1
    | In2
    | In3
    | In4
    | In5
    | In6
    | Out1
    | Out2
    | Out3
    | Out4
    | Out5
    | Out6
    | MoveInRect ( Float, Float )


view model =
    collage 512 380 <|
        (case model.page of
            ShapeCreator ->
                List.map (map Msg1) (ShapeCreator.view model.model1)

            TriCreator ->
                List.map (map Msg2) (TriCreator.view model.model2)

            PolygonCreator ->
                List.map (map Msg3) (PolygonCreator.view model.model3)

            ArcCreator ->
                List.map (map Msg4) (ArcCreator.view model.model4)

            SinCreator ->
                List.map (map Msg5) (SinCreator.view model.model5)

            TextCreator ->
                List.map (map Msg6) (TextCreator.view model.model6)
        )
            ++ [ rect 200 70 |> filled blank |> move ( 0, -190 ) |> notifyMouseMoveAt MoveInRect ]
            ++ [ group
                    [ circle 15
                        |> filled (oneColour model)
                        |> addOutline (solid 2)
                            (if model.page == ShapeCreator then
                                orange

                             else if model.oneSat == 0 then
                                blank

                             else
                                orange
                            )
                        |> makeTransparent 0.7
                        |> move ( -95, -190 )
                    , wedge 5 0.75 |> filled (oneAccent model) |> makeTransparent 0.7 |> move ( -95, -186 )
                    ]
                    |> notifyTap Goto1
                    |> notifyEnter In1
                    |> notifyLeave Out1
               , group
                    [ circle 15
                        |> filled (twoColour model)
                        |> addOutline (solid 2)
                            (if model.page == TriCreator then
                                purple

                             else if model.twoSat == 0 then
                                blank

                             else
                                purple
                            )
                        |> makeTransparent 0.7
                        |> move ( -55, -190 )
                    , rightTriangle 10 10 |> filled (twoAccent model) |> makeTransparent 0.6 |> move ( -58, -188 )
                    ]
                    |> notifyTap Goto2
                    |> notifyEnter In2
                    |> notifyLeave Out2
               , group
                    [ circle 15
                        |> filled (threeColour model)
                        |> addOutline (solid 2)
                            (if model.page == PolygonCreator then
                                darkBlue

                             else if model.threeSat == 0 then
                                blank

                             else
                                darkBlue
                            )
                        |> makeTransparent 0.7
                        |> move ( -15, -190 )
                    , polygon [ ( 0, 5 ), ( 7, 5 ), ( 8, 2 ), ( 5, 0 ), ( 7, -3 ), ( 2, -3 ) ] |> filled (threeAccent model) |> makeTransparent 0.6 |> move ( -17, -185 )
                    ]
                    |> notifyTap Goto3
                    |> notifyEnter In3
                    |> notifyLeave Out3
               , group
                    [ circle 15
                        |> filled (fourColour model)
                        |> addOutline (solid 2)
                            (if model.page == ArcCreator then
                                darkGreen

                             else if model.fourSat == 0 then
                                blank

                             else
                                darkGreen
                            )
                        |> makeTransparent 0.7
                        |> move ( 25, -190 )
                    , curve ( 0, 0 ) [ Pull ( 25, 15 ) ( 25, 0 ), Pull ( 25, -15 ) ( 0, 0 ), Pull ( -25, 15 ) ( -25, 0 ), Pull ( -25, -15 ) ( 0, 0 ) ]
                        |> outlined (solid 2) (fourAccent model)
                        |> scale 0.3
                        |> makeTransparent 0.5
                        |> move ( 25, -185 )
                    ]
                    |> notifyTap Goto4
                    |> notifyEnter In4
                    |> notifyLeave Out4
               , group
                    [ circle 15
                        |> filled (fiveColour model)
                        |> addOutline (solid 2)
                            (if model.page == SinCreator then
                                darkRed

                             else if model.fiveSat == 0 then
                                blank

                             else
                                darkRed
                            )
                        |> makeTransparent 0.7
                        |> move ( 65, -190 )
                    , curve ( 30, 0 ) [ Pull ( 14, 40 ) ( 0, 0 ), Pull ( -10, -30 ) ( -30, 0 ) ] |> outlined (solid 3) (fiveAccent model) |> scale 0.3 |> makeTransparent 0.5 |> move ( 65, -185 )
                    ]
                    |> notifyTap Goto5
                    |> notifyEnter In5
                    |> notifyLeave Out5
               , group
                    [ circle 15
                        |> filled (sixColour model)
                        |> addOutline (solid 2)
                            (if model.page == TextCreator then
                                rgb 0 170 130

                             else if model.sixSat == 0 then
                                blank

                             else
                                rgb 0 130 130
                            )
                        |> makeTransparent 0.7
                        |> move ( 105, -190 )
                    , text "Aa" |> filled (sixAccent model) |> makeTransparent 0.5 |> move ( 98, -187 )
                    ]
                    |> notifyTap Goto6
                    |> notifyEnter In6
                    |> notifyLeave Out6
               ]


distTo pointA pointB =
    sqrt ((Tuple.first pointB - Tuple.first pointA) ^ 2 + (Tuple.second pointB - Tuple.second pointA) ^ 2)


update msg model =
    case msg of
        In1 ->
            { model | oneSat = 1 }

        In2 ->
            { model | twoSat = 1 }

        In3 ->
            { model | threeSat = 1 }

        In4 ->
            { model | fourSat = 1 }

        In5 ->
            { model | fiveSat = 1 }

        In6 ->
            { model | sixSat = 1 }

        Out1 ->
            { model
                | oneSat =
                    case model.page of
                        ShapeCreator ->
                            model.oneSat

                        _ ->
                            0
            }

        Out2 ->
            { model
                | twoSat =
                    case model.page of
                        TriCreator ->
                            model.twoSat

                        _ ->
                            0
            }

        Out3 ->
            { model
                | threeSat =
                    case model.page of
                        PolygonCreator ->
                            model.threeSat

                        _ ->
                            0
            }

        Out4 ->
            { model
                | fourSat =
                    case model.page of
                        ArcCreator ->
                            model.fourSat

                        _ ->
                            0
            }

        Out5 ->
            { model
                | fiveSat =
                    case model.page of
                        SinCreator ->
                            model.fiveSat

                        _ ->
                            0
            }

        Out6 ->
            { model
                | sixSat =
                    case model.page of
                        TextCreator ->
                            model.sixSat

                        _ ->
                            0
            }

        _ ->
            case model.page of
                ShapeCreator ->
                    case msg of
                        Tick f g ->
                            { model | model1 = ShapeCreator.update (ShapeCreator.Tick f g) model.model1 }

                        Msg1 m1 ->
                            { model | model1 = ShapeCreator.update m1 model.model1 }

                        Msg2 _ ->
                            model

                        Msg3 _ ->
                            model

                        Msg4 _ ->
                            model

                        Msg5 _ ->
                            model

                        Msg6 _ ->
                            model

                        Goto1 ->
                            { model
                                | page = ShapeCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto2 ->
                            { model
                                | page = TriCreator
                                , oneSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto3 ->
                            { model
                                | page = PolygonCreator
                                , twoSat = 0
                                , oneSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto4 ->
                            { model
                                | page = ArcCreator
                                , twoSat = 0
                                , threeSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto5 ->
                            { model
                                | page = SinCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , sixSat = 0
                            }

                        Goto6 ->
                            { model
                                | page = TextCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                            }

                        _ ->
                            model

                TriCreator ->
                    case msg of
                        Tick f g ->
                            { model | model2 = TriCreator.update (TriCreator.Tick f g) model.model2 }

                        Msg1 _ ->
                            model

                        Msg2 m2 ->
                            { model | model2 = TriCreator.update m2 model.model2 }

                        Msg3 _ ->
                            model

                        Msg4 _ ->
                            model

                        Msg5 _ ->
                            model

                        Msg6 _ ->
                            model

                        Goto1 ->
                            { model
                                | page = ShapeCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto2 ->
                            { model
                                | page = TriCreator
                                , oneSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto3 ->
                            { model
                                | page = PolygonCreator
                                , twoSat = 0
                                , oneSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto4 ->
                            { model
                                | page = ArcCreator
                                , twoSat = 0
                                , threeSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto5 ->
                            { model
                                | page = SinCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , sixSat = 0
                            }

                        Goto6 ->
                            { model
                                | page = TextCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                            }

                        _ ->
                            model

                PolygonCreator ->
                    case msg of
                        Tick f g ->
                            { model | model3 = PolygonCreator.update (PolygonCreator.Tick f g) model.model3 }

                        Msg1 _ ->
                            model

                        Msg2 _ ->
                            model

                        Msg3 m3 ->
                            { model | model3 = PolygonCreator.update m3 model.model3 }

                        Msg4 _ ->
                            model

                        Msg5 _ ->
                            model

                        Msg6 _ ->
                            model

                        Goto1 ->
                            { model
                                | page = ShapeCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto2 ->
                            { model
                                | page = TriCreator
                                , oneSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto3 ->
                            { model
                                | page = PolygonCreator
                                , twoSat = 0
                                , oneSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto4 ->
                            { model
                                | page = ArcCreator
                                , twoSat = 0
                                , threeSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto5 ->
                            { model
                                | page = SinCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , sixSat = 0
                            }

                        Goto6 ->
                            { model
                                | page = TextCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        _ ->
                            model

                ArcCreator ->
                    case msg of
                        Tick f g ->
                            { model | model4 = ArcCreator.update (ArcCreator.Tick f g) model.model4 }

                        Msg1 _ ->
                            model

                        Msg2 _ ->
                            model

                        Msg3 _ ->
                            model

                        Msg4 m4 ->
                            { model | model4 = ArcCreator.update m4 model.model4 }

                        Msg5 _ ->
                            model

                        Msg6 _ ->
                            model

                        Goto1 ->
                            { model
                                | page = ShapeCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto2 ->
                            { model
                                | page = TriCreator
                                , oneSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto3 ->
                            { model
                                | page = PolygonCreator
                                , twoSat = 0
                                , oneSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto4 ->
                            { model
                                | page = ArcCreator
                                , twoSat = 0
                                , threeSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto5 ->
                            { model
                                | page = SinCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , sixSat = 0
                            }

                        Goto6 ->
                            { model
                                | page = TextCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                            }

                        _ ->
                            model

                SinCreator ->
                    case msg of
                        Tick f g ->
                            { model | model5 = SinCreator.update (SinCreator.Tick f g) model.model5 }

                        Msg1 _ ->
                            model

                        Msg2 _ ->
                            model

                        Msg3 _ ->
                            model

                        Msg4 _ ->
                            model

                        Msg5 m5 ->
                            { model | model5 = SinCreator.update m5 model.model5 }

                        Msg6 _ ->
                            model

                        Goto1 ->
                            { model
                                | page = ShapeCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto2 ->
                            { model
                                | page = TriCreator
                                , oneSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto3 ->
                            { model
                                | page = PolygonCreator
                                , twoSat = 0
                                , oneSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto4 ->
                            { model
                                | page = ArcCreator
                                , twoSat = 0
                                , threeSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto5 ->
                            { model
                                | page = SinCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , sixSat = 0
                            }

                        Goto6 ->
                            { model
                                | page = TextCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                            }

                        _ ->
                            model

                TextCreator ->
                    case msg of
                        Tick f g ->
                            { model | model6 = TextCreator.update (TextCreator.Tick f g) model.model6 }

                        Msg1 _ ->
                            model

                        Msg2 _ ->
                            model

                        Msg3 _ ->
                            model

                        Msg4 _ ->
                            model

                        Msg5 _ ->
                            model

                        Msg6 m6 ->
                            { model | model6 = TextCreator.update m6 model.model6 }

                        Goto1 ->
                            { model
                                | page = ShapeCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto2 ->
                            { model
                                | page = TriCreator
                                , oneSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto3 ->
                            { model
                                | page = PolygonCreator
                                , twoSat = 0
                                , oneSat = 0
                                , fourSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto4 ->
                            { model
                                | page = ArcCreator
                                , twoSat = 0
                                , threeSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                                , sixSat = 0
                            }

                        Goto5 ->
                            { model
                                | page = SinCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , sixSat = 0
                            }

                        Goto6 ->
                            { model
                                | page = TextCreator
                                , twoSat = 0
                                , threeSat = 0
                                , fourSat = 0
                                , oneSat = 0
                                , fiveSat = 0
                            }

                        _ ->
                            model
