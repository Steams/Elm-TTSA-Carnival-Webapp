module Slideshow.View exposing (view)

import Html exposing (Html, button, div, text, program, ul, li, img, span)
import Html.Attributes exposing (class, classList, src, height, width, style)
import Html.Events exposing (onClick)
import Array


import Slideshow.Types exposing (..)

(=>) : a -> b -> (a,b)
(=>) = (,)

dot : Int -> Int -> Html Msg
dot position active =
    div [ classList [("dot",True),("active",active == position)], onClick <| SetSlideshowPosition position] []

proportional_width : Int -> Int -> Int
proportional_width width height =
    if height > width then
        ceiling (90 * (toFloat width / toFloat height)) + 4
    else
        90

proportional_height : Int -> Int -> Int
proportional_height width height =
    if height < width then
        ceiling (90 * (toFloat height / toFloat width)) + 4
    else
        90

view : Model -> Html Msg
view model =
    case (Array.get model.active_slide model.slides) of
        Just slide ->
            div [ class "slideshow_container"]
                [
                  Array.indexedMap (\index a -> dot index model.active_slide) model.slides
                    |> Array.toList
                    |> div [ class "slideshow_switcher" ]
                ,img [src slide.url, class "image_canvas", style [
                           "width" => (toString (proportional_width slide.width slide.height) ++ "%")
                           ,"height" => (toString (proportional_height slide.width slide.height) ++ "%")
                          ] ] []
                ]
        Nothing -> div [] []
