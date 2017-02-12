module Showcase.State exposing (..)

import Time
import Array

import Showcase.Types exposing (..)

import Slideshow
import Slideshow.Types exposing (Slide)

-- Init

-- set slideshow inital model to from the first package

package_1 : Package
package_1 = Package "Female Bikini" "Description" <| Array.fromList
                [
                  Slide "../res/package_1_image_1.jpeg" 1066 1600
                , Slide "../res/package_1_image_2.jpeg" 1066 1600
                , Slide "../res/package_1_image_3.jpeg" 1066 1600
                , Slide "../res/package_1_image_4.jpeg" 1066 1600
                ]

package_2 : Package
package_2 = Package "Female Monokini" "Description" <| Array.fromList
                [
                  Slide "../res/package_2_image_1.jpeg" 1066 1600
                , Slide "../res/package_2_image_2.jpeg" 1066 1600
                ]

package_3 : Package
package_3 = Package "Female Tube Top" "Description" <| Array.fromList
                [
                  Slide "../res/package_3_image_1.jpeg" 1066 1600
                , Slide "../res/package_3_image_2.jpeg" 720 900
                ]

package_4 : Package
package_4 = Package "Male Tank & T-Shirt" "Description" <| Array.fromList
                [
                  Slide "../res/package_4_image_1.jpeg" 1066 1600
                , Slide "../res/package_4_image_2.jpeg" 1066 1600
                , Slide "../res/package_4_image_3.jpeg" 1066 1600
                , Slide "../res/package_4_image_4.jpeg" 1600 1236
                ]

package_5 : Package
package_5 = Package "Female Tank & T-Shirt" "Description" <| Array.fromList
                [
                  Slide "../res/package_5_image_1.jpeg" 1066 1600
                , Slide "../res/package_5_image_2.jpeg" 1066 1600
                , Slide "../res/package_5_image_3.jpeg" 1600 1236
                , Slide "../res/package_5_image_4.jpeg" 1600 1236
                ]

package_6 : Package
package_6 = Package "Drink Band" "Description" <| Array.fromList
                [
                  Slide "../res/package_6_image_1.jpeg" 430 600
                ]

initialModel : Model
initialModel = {
        packages =
            Array.fromList
            [
              package_1
             ,package_2
             ,package_3
             ,package_4
             ,package_5
             ,package_6
            ]
       ,active_package = 0
       ,slideshow = Slideshow.Types.Model package_1.slides 0
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
