module Countdown.State exposing (..)

import Time exposing (Time)

import Countdown.Types exposing (..)

-- Init

init : Model
init = Model 0 0 0 0

-- UPDATE

seconds_remaining : (Days,Hours,Minutes,TimeRemaining) -> (Days,Hours,Minutes,Seconds)
seconds_remaining (days,hours,minutes,leftover) =
    let
        seconds = leftover // (round Time.second)
    in
        (days,hours,minutes,seconds)


minutes_remaining : (Days,Hours,TimeRemaining) -> (Days, Hours, Minutes, TimeRemaining)
minutes_remaining (days,hours,leftover) =
    let
        minutes = leftover // (round Time.minute)
        remainder = rem leftover (round Time.minute)
    in
        (days,hours,minutes,remainder)

hours_remaining : (Days,TimeRemaining) -> (Days, Hours, TimeRemaining)
hours_remaining (days,leftover) =
    let
        hours = leftover // (round Time.hour)
        remainder = rem leftover (round Time.hour)
    in
        (days,hours,remainder)

days_remaining : TimeRemaining -> (Days,TimeRemaining)
days_remaining leftover =
    let
        days : Int
        days = leftover // (round Time.hour * 24)

        remainder : Int
        remainder = rem leftover (round Time.hour * 24)
    in
        (days , remainder)

--- Takes the current time and target time and returns time different
timeRemaining : Now -> Target -> Model
timeRemaining now target =
    let
        (days,hours,minutes,seconds) = days_remaining (round (target - now))
                                       |> hours_remaining
                                       |> minutes_remaining
                                       |> seconds_remaining
    in
        Model days hours minutes seconds


update : Msg -> ( Model, Cmd Msg )
update msg =
    case msg of
        UpdateCounter now ->
            (timeRemaining now carnival_date , Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Sub Msg
subscriptions =
    Time.every Time.second UpdateCounter
