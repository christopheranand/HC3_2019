module WebExtra exposing (..)

import Bootstrap.Accordion as Accordion
import Bootstrap.Carousel as Carousel
import Bootstrap.Carousel.Slide as Slide
import Bootstrap.Modal as Modal
import Dict exposing (Dict)
import Html.Attributes exposing (..)

accordionState : Int -> Dict Int Accordion.State -> Accordion.State
accordionState n d =
    Maybe.withDefault (Accordion.initialStateCardOpen "") (Dict.get n d)


carouselState : Int -> Dict Int Carousel.State -> Carousel.State
carouselState n d =
    Maybe.withDefault Carousel.initialState (Dict.get n d)


modalVisibility : Int -> Dict Int Modal.Visibility -> Modal.Visibility
modalVisibility n d =
    Maybe.withDefault Modal.hidden (Dict.get n d)

image h url = Slide.image [style "height" h, style "margin" "auto"] url

type alias Flags =
    {}
