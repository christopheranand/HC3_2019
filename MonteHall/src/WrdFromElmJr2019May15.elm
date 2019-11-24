module WrdFromElmJr2019May15 exposing(words)
import GraphicSVG exposing(..)
words = [
      let
        myWord = "grandfather"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled lightGreen
            , rect 45.1 50.0
               |> filled darkRed
               |> move (0.0, (-50.0))
            , circle 40.0
               |> filled lightBrown
            , circle 7.0
               |> filled white
               |> move ((-20.0), 6.0)
            , circle 7.0
               |> filled white
               |> move (20.0, 6.0)
            , circle 5.0
               |> filled blue
               |> move ((-20.0), 6.0)
            , circle 5.0
               |> filled blue
               |> move (20.0, 6.0)
            , oval 13.0 18.0
               |> filled brown
               |> move (0.0, (-5.0))
            , wedge 20.0 0.5
               |> filled lightRed
               |> move (15.0, 5.0)
               |> rotate 300.0
            , square 5.0
               |> filled lightGrey
               |> move (0.0, (-18.0))
            , square 5.0
               |> filled lightGrey
               |> move (2.0, (-18.0))
            , wedge 20.0 0.5
               |> filled lightCharcoal
               |> move (36.0, (-2.0))
               |> rotate 90.0
            , wedge 20.0 0.5
               |> filled lightCharcoal
               |> move (35.0, 2.0)
               |> rotate 45.0
            , circle 15.0
               |> filled lightCharcoal
               |> move (0.0, 40.0)
            , oval 7.0 20.0
               |> filled lightCharcoal
               |> move ((-30.0), 12.0)
               |> rotate 100.0
            , rect 12.0 39.0
               |> filled darkRed
               |> move ((-27.0), (-53.0))
            , group
               [ group
                  [ rect 12.0 49.0
                     |> filled darkRed
                     |> move ( 0 , ((sin model.time) * 5.0))
                  ]
                  |> move (50.0, 8.0)
                  |> rotate 87.0
               ]
            ]

          |> scale 0.85 ]


    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let

        myWord = "dog"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled ( rgb 255.0 215.0 0.0)
            , circle 15.0
               |> filled darkBrown
               |> move (45.0,  0 )
            , circle 5.0
               |> filled black
               |> move (49.0,  0 )
            , circle 5.0
               |> filled black
               |> move (38.0,  0 )
            , oval 50.0 20.0
               |> filled darkBrown
               |> move (10.0, (-7.0))
            , oval 10.0 30.0
               |> filled darkBrown
               |> move ((-5.0), (-15.0))
            , oval 10.0 30.0
               |> filled darkBrown
               |> move (25.0, (-15.0))
            , wedge 10.0 15.0
               |> filled darkBrown
               |> move ((-20.0),  0 )
            , ngon 3 5.0
               |> filled lightCharcoal
               |> move (30.0, 5.0)
               |> rotate 0.0
            , ngon 3 5.0
               |> filled lightCharcoal
               |> move (60.0, 5.0)
            ]

          --|> scale 0.85
          |> move (-17,0)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "eating"
        myCode = 549

        myShapes model = [ group

            [ circle 30.0
               |> filled lightBrown
            , circle 5.0
               |> filled white
               |> move ((-15.0), 0.0)
            , circle 5.0
               |> filled white
               |> move (15.0, 0.0)
            , circle 3.0
               |> filled darkBlue
               |> move ((-15.0), 0.0)
            , circle 3.0
               |> filled darkBlue
               |> move (15.0, 0.0)
            , circle 2.0
               |> filled black
               |> move ((-15.0), 0.0)
            , circle 2.0
               |> filled black
               |> move (15.0, 0.0)
            , rect 30.0 10.0
               |> filled black
               |> move (0.0, (-15.0))
            , rect 20.0 50.0
               |> filled darkRed
               |> move (0.0, (-39.0))
            , rect 5.0 50.0
               |> filled lightRed
               |> move ((-5.0), (-40.0))
            , rect 5.0 50.0
               |> filled lightRed
               |> move (5.0, (-40.0))
            , rect 30.0 5.0
               |> filled white
               |> move (0.0, (-12.0))
            , rect 5.0 2.0
               |> filled white
               |> move ((-12.0), (-20.0))
            , rect 5.0 2.0
               |> filled white
               |> move (12.0, (-20.0))
            , rect 21.0 40.0
               |> filled black
               |> move ((-20.0), (-50.0))
            , rect 21.0 40.0
               |> filled black
               |> move (20.0, (-50.0))
            , rect 20.0 10.0
               |> filled darkBlue
               |> move (20.0, (-50.0))
            , circle 10.0
               |> filled darkBlue
               |> move (11.0, (-50.0))
            , rect 20.0 10.0
               |> filled darkBlue
               |> move ((-20.0), (-50.0))
            , circle 10.0
               |> filled darkBlue
               |> move ((-11.0), (-50.0))
            , rect 60.0 18.0
               |> filled black
               |> move (0.0, 21.0)
            , square 30.0
               |> filled  black
               |> move (0.0, 40.0)
            , rect 70.0 150.0
               |> outlined  (solid 1)   black
               |> move ((-70.0),  0 )
            , rect 20.0 5.0
               |> filled  black
               |> move ((-80.0), 0.0)
            , rect 75.0 2.0
               |> filled  black
               |> move (67.0,  0 )
            , rect 77.0 2.0
               |> filled  black
               |> move (67.0, 10.0)
            , rect 7.0 2.0
               |> filled  black
               |> move ((-32.0), 10.0)
            , rect 5.1 2.0
               |> filled  black
               |> move ((-33.0),  0 )
            , rect 1.0 10.0
               |> filled  black
               |> move (50.0, 5.0)
            , rect 1.0 10.0
               |> filled  black
               |> move (95.0, 5.0)
            , rect 10.0 20.0
               |> filled darkCharcoal
               |> move (75.0, 20.0)
            , circle 5.0
               |> filled charcoal
               |> move (75.0, 25.0)
            , circle 1.0
               |> filled  black
               |> move (77.0, 27.0)
            , circle 1.0
               |> filled  black
               |> move (73.0, 27.0)
            , circle 1.0
               |> filled  black
               |> move (77.0, 23.0)
            , circle 1.0
               |> filled  black
               |> move (73.0, 23.0)
            , circle 1.0
               |> filled  black
               |> move (75.0, 25.0)
            , circle 20.0
               |> filled lightCharcoal
               |> move (50.0, 50.0)
            , circle 10.0
               |> filled lightBlue
               |> move (50.0, 50.0)
            , rect 40.0 80.0
               |> outlined  (solid 1)   black
               |> move (70.0, (-50.0))
            , rect 20.0 5.0
               |> filled  black
               |> move (65.0, (-40.0))
            , circle 3.5
               |> filled white
               |> move (45.0, 50.0)
            , circle 3.5
               |> filled white
               |> move (50.0, 52.0)
            , circle 3.5
               |> filled white
               |> move (55.0, 50.0)
            , rect 30.0 0.0
               |> filled  black
            ]
          |> scale 0.5
          --|> move (-17,0)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "woman"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled grey
            , rect 200.0 50.0
               |> filled darkGreen
               |> move (0.0, (-75.0))
            , circle 15.0
               |> filled lightBrown
               |> move (0.0, 30.0)
            , oval 25.0 50.0
               |> filled darkBlue
               |> move (0.0, (-10.0))
            , wedge 15.0 0.5
               |> filled black
               |> move (30.0, 1.5)
               |> rotate 45.5
            , circle 10.0
               |> filled lightBrown
               |> move (0.0, 30.0)
            , roundedRect 5.0 25.0 25.0
               |> filled lightBrown
               |> move ((-10.0), (-8.0))
               |> rotate 75.0
            , roundedRect 5.0 30.0 30.0
               |> filled lightBrown
               |> move (10.0, (-10.0))
               |> rotate (-75.0)
            , circle 2.0
               |> filled darkGreen
               |> move ((-5.0), 30.0)
            , circle 2.0
               |> filled darkGreen
               |> move (5.0, 30.0)
            , curve ((-5.0),23.0) [Pull (0.0,15.0) (5.0,23.0)
                                 ]
               |> filled darkRed
            , roundedRect 5.0 25.0 25.0
               |> filled lightBrown
               |> move ((-5.0), (-40.0))
            , roundedRect 5.0 25.0 25.0
               |> filled lightBrown
               |> move (5.0, (-40.0))
            , roundedRect 5.0 15.0 15.0
               |> filled lightBrown
               |> move ((-19.0), (-6.0))
               |> rotate 0.2
            ]
          |> scale 0.5
          --|> move (-17,0)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "sunset"
        myCode = 549

        myShapes model = [ group

            [ circle 192.0
               |> filled orange
            , circle 20.0
               |> filled yellow
               |> move (0.0, 20.0)
            , rect 300000.0 60.0
               |> filled blue
               |> move (0.0, (-50.0))
            , rect 30000000.0 10.0
               |> filled lightYellow
               |> move (0.0, (-60.0))
            , rect 2.0 50.0
               |> filled black
               |> rotate (degrees 340.0)
               |> move (50.0, (-39.0))
            ]
          |> scale 0.5
          |> move (0,-10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "houses"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled lightBlue
            , circle 20.0
               |> filled charcoal
               |> move (80.0, (-35.0))
               |> scale (abs (sin model.time))
            , rect 6666666.0 30.0
               |> filled darkGreen
               |> move ((-50.0), (-50.0))
            , square 20.0
               |> filled blue
               |> move (0.0, (-30.0))
            , square 20.0
               |> filled red
               |> move ((-20.0), (-30.0))
            , square 20.0
               |> filled lightCharcoal
               |> move (20.0, (-30.0))
            , ngon 3 13.0
               |> filled lightCharcoal
               |> move ((-20.0), (-20.0))
               |> rotate (degrees 90.0)
            , ngon 3 13.0
               |> filled blue
               |> move ((-20.0), (-20.0))
               |> move ((-1.0), 20.0)
               |> rotate (degrees 90.0)
            , ngon 3 13.0
               |> filled red
               |> rotate (degrees 90.0)
               |> move ((-20.0), (-15.0))
            ]


          |> scale 0.8
          |> move (0,-10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "eating"
        myCode = 549

        myShapes model = [ group

            [ square 70.0
              |> filled lightYellow
              |> move (0.0, 25.0)
            , circle 9.0
              |> filled white
              |> move (20.0, 30.0)
            , circle 9.0
              |> filled white
              |> move ((-20.0), 30.0)
            , circle 6.0
              |> filled blue
              |> move (20.0, 30.0)
            , circle 6.0
              |> filled blue
              |> move ((-20.0), 30.0)
            , circle 4.0
              |> filled  black
              |> move (20.0, 30.0)
            , circle 4.0
              |> filled  black
              |> move ((-20.0), 30.0)
            , wedge 14.0 0.5
              |> filled  black
              |> move ((-10.0), 0.0)
              |> rotate (degrees 270.0)
            , rect 4.0 6.0
              |> filled white
              |> move (4.0, 7.0)
            , rect 4.0 6.0
              |> filled white
              |> move ((-4.0), 7.0)
            , rect 70.0 12.0
              |> filled lightGrey
              |> move (0.0, (-14.0))
            , rect 70.0 14.0
              |> filled darkBrown
              |> move (0.0, (-27.0))
            , rect 18.0 4.0
              |> filled lightYellow
              |> move (43.0, 13.0)
              |> rotate (degrees 270.0)
            , rect 18.0 4.0
              |> filled lightYellow
              |> move (43.0, (-13.0))
              |> rotate (degrees 270.0)
            , rect 29.0 5.0
              |> filled lightYellow
              |> move (47.0, 10.0)
            , rect 29.0 5.0
              |> filled lightYellow
              |> move ((-47.0), 10.0)
            , rect 6.0 5.0
              |> filled darkGrey
              |> move (37.0, 10.0)
            , rect 6.0 5.0
              |> filled darkGrey
              |> move ((-37.0), 10.0)
            , circle 3.0
              |> filled lightYellow
              |> move (64.0, 10.0)
            , circle 19.0
              |> filled hotPink
              |> move (67.0, 9.0)
              |> scale (abs (sin model.time))
            , rect 4.0 10.0
              |> filled darkBrown
              |> move (67.0, 29.0)
              |> scale (abs (sin model.time))
            ]


          |> scale 0.8
          |> move (0,-10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "beach"
        myCode = 549

        myShapes model = [ group

            [ square 0.0
               |> filled yellow
            , rect 200.0 78.0
               |> filled lightBrown
               |> move (0.0, (-40.0))
            , rect 200.0 78.0
               |> filled lightBlue
               |> move ((-1.0), 25.0)
            , wedge 28.0 0.5
               |> filled hotPink
               |> move ((-27.0), 40.0)
               |> rotate (degrees 100.0)
            , rect 3.0 45.0
               |> filled hotPink
               |> move ((-40.0), (-45.0))
               |> rotate (degrees 8.0)
            , rect 24.0 5.0
               |> filled purple
               |> move (10.0, (-33.0))
            , rect 24.0 5.0
               |> filled lightGreen
               |> move (10.0, (-38.0))
            , rect 24.0 5.0
               |> filled blue
               |> move (10.0, (-43.0))
            , rect 24.0 5.0
               |> filled purple
               |> move (10.0, (-48.0))
            , rect 24.0 5.0
               |> filled lightGreen
               |> move (10.0, (-53.0))
            , rect 24.0 5.0
               |> filled blue
               |> move (10.0, (-58.0))
            , oval 24.0 58.0
               |> filled darkOrange
               |> rotate (degrees 10.0)
               |> move (47.0, (-10.0))
            ]


          |> scale 0.8
          --|> move (0,-10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "bow"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled blue
            , circle 50.0
               |> filled black
            , circle 30.0
               |> filled black
               |> move ((-40.0), 40.0)
            , circle 30.0
               |> filled black
               |> move (30.0, 40.0)
            , circle 11.0
               |> filled red
               |> move ((-5.0), 40.0)
            , wedge 20.0 0.25
               |> filled red
               |> move (0.0, 39.0)
            , group
               [ wedge 20.0 0.25
                  |> filled red
                  |> rotate (degrees 180.0)
                  |> move ((-10.0), 39.0)
               ]
            ]


          |> scale 0.75
          |> move (0,-10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "wave"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled lightBlue
            , circle 40.0
               |> filled darkGrey
               |> move ((-10.0), (-15.0))
            , circle 20.0
               |> filled darkGrey
               |> move (15.0, 20.0)
            , circle 20.0
               |> filled darkGrey
               |> move ((-29.0), 15.0)
            , circle 5.0
               |> filled lightBlue
               |> move (4.0, (-5.0))
            , circle 5.0
               |> filled lightBlue
               |> move ((-20.0), (-5.0))
            , circle 5.0
               |> filled black
               |> move ((-7.0), (-20.0))
            , wedge 19.0 0.5
               |> filled black
               |> rotate 29.9
               |> move ((-7.0), (-29.0))
            , rect 20.0 30.0
               |> filled darkGrey
               |> move ((-7.0), (-65.0))
            , circle 13.0
               |> filled  black
               |> move ((-30.0), 17.0)
            , circle 13.0
               |> filled  black
               |> move (15.0, 20.0)

            , group [circle 15.0
               |> filled darkGrey
               |> rotate 0.5
               |> move (34.0, (-45.0))

            , group [rect 20.0 30.0
               |> filled darkGrey
               |> move (34.0, (-65.0))

            , circle 10.0
               |> filled  black
               |> move (35.0, (-45.0))
            , circle 5.0
               |> filled pink
               |> move (25.0, (-30.0))
            , circle 5.0
               |> filled pink
               |> move (40.0, (-30.0))
               ] ]
               |> move (-45,60)
               |> rotate (-0.1 + 0.25*sin (2*model.time))
               |> move (45,-60)

            ]


          |> scale 0.85
          --|> move (0,-10)
          ]    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "clown"
        myCode = 549

        myShapes model = [ group

            [ wedge 43.0 3.0
               |> filled white
            , rect 266.0 588.0
               |> filled white
            , circle 60.0
               |> filled red
            , group
               [ circle 7.0
                  |> filled black
                  |> move ((-32.0), 20.0)
               , circle 7.0
                  |> filled black
                  |> move (32.0, 20.0)
               , circle 4.0
                  |> filled white
                  |> move ((-32.0), 20.0)
               , circle 4.0
                  |> filled white
                  |> move (32.0, 20.0)
               , wedge 20.0 30.0
                  |> filled green
                  |> move (40.0, 60.0)
               , circle 20.0
                  |> filled blue
                  |> move (20.0, 60.0)
               , circle 20.0
                  |> filled orange
                  |> move ((-20.0), 60.0)
               , circle 20.0
                  |> filled yellow
                  |> move ((-50.0), 49.0)
               , wedge 13.0 10.0
                  |> filled green
               , circle 20.0
                  |> filled hotPink
                  |> move (60.0, 50.0)
               , wedge 20.0 0.5
                  |> filled white
                  |> rotate model.time
                  |> move (0.12, (-40.0))
               , circle 20.0
                  |> filled darkPurple
                  |> move ((-60.0), 30.0)
               , circle 20.0
                  |> filled darkBlue
                  |> move (70.0, 20.0)
               ]
            ]


          |> scale 0.70
          |> move (0,-5)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "pencil"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled lightPurple
            , rect 10.0 60.0
               |> filled blue
               |> move ((-9.0), (-10.0))
            , ngon 3 6.0
               |> filled darkBrown
               |> move (42.0, (-11.0))
               |> rotate 29.9
            , ngon 3 3.0
               |> filled darkCharcoal
               |> move (44.5, (-11.0))
               |> rotate 29.9
            , rect 10.0 6.0
               |> filled lightCharcoal
               |> move ((-9.0), 15.0)
            , rect 10.0 5.0
               |> filled pink
               |> move ((-9.0), 18.0)
            ]

          --|> scale 1
          --|> move (0,-5)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "ball"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled white
            , circle 20.0
               |> filled hotPink
               |> move (0.0, ((sin model.time) * 45.0))
            , circle 10.0
               |> filled yellow
               |> move (0.0, ((sin model.time) * 47.0))
            ]

          --|> scale 1
          --|> move (0,-5)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "boat"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled lightBlue
            , wedge 30.0 0.5
               |> filled darkBrown
               |> move (( 0  * 4.0), (-5.0))
               |> rotate 300.0
            , square 300.0
               |> filled darkBlue
               |> move (0.0, (((sin model.time) * 3.0) - 170.0))
            , roundedRect 8.0 40.0 1.0
               |> filled darkBrown
               |> move ((-15.0), 10.0)
            , ngon 3 10.0
               |> filled lightYellow
               |> move ((-6.0), 20.0)
            ]

          --|> scale 1
          --|> move (0,-5)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "dress"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled white
            , ngon 3 45.0
               |> filled lightBlue
               |> move ((-25.0), 0.0)
               |> rotate (degrees 90.0)
            , rect 14.0 19.0
               |> filled lightBlue
               |> move ((-0.0), 14.0)
               |> rotate (degrees 0.0)
            , rect 14.0 2.0
               |> filled darkCharcoal
               |> move (0.0, 9.0)
            , oval 9.0 6.0
               |> filled lightBlue
               |> move ((-2.5), 24.0)
            , oval 9.0 6.0
               |> filled lightBlue
               |> move (2.5, 24.0)
            , rect 2.0 25.0
               |> filled lightBlue
               |> move (6.0, 23.0)
            , rect 2.0 25.0
               |> filled lightBlue
               |> move ((-6.0), 23.0)
            ]

          --|> scale 1
          --|> move (0,-5)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "koala"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
              |> filled black
            , circle 60.0
              |> filled charcoal
              |> move ( 0 , (-7.0))
            , circle 25.0
              |> filled charcoal
              |> move (50.0, 50.0)
            , circle 25.0
              |> filled charcoal
              |> move ((-50.0), 50.0)
            , circle 10.0
              |> filled lightCharcoal
              |> move ((-50.0), 50.0)
            , circle 10.0
              |> filled lightCharcoal
              |> move (50.0, 50.0)
            , circle 10.0
              |> filled darkGrey
              |> move (29.0, 15.0)
            , circle 10.0
              |> filled darkGrey
              |> move ((-29.0), 15.0)
            , circle 10.0
              |> filled  black
            , text "This is koko"
              |> italic
              |> filled pink
              |> rotate (degrees 270.0)
              |> move ( 0 , (-9.05))
            , circle 5.0
              |> filled black
              |> move (29.0, 15.0)
            , circle 5.0
              |> filled black
              |> move ((-29.0), 15.0)
            , wedge 18.0 0.25
              |> filled charcoal
              |> rotate (degrees 90.0)
              |> move (27.0, 29.0)
            ]
          |> scale 0.5
          --|> move (0,-5)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "snail"
        myCode = 549

        myShapes model = [ group

            [ oval 60.0 20.0
               |> filled darkBrown
               |> move (((sin model.time) * 60.0),  0 )
            , circle 30.0
               |> filled lightBrown
               |> move (((-12.0)  + ((sin model.time) * 60.0)), 25.0)
            , oval 7.0 10.0
               |> filled lightBrown
               |> move ((21.0 + ((sin model.time) * 60.0)), 12.0)
            , circle 4.0
               |> filled  black
               |> move ((20.0  + ((sin model.time) * 60.0)), 0.0)
            ]


          |> scale 0.75
          |> move (0,-35)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "bear"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled white
            , circle 30.0
               |> filled darkBrown
               |> move (0.0, (-10.0))
            , oval 30.0 45.0
               |> filled grey
               |> move (0.0, (-11.0))
            , circle 19.0
               |> filled darkBrown
               |> move (0.0, 30.0)
            , circle 3.0
               |> filled white
               |> move ((-10.0), 35.0)
            , circle 1.0
               |> filled blue
               |> move ((-10.0), 35.0)
            , circle 3.0
               |> filled white
               |> move (10.0, 35.0)
            , circle 1.0
               |> filled blue
               |> move (10.0, 35.0)
               |> rotate 0.0
            , curve ((-1.0),(-1.0)) [Pull (2.0,(-5.0)) (5.0,0.0)
                                   ]
               |> outlined  (solid 1)  black
               |> move ((-2.0), 27.0)
            , rect 1.0 3.0
               |> filled black
               |> move (0.5, 26.0)
            , circle 9.0
               |> filled darkBrown
               |> move ((-15.0), 50.0)
            , circle 9.0
               |> filled darkBrown
               |> move (15.0, 50.0)
            , circle 5.0
               |> filled grey
               |> move ((-12.0), 50.0)
            , circle 5.0
               |> filled lightGrey
               |> move (12.0, 50.0)
            ]
          |> move (0,-10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "butterfly"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled lightBlue
            , rect 50.0 10.0
               |> filled black
               |> rotate 98.9
               |> move ((-10.0), (-10.0))
            , circle 7.0
               |> filled black
               |> move ((-8.0), 20.0)
            , oval 30.0 35.0
               |> filled darkOrange
               |> move (8.0, 0.0)
            , oval 30.0 35.0
               |> filled darkOrange
               |> move (8.0, (-24.0))
            , oval 20.0 20.0
               |> filled orange
               |> move (8.0,  0 )
            , oval 20.0 20.0
               |> filled orange
               |> move (9.0, (-25.0))
            , oval 30.0 35.0
               |> filled darkOrange
               |> move ((-25.0),  0 )
            , oval 20.0 20.0
               |> filled orange
               |> move ((-25.0),  0 )
            , oval 30.0 35.0
               |> filled darkOrange
               |> move ((-28.0), (-25.0))
            , square 7.0
               |> filled darkOrange
               |> move ((-2.0), (-12.0))
            , oval 20.0 20.0
               |> filled orange
               |> move ((-28.0), (-25.0))
            , oval 20.0 20.0
               |> filled orange
               |> move ((-25.0), 0.0)
            , rect 2.0 20.0
               |> filled  black
               |> move ((-10.0), 25.0)
            , rect 2.0 20.0
               |> filled  black
               |> move ((-5.0), 25.0)
            , square 5.0
               |> filled darkOrange
               |> move ((-17.0), (-15.0))
            ]

          --|> scale 0.75
          --|> move (0,-10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "rainbow"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled lightPurple
            , wedge 30.0 0.5
               |> filled red
               |> rotate model.time
            , wedge 25.0 0.5
               |> filled orange
               |> rotate model.time
            , wedge 20.0 0.5
               |> filled yellow
               |> rotate model.time
            , wedge 15.0 0.5
               |> filled green
               |> rotate model.time
            , wedge 10.0 0.5
               |> filled blue
               |> rotate model.time
            , wedge 5.0 0.5
               |> filled purple
               |> rotate model.time
            ]

          --|> scale 0.75
          --|> move (0,-10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "happy"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
               |> filled lightBlue
            , circle 50.0
               |> filled yellow
               |> move ((-20.0), (-10.0))
            , circle 10.0
               |> filled darkCharcoal
            , circle 10.0
               |> filled darkCharcoal
               |> move ((-40.0), 0.0)
            , wedge 20.0 0.5
               |> filled darkCharcoal
               |> rotate (degrees (-90.0))
               |> move ((-20.0), (-20.0))
            ]

          --|> scale 0.75
          |> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "koala"
        myCode = 549

        myShapes model = [ group

            [ square 2000.0
              |> filled black
            , circle 60.0
              |> filled charcoal
              |> move ( 0 , (-7.0))
            , circle 25.0
              |> filled charcoal
              |> move (50.0, 50.0)
            , circle 25.0
              |> filled charcoal
              |> move ((-50.0), 50.0)
            , circle 10.0
              |> filled lightCharcoal
              |> move ((-50.0), 50.0)
            , circle 10.0
              |> filled lightCharcoal
              |> move (50.0, 50.0)
            , circle 10.0
              |> filled darkGrey
              |> move (29.0, 15.0)
            , circle 10.0
              |> filled darkGrey
              |> move ((-29.0), 15.0)
            , circle 10.0
              |> filled  black
            , wedge 5.0 0.5
              |> filled pink
              |> rotate (degrees 270.0)
              |> move ( 0 , (-9.05))
            , circle 5.0
              |> filled black
              |> move (29.0, 15.0)
            , circle 5.0
              |> filled black
              |> move ((-29.0), 15.0)
            , wedge 18.0 0.25
              |> filled charcoal
              |> rotate (degrees 90.0)
              |> move (27.0, 29.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "clock"
        myCode = 549


        hand = group
                 [ rect 2.5 40.0
                    |> filled black
                    |> move (0.0, (20.0))
                 ]

        myShapes model = [ group

            [ square 192.0
               |> filled orange
            , circle 55.0
               |> filled white
            , hand
               |> rotate (-model.time)

               --|> move ((-2.0), (-39.0))
            , rect 2.5 28.0
               |> filled  black
               |> move ((-2.0), (-13.0))
               |> rotate 190.0
            , circle 4.0
               |> filled  black
               |> move (50.0,  0 )
            , circle 4.0
               |> filled black
               |> move ((-50.0),  0 )
            , circle 4.0
               |> filled  black
               |> move ( 0 , 50.0)
            , circle 4.0
               |> filled  black
               |> move ( 0 , (-50.0))
            , text "1"
               |> filled  black
               |> move (20.0, 37.0)
            , text "2"
               |> filled  black
               |> move (37.0, 18.0)
            , text "4"
               |> filled  black
               |> move (39.0, (-26.0))
            , text "5"
               |> filled  black
               |> move (21.0, (-45.0))
            , text "7"
               |> filled  black
               |> move ((-24.0), (-46.0))
            , text "8"
               |> filled  black
               |> move ((-45.0), (-24.0))
            , text "10"
               |> filled  black
               |> move ((-48.0), 15.0)
            , text "11"
               |> filled  black
               |> move ((-30.0), 35.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "bus"
        myCode = 549


        grass = rect 1000.0 20.0

        lefttire = circle 15.0

        rightcircle = circle 0

        righttire = circle 15.0
                      |> filled  black

        sky : Stencil
        sky = square 2000.0

        ltire : Stencil -> Stencil
        ltire inputLefttire = inputLefttire

        rtire : Stencil -> Stencil
        rtire inputRightcircle = inputRightcircle

        myShapes model = [ group

            [ sky
               |> filled blue
            , grass
               |> filled lightGreen
               |> move (0.0, (-55.0))
            , ltire lefttire
               |> filled darkCharcoal
               |> move ((-65.0), (-40.0))
            , circle 15.0
               |> filled darkCharcoal
               |> move ((-25.0), (-40.0))
            , circle 15.0
               |> filled darkCharcoal
               |> move (25.0, (-40.0))
            , circle 15.0
               |> filled darkCharcoal
               |> move (65.0, (-40.0))
            , rect 160.0 50.0
               |> filled darkYellow
               |> move ( 0 , (-10.0))
            , roundedRect 135.0 30.0 20.0
               |> filled darkYellow
               |> move ((-15.0), 20.0)
            , square 30.0
               |> filled lightCharcoal
               |> move (35.0, 15.0)
            , square 30.0
               |> filled lightCharcoal
               |> move ((-30.0), 15.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "face"
        myCode = 549


        myShapes model = [ group

            [ circle 60.0
               |> filled lightBrown
            , circle 10.0
               |> filled blue
               |> move (10.0, 20.0)
            , circle 10.0
               |> filled blue
               |> move ((-20.0), 20.0)
            , wedge 30.0 0.5
               |> filled red
               |> rotate 55.0
            , rect 120.0 30.0
               |> filled darkYellow
               |> move ( 0 , 50.0)
            , rect 40.0 130.0
               |> filled darkYellow
               |> move ((-60.0), 25.0)
            , rect 40.0 130.0
               |> filled darkYellow
               |> move (60.0, 25.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "snowman"
        myCode = 549


        myShapes model = [ group

            [ square 2000.0
               |> filled darkCharcoal
            , circle 20.0
               |> filled white
               |> move ((-5.0), (-40.0))
            , circle 20.0
               |> filled white
               |> move ((-5.0), (-10.0))
            , circle 20.0
               |> filled white
               |> move ((-5.0), 15.0)
            , circle 5.0
               |> filled  black
               |> move (5.0, 20.0)
            , circle 5.0
               |> filled  black
               |> move ((-10.0), 20.0)
            , ngon 3 10.0
               |> filled orange
               |> move (5.0, 5.0)
            , circle 20.0
               |> filled yellow
               |> move (60.0, 35.0)
            , rect 50.0 10.0
               |> filled  black
               |> move ((-5.0), 30.0)
            , square 20.0
               |> filled  black
               |> move ((-5.0), 40.0)

            , circle 5.0
               |> filled  black
               |> move ((-5.0), (-10.0))
            , circle 5.0
               |> filled  black
               |> move ((-5.0), (-30.0))
            , rect 1000.0 5.0
               |> filled white
               |> move ( 0 , (-60.0))
            , circle 20.0
               |> filled white
               |> move (50.0, (-40.0))
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "picklemobile"
        myCode = 549


        myShapes model = [ group

            [ oval 100.0 40.9
               |> filled green
               |> move ((-20.0),  0 )
            , square 30.0
               |> filled green
               |> move ((-25.0), 20.0)
            , circle 10.0
               |> filled  black
               |> move ((-50.0), (-20.0))
            , circle 10.0
               |> filled  black
               |> move ( 0 , (-20.0))
            , square 15.0
               |> filled lightBlue
               |> move ((-20.0), 25.0)
            , circle 5.0
               |> filled darkGrey
               |> move ( 0 , (-20.0))
            , circle 5.0
               |> filled darkGrey
               |> move ((-50.0), (-20.0))
            , circle 5.0
               |> filled yellow
               |> move ((-20.0), 23.0)
            , circle 1.0
               |> filled  black
               |> move ((-17.0), 24.0)
            , rect 13.0 5.0
               |> filled charcoal
               |> move ((-65.0), (-8.0))
            , circle 5.0
               |> filled darkGrey
               |> move ((-75.0), (-8.0))
            , circle 5.0
               |> filled grey
               |> move ((-80.0), (-8.0))
            , rect 20.0 30.0
               |> filled darkGreen

               |> move ((-20.0),  0 )
            , rect 8.0 2.1
               |> filled  black
               |> move ((-15.0),  0 )
            , rect 300.0 40.9
               |> filled  black
               |> move ((-40.0), (-50.0))
            , rect 8.0 2.1
               |> filled yellow
               |> move ((-40.0), (-40.0))
            , rect 8.0 2.1
               |> filled yellow
               |> move ( 0 , (-40.0))

            , rect 8.0 2.1
               |> filled yellow
               |> move (40.0, (-40.0))
            , rect 8.0 2.1
               |> filled yellow
               |> move (80.0, (-40.0))
            , rect 8.0 2.1
               |> filled yellow
               |> move ((-80.0), (-40.0))
            , circle 2.0
               |> filled  black
               |> move ( 0 , (-20.0))
            , circle 2.0
               |> filled  black
               |> move ((-50.0), (-20.0))
            , circle 5.0
               |> filled darkGreen
               |> move ((-50.0),  0 )
            , oval 100.0 20.9
               |> filled lightGrey
               |> move (50.0, 50.0)
            , oval 100.0 20.9
               |> filled lightGrey
               |> move (5.0, 49.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "duck"
        myCode = 549


        myShapes model = [ group

            [ square 200.0
               |> filled lightBlue
            , circle 25.0
               |> filled yellow
               |> move ( 0 , 35.0)
            , circle 30.0
               |> filled yellow
               |> move (0.0, (-10.0))
            , rect 5.0 20.0
               |> filled orange
               |> move ((-10.0), (-48.0))
            , rect 5.0 20.0
               |> filled orange
               |> move (10.0, (-48.0))
            , oval 45.0 20.0
               |> filled darkYellow
               |> move (15.0, (-25.0))
               |> rotate (degrees 235.0)
            , oval 45.0 20.0
               |> filled darkYellow
               |> move ((-10.0), (-25.0))
               |> rotate (degrees 115.0)
            , circle 5.0
               |> filled white
               |> move ((-10.0), 45.0)
            , circle 5.0
               |> filled white
               |> move (10.0, 45.0)
            , ngon 3 5.0
               |> filled orange
               |> move (35.0,  0)
               |> rotate (degrees 450.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "baloon"
        myCode = 549


        myShapes model = [ group

            [ rect 5.0 100.0
               |> filled  black
            , ngon 3 15.0
               |> filled red
               |> move ( 0 , (-3.0))
               |> rotate 255.0
            , oval 50.0 60.0
               |> filled hotPink
               |> move ( 0 , 30.0)
            , circle 5.0
               |> filled lightYellow
               |> move (10.0, 40.0)
            , circle 5.0
               |> filled purple
               |> move ( 0 , 20.0)
            , circle 5.0
               |> filled orange
               |> move (20.0, 30.0)
            , circle 5.0
               |> filled lightGreen
               |> move (10.0, 10.0)
            , circle 5.0
               |> filled pink
            , circle 5.0
               |> filled blue
               |> move ((-20.0), 30.0)
            , circle 5.0
               |> filled lightYellow
               |> move ((-15.0), 20.0)
            , circle 5.0
               |> filled purple
               |> move (10.0, 40.0)
            , circle 5.0
               |> filled darkGreen
               |> move ((-15.0), 40.0)
            , circle 5.0
               |> filled white
               |> move ( 0 , 50.0)
            , circle 5.0
               |> filled lightPurple
               |> move ( 0 , 35.0)
            , circle 5.0
               |> filled lightCharcoal
               |> move ((-10.0), 10.0)
            , circle 5.0
               |> filled white
               |> move (20.0, 30.0)
            , circle 5.0
               |> filled lightOrange
               |> move (15.0, 20.0)
            , circle 5.0
               |> filled  black
               |> move ((-20.0), 30.0)
            , circle 5.0
               |> filled darkYellow
               |> move ((-10.0), 50.0)
            , circle 5.0
               |> filled darkBlue
               |> move (10.0, 50.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "ball"
        myCode = 549


        myShapes model = [ group

            [ square 2000.0
               |> filled black
            , circle 50.0
               |> filled white
               |> move (10.0, 10.0)
            , rect 100.0 10.0
               |> filled red
               |> move (10.0, 10.0)
            , circle 10.0
               |> filled white
               |> move (9.0, 9.0)
            , circle 10.0
               |> filled black
               |> move (9.0, 9.0)
            , circle 8.0
               |> filled white
               |> move (9.0, 9.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "clown"
        myCode = 549


        myShapes model = [ group

            [ square 2000.0
               |> filled darkPurple
            , circle 60.0
               |> filled hotPink
            , circle 8.0
               |> filled lightGreen
               |> move (21.0, 23.0)
            , circle 8.0
               |> filled lightBlue
               |> move ((-21.0), 23.0)
            , rect 40.0 10.0
               |> filled lightOrange
               |> move (20.0, 40.0)
            , rect 40.0 10.0
               |> filled darkYellow
               |> move ((-20.0), 40.0)
            , ngon 9 9.0
               |> filled darkCharcoal
            , circle 3.0
               |> filled black
               |> move ((-21.0), 20.0)
            , circle 20.0
               |> filled lightOrange
               |> move ((-70.0),  0 )
            , circle 20.0
               |> filled orange
               |> move (70.0,  0 )
            , circle 20.0
               |> filled darkRed
               |> move (65.0, 30.0)
            , circle 20.0
               |> filled darkRed
               |> move ((-65.0), 30.0)
            , circle 20.0
               |> filled darkBrown
               |> move (55.0, 56.0)
            , circle 20.0
               |> filled brown
               |> move ((-55.0), 56.0)
            , circle 20.0
               |> filled darkBlue
               |> move (35.0, 60.0)
            , circle 20.0
               |> filled darkBlue
               |> move ((-35.0), 60.0)
            , circle 20.0
               |> filled green
               |> move (0.0, 65.0)
            , circle 3.0
               |> filled  black
               |> move (20.0, 20.0)
            , circle 30.0
               |> filled darkGreen
               |> move (0.0, (-50.0))
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "apple tree"
        myCode = 549


        myShapes model = [ group

            [ square 2000.0
               |> filled lightBlue
            , circle 32.0
               |> filled green
               |> move (4.0, 0.0)
            , rect 8.0 43.0
               |> filled black
               |> move (0.0, (-48.0))
            , circle 3.0
               |> filled red
               |> addOutline (solid 2.0) red
            , circle 3.0
               |> filled red
               |> move ((-23.0), 3.0)
            , square 4.0
               |> filled red
            , circle 4.0
               |> filled darkRed
            , circle 4.0
               |> filled red
            , circle 3.0
               |> filled red
               |> move (20.0, 5.0)
            , circle 3.0
               |> filled red
               |> move (10.0, (-20.0))
            , circle 3.0
               |> filled red
            , circle 4.0
               |> filled red
            , circle 3.0
               |> filled red
            , circle 3.0
               |> filled red
               |> move (34.0, 0.0)
            , circle 3.0
               |> filled red
               |> move ((-5.0), 15.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "phone"
        myCode = 549


        myShapes model = [ group

            [ roundedRect 50.0 90.0 5.0
               |> filled black
            , roundedRect 40.0 70.0 5.0
               |> filled green
            , circle 3.0
               |> filled darkGrey
               |> move (0.0, (-40.0))
            , rect 8.0 2.0
               |> filled darkGrey
               |> move (0.0, 40.0)
            , roundedRect 8.0 8.0 2.0
               |> filled lightBlue
               |> move ((-12.0), 25.0)
            , roundedRect 8.0 8.0 2.0
               |> filled hotPink
               |> move (0.0, 25.0)
            , roundedRect 8.0 8.0 2.0
               |> filled darkPurple
               |> move (12.0, 25.0)
            , roundedRect 8.0 8.0 2.0
               |> filled lightOrange
               |> move ((-12.0), 10.0)
            , roundedRect 8.0 8.0 2.0
               |> filled darkBlue
               |> move (0.0, 10.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "bunny"
        myCode = 549


        myShapes model = [ group

            [ square 270.0
               |> filled blue
            , oval 50.0 20.0
               |> filled white
               |> move ((-40.0), (-12.0))
               |> rotate (degrees 270.0)
            , oval 50.0 20.0
               |> filled white
               |> move (40.0, (-10.0))
               |> rotate (degrees 90.0)
            , circle 30.0
               |> filled white
            , circle 5.0
               |> filled grey
               |> move (0.5, (-10.0))
            , circle 10.0
               |> filled  black
               |> move (2.0, (-10.0))
               |> rotate 10.0
            , circle 10.0
               |> filled  black
               |> move (5.0, (-10.0))
               |> rotate (-5.0)
            , circle 30.0
               |> filled white
               |> move (0.5, (-50.0))
            , oval 30.0 10.0
               |> filled white
               |> move (0.5, (-40.0))
               |> rotate (degrees 45.0)
            , oval 30.0 10.0
               |> filled darkGrey
               |> move (0.5, (-40.0))
               |> rotate (degrees 40.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "rainbow"
        myCode = 549


        myShapes model = [ group

            [ square 500.0
               |> filled lightBlue
            , wedge 30.0 0.5
               |> filled red
               |> rotate (degrees 90.0)
            , wedge 25.0 0.5
               |> filled orange
               |> rotate (degrees 90.0)
            , wedge 20.0 0.5
               |> filled yellow
               |> rotate (degrees 90.0)
            , wedge 15.0 0.5
               |> filled green
               |> rotate (degrees 90.0)
            , wedge 10.0 0.5
               |> filled blue
               |> rotate (degrees 90.0)
            , wedge 5.0 0.5
               |> filled lightBlue
               |> rotate (degrees 90.0)
            , wedge 5.0 0.5
               |> filled purple
               |> rotate (degrees 90.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "ghost"
        myCode = 549


        myShapes model = [ group

            [ wedge 20.0 0.7
               |> filled red
               |> move ((-40.0),  0 )
               |> rotate (-5000.0)
            , wedge 20.0 0.7
               |> filled red
               |> move ((-45.0), 40.0)
               |> rotate (-5000.0)
            , wedge 20.0 0.7
               |> filled red
               |> move ((-35.0), (-40.0))
               |> rotate (-5000.0)
            , rect 120.0 30.0
               |> filled red
               |> move ((-5.0), (-20.0))
            , wedge 60.0 0.5
               |> filled red
               |> move ((-5.0), 5.0)
               |> rotate (degrees 90.0)
            , circle 20.0
               |> filled lightCharcoal
               |> move (20.0, 15.0)
            , circle 10.0
               |> filled  black
               |> move (25.0, 15.0)
            , circle 20.0
               |> filled lightCharcoal
               |> move ((-25.0), 15.0)
            , circle 10.0
               |> filled  black
               |> move ((-25.0), 15.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "popcorn"
        myCode = 549


        myShapes model = [ group

            [ rect 10.0 50.0
               |> filled red
               |> move ((-30.0), (-30.0))
            , rect 10.0 50.0
               |> filled blue
               |> move ((-20.0), (-30.0))
            , rect 10.0 50.0
               |> filled red
               |> move ((-10.0), (-30.0))
            , rect 10.0 50.0
               |> filled blue
               |> move (0.0, (-30.0))
            , rect 10.0 50.0
               |> filled red
               |> move (10.0, (-30.0))
            , rect 10.0 50.0
               |> filled blue
               |> move (20.0, (-30.0))
            , rect 10.0 50.0
               |> filled red
               |> move (30.0, (-30.0))
            , circle 7.0
               |> filled lightYellow
               |> move ((-30.0), 0.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-20.0), 0.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-10.0), 0.0)
            , circle 7.0
               |> filled lightYellow
            , circle 7.0
               |> filled lightYellow
               |> move (10.0, 0.0)
            , oval 60.0 20.0
               |> filled white
               |> move (0.0, (-30.0))
               |> rotate 0.0
            , circle 7.0
               |> filled lightYellow
               |> move (20.0, 0.0)
            , circle 7.0
               |> filled lightYellow
            , circle 7.0
               |> filled lightYellow
               |> move (30.0, 0.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-25.0), 10.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-15.0), 10.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-5.0), 10.0)
            , circle 7.0
               |> filled lightYellow
               |> move (0.0, 10.0)
            , circle 7.0
               |> filled lightYellow
               |> move (5.0, 10.0)
            , circle 7.0
               |> filled lightYellow
               |> move (12.0, 10.0)
            , circle 7.0
               |> filled lightYellow
               |> move (25.0, 10.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-20.0), 20.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-10.0), 20.0)
            , circle 7.0
               |> filled lightYellow
               |> move (0.0, 20.0)
            , circle 7.0
               |> filled lightYellow
               |> move (10.0, 20.0)
            , circle 7.0
               |> filled lightYellow
               |> move (20.0, 20.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-15.0), 25.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-5.0), 25.0)
            , circle 7.0
               |> filled lightYellow
               |> move (0.0, 25.0)
            , circle 7.0
               |> filled lightYellow
               |> move (5.0, 25.0)
            , circle 7.0
               |> filled lightYellow
               |> move (15.0, 25.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-10.0), 30.0)
            , circle 7.0
               |> filled lightYellow
               |> move (0.0, 30.0)
            , circle 7.0
               |> filled lightYellow
               |> move (10.0, 30.0)
            , circle 7.0
               |> filled lightYellow
               |> move ((-5.0), 35.0)
            , circle 7.0
               |> filled lightYellow
               |> move (5.0, 35.0)
            ]

          |> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "penguin"
        myCode = 549


        myShapes model = [ group

            [ oval 30.0 45.0
               |> filled  black
            , oval 12.0 32.0
               |> filled black
               |> move (15.0, (-5.0))
               |> rotate 19.0
            , oval 12.0 32.0
               |> filled  black
               |> move ((-15.0), (-4.0))
               |> rotate 25.0
            , oval 20.0 15.0
               |> filled  black
               |> move (0.0, 24.0)
            , oval 15.0 30.0
               |> filled white
               |> move ( 0 , (-5.0))
            , oval 10.0 4.0
               |> filled orange
               |> move ( 0 , 20.0)
            ]

         --|> scale 0.5
          --|> move (20,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "house"
        myCode = 549


        myShapes model = [ group

            [ square 50.0
               |> filled brown
               |> move (0.0, (-35.0))
            , ngon 3 35.0
               |> filled red
               |> move ((-35.0), 0.0)
               |> move (35.0, 0.0)
               |> rotate (degrees 90.0)
            , rect 10.0 20.0
               |> filled black
               |> move ((-10.0), (-50.0))
            , circle 2.0
               |> filled white
               |> move ((-7.0), (-50.0))
            ]

         --|> scale 0.5
          |> move (0,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "cake"
        myCode = 549


        myShapes model = [ group

            [ square 2000.0
               |> filled pink
            , square 70.0
               |> filled lightBrown
               |> move ((-10.0), (-10.0))
            , rect 520.0 50.0
               |> filled brown
               |> move ((-20.0), (-60.0))
            , rect 20.0 70.0
               |> filled white
               |> move (20.0, 10.0)
               |> rotate 1.6
            , circle 10.0
               |> filled red
               |> move ((-10.0), 25.0)
            , circle 5.0
               |> filled black
               |> move ((-10.0), 30.0)
            , rect 10.0 70.0
               |> filled brown
               |> move (10.0, 10.0)
               |> rotate 1.6
            , rect 10.0 10.0
               |> filled lightRed
               |> move (10.0, 20.0)
            , rect 10.0 10.0
               |> filled lightOrange
               |> move ((-30.0), 20.0)
            , rect 20.0 3.0
               |> filled lightGreen
               |> move (40.0, (-10.0))
               |> rotate 1.6
            , ngon 3 5.0
               |> filled red
               |> move ((-34.0), (-40.0))
               |> rotate (-2.6)
            , ngon 3 3.0
               |> filled lightOrange
               |> move ((-34.0), (-40.0))
               |> rotate (-2.6)

               |> move (model.time, 1.0)
            , rect 10.0 70.0
               |> filled brown
               |> move ((-20.0), 10.0)
               |> rotate 1.6
            ]

         |> scale 0.75
          --|> move (0,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ,    let
        myWord = "hand"
        myCode = 549


        myShapes model = [ group

            [ square 2000.0
               |> filled lightBlue
            , circle 25.0
               |> filled darkYellow
               |> move (0.0, (-10.0))
            , roundedRect 30.0 50.0 30.0
               |> filled darkYellow
               |> move (0.0, (-50.0))
            , roundedRect 10.0 40.0 1.0
               |> filled darkYellow
               |> move ((-20.0), 20.0)
               |> rotate (-25.0)
            , text "Fingers! Or a hand"
               |> filled  black
               |> move ((toFloat (10 +  (-20))), 50.0)
            , roundedRect 10.0 40.0 1.0
               |> filled darkYellow
               |> move ((-9.0), 20.0)
            , roundedRect 10.0 40.0 1.0
               |> filled darkYellow
               |> move (2.0, 20.0)
               |> rotate (-0.2)
            , roundedRect 10.0 40.0 1.0
               |> filled darkYellow
               |> move (17.0, 20.0)
               |> rotate (-0.2)
            , roundedRect 23.0 10.0 1.0
               |> filled darkYellow
               |> move (19.0, (-23.0))
               |> rotate 0.8
            ]

         |> scale 0.75
          --|> move (0,10)
          ]
    in (("ElmJr",myWord,"0"),("~","~",myShapes))

  ]
