module Slideshow.State exposing (..)

import Array
import Time exposing (..)

import Slideshow.Types exposing (..)
import TouchEvents exposing (..)
import Task exposing (..)
import Debug exposing (log)

-- Init

initialModel : Model
initialModel = Model ( Array.fromList [] )  0 0 0 0


-- UPDATE

succ_slide : Model -> Int
succ_slide model =
    (model.active_slide + 1) % (Array.length model.slides)

pred_slide : Model -> Int
pred_slide model =
    (model.active_slide - 1) % (Array.length model.slides)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Null -> (model, Cmd.none)
        -- SetTime time -> ({model | touch_time = time}, Cmd.none)

        NextSlide -> ({model | active_slide = succ_slide model }, Cmd.none)

        PrevSlide -> ({model | active_slide = pred_slide model }, Cmd.none)

        SetSlideshowPosition index -> ({model | active_slide = index }, Cmd.none)

        StartedTouch touch ->
            ( model, Task.perform (TouchWithTime touch) Time.now )

        TouchWithTime touch time ->
                ({model | touch_start = touch.clientX, touch_time = time}, Cmd.none)

        EndedTouch touch ->
            ( model, Task.perform (EndTouchWithTime touch) Time.now )

        EndTouchWithTime touch time ->
            let
                start = model.touch_start
                end = touch.clientX
                direction = getDirectionX start end
                distance = (abs (start - end))
                delta_time = (abs (time - model.touch_time))
                speed = distance/delta_time
                swipe = (distance > 10) && (speed > 1)
                _ = log "distance" distance
                _ = log "speed" speed
            in
                if swipe then
                    if (direction == Left) then
                        let
                            (new_model, cmdMsg) = update NextSlide model
                        in
                            ({new_model | touch_start = 0 }, cmdMsg)
                    else
                        let
                            (new_model, cmdMsg) = update PrevSlide model
                        in
                            ({new_model | touch_start = 0 }, cmdMsg)
                else
                    ({model | touch_start = 0 }, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Sub Msg
subscriptions =
    Time.every (Time.second * 5) <|
        (\t-> NextSlide )
        -- (\t->
        --      let
        --          _ = log "time" t
        --      in
        --         NextSlide
        -- )
