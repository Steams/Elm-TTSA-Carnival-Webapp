module Showcase.State exposing (..)

import Time
import Array

import Showcase.Types exposing (..)

import Slideshow
import Slideshow.Types exposing (Slide)

-- Init

-- set slideshow inital model to from the first package
initialModel : Model
initialModel = {
        packages =
            Array.fromList
            [
             Package "Package 1" "Some description" <| Array.fromList
                [
                  Slide "../res/1.png" 708 280
                ,Slide "../res/2.png" 968 574
                ]
            ,Package "Package 2" "Some OTHER description" <| Array.fromList
                [
                  Slide "../res/3.png" 708 280
                ,Slide "../res/4.png" 968 574
                ]
            ]
       ,active_package = 0
       ,slideshow = Slideshow.Types.Model (Array.fromList [Slideshow.Types.Slide "../res/1.png" 708 280 ,Slideshow.Types.Slide "../res/2.png" 968 574]) 0
       }

getSlideshow : Model -> Int -> Slideshow.Model
getSlideshow model package_index =
    {
         slides = case Array.get package_index model.packages of
                     Just package ->
                         package.slides
                     Nothing -> Array.fromList []
        , active_slide = 0
    }

-- UPDATE

succ_package : Model -> Int
succ_package model =
    (model.active_package + 1) % (Array.length model.packages)


pred_package : Model -> Int
pred_package model =
    (model.active_package - 1) % (Array.length model.packages)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NextPackage ->
            let
                new_index = succ_package model

                new_slideshow = getSlideshow model new_index
            in
            ({model | active_package = new_index
             , slideshow = new_slideshow }, Cmd.none)

        PrevPackage ->
            let
                new_index = pred_package model

                new_slideshow = getSlideshow model new_index
            in
            ({model | active_package = new_index
             , slideshow = new_slideshow }, Cmd.none)

        UpdateSlideshow subMsg ->
            let
                (new_model, slideshow_msg) = Slideshow.update subMsg model.slideshow
            in
                ({model | slideshow = new_model}
                ,Cmd.map UpdateSlideshow slideshow_msg)


-- SUBSCRIPTIONS

subscriptions : Sub Msg
subscriptions =
    Sub.batch [ Sub.map UpdateSlideshow Slideshow.subscriptions ]
