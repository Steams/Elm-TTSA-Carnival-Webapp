module Showcase.State exposing (..)

import Html exposing (Html,li,ul,p,text,div)
import Task exposing (Task, andThen, mapError, succeed, fail)
import Html.Attributes exposing (..)
import Array
import Http

import Slideshow
import Slideshow.Types exposing (Slide)

import Showcase.Types exposing (..)
import Debug exposing (log)
import Json.Encode exposing (..)
import Json.Decode exposing (..)


-- Init

-- set slideshow inital model to from the first package

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
         , p [] [text "Early bird offer valid until Friday 17 February"]
        ]

package_1 : Package
package_1 =
    {
      title = "Bikini"
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
       ,slideshow = Slideshow.Types.Model package_1.slides 0
       ,info =
            {
              name = ""
            , email = ""
            , additional = ""
            , gender = ""
            , size = "Sml"
            , color = "White"
            }
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
        Success ->
            (model,Cmd.none)
        Fail ->
            (model,Cmd.none)
        Post res->
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
                info = model.info
            in
                ({model | info = { info | name = value } },Cmd.none)
        EmailInput value ->
            let
                info = model.info
            in
                ({model | info = { info | email = value } },Cmd.none)
        AdditionalInput value ->
            let
                info = model.info
            in
                ({model | info = { info | additional = value } },Cmd.none)
        GenderInput value ->
            let
                info = model.info
            in
                ({model | info = { info | gender = value } },Cmd.none)
        ColorInput value ->
            let
                info = model.info
            in
                ({model | info = { info | color = value } },Cmd.none)
        SizeInput value ->
            let
                info = model.info
            in
                ({model | info = { info | size = value } },Cmd.none)
        Submit ->
            let
              _ = log "name" model.info.name
              _ = log "gender" model.info.gender
              _ = log "size" model.info.size
              form = object [
                    ("name", Json.Encode.string model.info.name)
                  , ("gender", Json.Encode.string model.info.gender)
                  , ("size", Json.Encode.string model.info.size)
                  , ("additional", Json.Encode.string model.info.additional)
                  , ("color", Json.Encode.string model.info.color)
                  , ("email", Json.Encode.string model.info.email)
                  ]
              form_json = encode 1 form
              _ = log "json" form_json
            in
              (model,postOrder form)
            -- clear model info here

-- Subscriptions
subscriptions : Sub Msg
subscriptions =
    Sub.batch [ Sub.map UpdateSlideshow Slideshow.subscriptions ]


orderDecoder : Json.Decode.Decoder Form
orderDecoder = Json.Decode.map6 Form
        (field "name" Json.Decode.string)
        (field "email" Json.Decode.string)
        (field "additional" Json.Decode.string)
        (field "color" Json.Decode.string)
        (field "size" Json.Decode.string)
        (field "gender" Json.Decode.string)

-- Http

postOrder : Json.Encode.Value -> Cmd Msg
postOrder form_json =
  let
    url = "http://localhost:8080/order"
  in
      Http.send Post (Http.post url (Http.jsonBody form_json) Json.Decode.string)

-- postJson : Json.Decode.Decoder value -> String -> Json.Encode.Value -> Platform.Task Http.Error value
-- postJson decoder url json =
--     let
--         body =
--             json
--                 -- encode json value into a String using 0 indent
--                 |> Json.Encode.encode 0
--                 -- convert String into an Http.Body
--                 |> Http.stringBody

--         request =
--             { verb = "POST"
--             , headers = [ ("Content-Type", "application/json") ]
--             , url = url
--             , body = body
--             }
--     in
--         request
--             |> Http.send { timeout = 0 , onStart = Nothing , onProgress = Nothing , desiredResponseType = Nothing , withCredentials = False}


-- fromJson : Json.Decoder a -> Task RawError Response -> Task Error a
-- fromJson decoder response =
--   let decode str =
--         case Json.decodeString decoder str of
--           Ok v -> succeed v
--           Err msg -> fail (UnexpectedPayload msg)
--   in
--       mapError promoteError response
--         andThen handleResponse decode
