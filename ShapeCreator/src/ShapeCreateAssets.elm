module ShapeCreateAssets exposing
    ( Brightest(..)
    , accel
    , angleBound
    , arrow
    , copiable
    , getBrightest
    , ptCode
    , pullCode
    )

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
import List
import String exposing (..)


{-| this function is used for long tap, to accellerate the speed
-}
accel x =
    Basics.toFloat (round (clamp 0 12 (x ^ 2) / 4))


angleBound angle =
    if degrees angle < (2 * pi) && degrees angle >= 0 then
        angle |> round

    else if degrees angle < 0 then
        360 - ((-1 * round angle) |> modBy 360)

    else
        round angle |> modBy 360


{-| this function is used for converting angles to fit between 0 and 360
-}



-- it is to be used on the number before it is turned into radians,
--i.e. (degrees (angleBound num))


arrow start end colour thickness =
    let
        length =
            sqrt (((Tuple.first end - Tuple.first start) ^ 2) + ((Tuple.second end - Tuple.second start) ^ 2))

        -- root ((x1-x0)^2 + (y1-y0)^2)
        angle =
            case (Tuple.first end - Tuple.first start) == 0 of
                True ->
                    case Tuple.second end > 0 of
                        True ->
                            degrees 90

                        False ->
                            degrees 270

                False ->
                    atan2 (Tuple.second end - Tuple.second start) (Tuple.first end - Tuple.first start)
    in
    group
        [ line start end |> outlined (solid thickness) colour
        , triangle (thickness * 2) |> filled colour |> move end |> rotate angle
        ]


type Brightest
    = BrRed
    | BrBlue
    | BrGreen
    | RedAndBlue
    | RedAndGreen
    | BlueAndGreen
    | All


copiable str =
    str |> text |> selectable |> fixedwidth |> size 10 |> filled black


getBrightest r g b =
    if r == g && g == b then
        All

    else if r > b then
        if r > g then
            BrRed

        else if r == g then
            RedAndGreen

        else
            BrGreen

    else if r == b then
        if r > g then
            RedAndBlue

        else
            BrGreen

    else
    -- r < b
    if
        b > g
    then
        BrBlue

    else if b == g then
        BlueAndGreen

    else
        BrGreen


sinus x =
    sin x + sin (3 * x) + 1.5



-- Correctly formats the code that is going to be copiable by putting it into brackets


ptCode ( x, y ) =
    "(" ++ String.fromFloat x ++ "," ++ String.fromFloat y ++ ")"



-- Formats each pair of points for the pull code


pullCode ( pxy, xy ) =
    "Pull " ++ ptCode pxy ++ " " ++ ptCode xy
