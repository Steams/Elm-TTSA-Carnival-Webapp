module Slideshow.View exposing (view)

import Html exposing (Html, button, div, text, program, ul, li, img, span)
import Html.Attributes exposing (class, classList, src, height, width)
import Array

import Slideshow.Types exposing (..)

view : Model -> Html Msg
view model =
    case (Array.get model.active_slide model.slides) of
        Just slide ->
            div [ class "slideshow_container"]
                [
                 div [ class "slideshow_switcher" ] []
                ,img [src slide.url, height slide.height, width slide.width, class "image_canvas"] []
                ]
        Nothing -> div [] []
