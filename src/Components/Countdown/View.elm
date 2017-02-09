module Countdown.View exposing (..)

import Html exposing (Html, button, div, text, program, ul, li)
import Html.Attributes exposing (class,classList)

import Countdown.Types exposing (..)

type alias Unit = String
type alias Duration = Int

-- View

countdownItem : Unit -> Duration -> Html Msg
countdownItem unit duration =
    let
        prefix = "countdown_"
    in
        li [ classList [("countdown_item",True),("countdown_" ++ unit,True)]]
            [
              div [classList [(prefix++unit++"_num",True),("countdown_item_top",True)]] [text (toString duration)],
              div [classList [(prefix++unit++"_title",True),("countdown_item_bot",True)]] [text unit]
            ]

view : Model -> Html Msg
view model =
    div [ class "countdown_container" ]
        [
         ul [ class "countdown_list" ]
             [
              countdownItem "Days" model.days
              , countdownItem "Hours" model.hours
              , countdownItem "Minutes" model.minutes
              , countdownItem "seconds" model.seconds
             ]
        ]
