module Slideshow.State exposing (..)

import Array
import Time

import Slideshow.Types exposing (..)

-- Init

initialModel : Model
initialModel = Model ( Array.fromList [] )  0

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
        NextSlide -> ({model | active_slide = succ_slide model }, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Sub Msg
subscriptions =
    Time.every (Time.second * 4) (\t-> NextSlide)
