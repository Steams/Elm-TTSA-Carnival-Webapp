module Showcase.State exposing (..)

import Html exposing (Html,li,ul,p,text,div)
import Html.Attributes exposing (..)
import Array
import Http
import Debug exposing (log)
import Json.Encode as Encode exposing (..)
import Json.Decode as Decode

import Slideshow
import Slideshow.Types exposing (Slide)
import Showcase.Types as Types exposing (..)


-- Init

empty_order : Types.Order
empty_order =
    {
      name = ""
    , email = ""
    , additional = ""
    , gender = "Female"
    , size = "Sml"
    , color = "White"
    }

package_1_description : Html Msg
package_1_description =
    div []
        [
          p [ class "inclusive" ] [ text "Package inclusive of" ]
        , ul []
            [
              li [] [text "Goodie bag"]
            , li [] [text "Cup for the road"]
            , li [] [text "Premium drinks on the road"]
            , li [] [text "Breakfast"]
            ]
         , p [] [text "Early bird offer valid until Friday February 17"]
        ]

package_1 : Package
package_1 =
    {
      title = "Female Costume (Top and Bottom)"
    , cost = "$6000 | early bird offer $5500"
    , description = package_1_description
    , slides = Array.fromList
        [
          Slide "../res/package_1_image_1.jpeg" 1066 1600
        , Slide "../res/package_1_image_2.jpeg" 1066 1600
        , Slide "../res/package_1_image_3.jpeg" 1066 1600
        , Slide "../res/package_1_image_4.jpeg" 1066 1600
        ]
    }

package_2_description : Html Msg
package_2_description =
    div []
        [
          p [ class "inclusive" ] [ text "Package inclusive of" ]
        , ul []
            [
              li [] [text "Goodie bag"]
            , li [] [text "Cup for the road"]
            , li [] [text "Premium drinks on the road"]
            , li [] [text "Breakfast"]
            ]
        ]

package_2 : Package
package_2 =
    {
        title = "Monokini"
      , cost = "$4000"
      , description = package_2_description
      , slides = Array.fromList
            [
              Slide "../res/package_2_image_1.jpeg" 1066 1600
            , Slide "../res/package_2_image_2.jpeg" 1066 1600
            ]
    }

package_3_description : Html Msg
package_3_description =
    div []
        [
          p [ class "colors_available" ] [text "Colors Available - black,white"]
        , p [ class "inclusive" ] [text "Package inclusive of"]
        , ul []
            [
              li [] [text "Goodie bag"]
            , li [] [text "Cup for the road"]
            , li [] [text "Premium drinks on the road"]
            , li [] [text "Breakfast"]
            ]
        ]

package_3 : Package
package_3 =
    {
      title = "Tube Top"
    , cost = "$2500"
    , description = package_3_description
    , slides = Array.fromList
               [
                 Slide "../res/package_3_image_1.jpeg" 1066 1600
               , Slide "../res/package_3_image_2.jpeg" 720 900
               ]
    }

package_4_description : Html Msg
package_4_description =
    div []
        [
          p [ class "colors_available" ] [text "Colors Available - black,white"]
        , p [ class "inclusive" ] [text "Package inclusive of"]
        , ul []
            [
              li [] [text "Goodie bag"]
            , li [] [text "Cup for the road"]
            , li [] [text "Premium drinks on the road"]
            , li [] [text "Breakfast"]
            ]
        ]

package_4 : Package
package_4 =
    {
      title = "Male Tank & T-Shirt"
    , cost = "$3000"
    , description = package_4_description
    , slides = Array.fromList
               [
                  Slide "../res/package_4_image_1.jpeg" 1066 1600
                , Slide "../res/package_4_image_2.jpeg" 1066 1600
                , Slide "../res/package_4_image_3.jpeg" 1066 1600
                , Slide "../res/package_4_image_4.jpeg" 1600 1236
               ]
    }

package_5_description : Html Msg
package_5_description =
    div []
        [
          p [ class "colors_available" ] [text "Colors Available - black,white"]
        , p [ class "inclusive" ] [text "Package inclusive of"]
        , ul []
            [
              li [] [text "Goodie bag"]
            , li [] [text "Cup for the road"]
            , li [] [text "Premium drinks on the road"]
            , li [] [text "Breakfast"]
            ]
        ]

package_5 : Package
package_5 =
    {
      title = "Female Tank & T-Shirt"
    , cost = "$3000"
    , description = package_5_description
    , slides = Array.fromList
               [
                  Slide "../res/package_5_image_1.jpeg" 1066 1600
                , Slide "../res/package_5_image_2.jpeg" 1066 1600
                , Slide "../res/package_5_image_3.jpeg" 1600 1236
                , Slide "../res/package_5_image_4.jpeg" 1600 1236
               ]
    }

package_6_description : Html Msg
package_6_description =
    div []
        [
          p [ class "inclusive" ] [text "Package inclusive of"]
        , ul []
            [
             li [] [text "Premium drinks on the road"]
            ]
        ]

package_6 : Package
package_6 =
    {
      title = "Drink Band"
    , cost = "$1500"
    , description = package_6_description
    , slides = Array.fromList
               [
                Slide "../res/package_6_image_1.jpeg" 430 600
               ]
    }

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
       ,slideshow = Slideshow.Types.Model package_1.slides 0 0 0 0
       ,order = empty_order
       }

getSlideshow : Model -> Int -> Slideshow.Model
getSlideshow model package_index =
    {
         slides = case Array.get package_index model.packages of
                     Just package ->
                         package.slides
                     Nothing -> Array.fromList []
        , active_slide = 0
        , touch_start = 0
        , touch_time = 0
        , end_time = 0
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
        PostResponse res->
            (model,Cmd.none)

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
        NameInput value ->
            let
                order = model.order
            in
                ({model | order = { order | name = value } },Cmd.none)
        EmailInput value ->
            let
                order = model.order
            in
                ({model | order = { order | email = value } },Cmd.none)
        AdditionalInput value ->
            let
                order = model.order
            in
                ({model | order = { order | additional = value } },Cmd.none)
        GenderInput value ->
            let
                order = model.order
            in
                ({model | order = { order | gender = value } },Cmd.none)
        ColorInput value ->
            let
                order = model.order
            in
                ({model | order = { order | color = value } },Cmd.none)
        SizeInput value ->
            let
                order = model.order
            in
                ({model | order = { order | size = value } },Cmd.none)
        Submit ->
            let
              _ = log "name" model.order.name
              _ = log "gender" model.order.gender
              _ = log "size" model.order.size
              package = Maybe.withDefault (Package "" "" (div [] []) (Array.fromList []) ) (Array.get model.active_package model.packages)
              order = Encode.object <|
                      [
                        ("name", string model.order.name)
                      , ("gender", string model.order.gender)
                      , ("size", string model.order.size)
                      , ("additional", string model.order.additional)
                      , ("color", string model.order.color)
                      , ("email", string model.order.email)
                      , ("package_name", string package.title)
                      ]
              _ = log "order json" order
            in
              ({model | order = empty_order},postOrder order)

-- Subscriptions

subscriptions : Sub Msg
subscriptions =
    Sub.batch [ Sub.map UpdateSlideshow Slideshow.subscriptions ]

-- Http

postOrder : Encode.Value -> Cmd Msg
postOrder order =
  let
    url = "http://192.241.135.152:5000/orders"
  in
      Http.send PostResponse <|
          Http.post url (Http.jsonBody order) Decode.string
