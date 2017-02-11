module Slideshow.Types exposing (..)

import Array exposing (Array)

type Msg
    = NextSlide
    | SetSlideshowPosition Int

type alias Slide = {url : String, width : Int, height : Int }

type alias Model = { slides : Array Slide, active_slide : Int }
