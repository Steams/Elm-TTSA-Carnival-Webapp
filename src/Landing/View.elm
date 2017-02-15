module Landing.View exposing (view)

import Html exposing (Html, button, div, text, program, ul, li, img, span)
import Html.Attributes exposing (class, classList, src, height, width)

import Showcase

import Landing.Types exposing (..)

-- import Showcase

-- VIEW

showcase : Showcase.Model -> Html Showcase.Msg
showcase = Showcase.view

super_title : Html Msg
super_title =
    div [ class "hero_super_title" ]
        [
         span [class "hero_super_title_text"] [text "T T S A"]
        ]

title : Html Msg
title =
    div [ class "hero_title" ]
        [
         -- img [src "../res/unnamed.png", height 130, width 600] []
         span [class "hero_title_text"] [text "Cosmopolitan"]
        ]

sub_title : Html Msg
sub_title =
    div [ class "hero_sub_title" ]
        [
         span [class "intro_text"] [text "Be part of one of the largest bands for "]
        ,span [ class "highlight" ] [ text " UWI CARNIVAL!"]
        ]

hero : Html Msg
hero =
    div [ class "hero" ]
        [
         super_title
        ,title
        ,sub_title
        ]

view : Model -> Html Msg
view model =
    div [ class "landing_container" ]
        [
         hero
        ,Html.map UpdateShowcase <| showcase model.showcaseModel
        ]
