module Showcase.Types exposing (..)

import Html exposing (Html)
import Array exposing (Array)
import Slideshow
import Slideshow.Types exposing (..)
import Http

-- Messages

type Msg
    = NextPackage
    | PrevPackage
    | UpdateSlideshow Slideshow.Msg
    | NameInput String
    | EmailInput String
    | AdditionalInput String
    | GenderInput String
    | ColorInput String
    | SizeInput String
    | Submit
    | Fail
    | Success
    | Post (Result Http.Error String)

-- Types

type alias Package =
    {
          title : String
        , cost : String
        , description : Html Msg
        , slides : Array Slide
    }


-- Model
type alias Form =
    {
      name : String
    , email : String
    , additional : String
    , gender : String
    , size : String
    , color : String
    }

type alias Model =
    {
         packages : Array Package
       , active_package : Int
       , slideshow : Slideshow.Model
       , info : Form
    }

