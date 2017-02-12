module Header.View exposing (..)

import Html exposing (Html, button, div, text, program, ul, li)
import Html.Attributes exposing (class,classList)

import Header.Types exposing (..)

import Countdown

-- VIEW

countdown : Countdown.Model -> Html Countdown.Msg
countdown = Countdown.view


navbar : Html Msg
navbar =
    ul [ class "navbar" ]
        [
          -- li [class "about"] [ text "About Us"],
          -- li [class "register"] [ text "Register"]
        ]

title : Html Msg
title =
    div [class "logo"]
        [
         text "2017"
        ]

header : Model -> Html Msg
header model =
    div [ class "header"]
        [
         title
        , Html.map Update (countdown model.countdown)
        , navbar
        ]

view : Model -> Html Msg
view model =
    div [ class "header_container"]
        [header model]
