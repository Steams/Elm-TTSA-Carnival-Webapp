module Showcase.Types exposing (..)

import Array exposing (Array)
import Slideshow
import Slideshow.Types exposing (..)

-- Messages

type Msg
    = NextPackage
    | PrevPackage
    | UpdateSlideshow Slideshow.Msg

-- Types

type alias Package =
    {
          title : String
        , description : String
        , slides : Array Slide
    }


-- Model

type alias Model =
    {
        packages : Array Package
       ,active_package : Int
       ,slideshow : Slideshow.Model
    }

