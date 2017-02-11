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
            ,Package "Package 1" "Some description" <| Array.fromList
                [
                  Slide "../res/3.png" 708 280
                ,Slide "../res/4.png" 968 574
                ]
            ]
       ,active_package = 0
       ,slideshow = Slideshow.Types.Model (Array.fromList [Slideshow.Types.Slide "../res/1.png" 708 280 ,Slideshow.Types.Slide "../res/2.png" 968 574]) 0
       }

-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SwitchPackage -> (initialModel, Cmd.none)
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
