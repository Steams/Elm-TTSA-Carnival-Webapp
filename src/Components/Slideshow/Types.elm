module Slideshow.Types exposing (..)

import Array exposing (Array)
import TouchEvents exposing (..)
import Time exposing (..)

type Msg
    = NextSlide
    | PrevSlide
    | SetSlideshowPosition Int
    | Null
    | StartedTouch Touch
    | TouchWithTime Touch Time
    | EndTouchWithTime Touch Time
    | EndedTouch Touch

type alias Slide = {url : String, width : Int, height : Int }

type alias Model = { slides : Array Slide, active_slide : Int , touch_start : Float, touch_time : Time, end_time : Time}
