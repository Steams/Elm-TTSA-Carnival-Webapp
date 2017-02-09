module Header exposing (..)

import Html exposing (Html, button, div, text, program, ul, li)
import Html.Attributes exposing (class,classList)
import Time exposing (..)
import Date exposing (..)
import Task

import Countdown.Data as CData
import Countdown.Main as Countdown

-- Types

type alias Model = { countdown : Countdown.Model }

type Msg = Update Countdown.Msg

-- Model

initialModel : Model
initialModel = Model Countdown.init


-- VIEW

countdown : Countdown.Model -> Html Countdown.Msg
countdown = Countdown.view


navbar : Html Msg
navbar =
    ul [ class "navbar" ]
        [
          li [class "about"] [ text "About Us"],
          li [class "register"] [ text "Register"]
        ]

title : Html Msg
title =
    div [class "title"]
        [
         text "CARNIVAL 2018"
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

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update updateCounter ->
            let
                (new_model, updateMsg) = Countdown.update updateCounter
            in
                ({model | countdown = new_model}
                , Cmd.map Update updateMsg)

-- SUBSCRIPTIONS
subscriptions : Sub Msg
subscriptions =
    Sub.batch [Sub.map Update Countdown.subscriptions]
