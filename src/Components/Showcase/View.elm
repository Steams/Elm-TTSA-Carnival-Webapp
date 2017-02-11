module Showcase.View exposing (..)

import Html exposing (Html, button, div, text, program, ul, li, img, span,input, label)
import Html.Attributes exposing (class, classList, src, height, width,type_, placeholder)
import Array exposing (get)
import Html.Events exposing (onClick)

import Slideshow

import Showcase.Types exposing (..)

left_button : Html Msg
left_button =
    div [ classList [("slideshow_button",True)]]
        [
         button [ onClick PrevPackage ] [text "<"]
        ]

right_button : Html Msg
right_button =
    div [ classList [("slideshow_button",True)]]
        [
         button [ onClick NextPackage ] [text ">"]
        ]

slideshow : Slideshow.Model -> Html Slideshow.Msg
slideshow = Slideshow.view

package_details : String -> String -> Html Msg
package_details name desc=
    div [ class "package_details" ]
        [
         div [ class "package_header" ]
             [
              div [ class "package_title" ] [text name]
             ,div [ class "package_price" ] [text "$2000"]
             ]
        ,div [ class "package_body" ]
            [
             div [class "package_description" ]
                 [
                  text desc
                 ]
            ]
        ,div [ class "package_footer" ]
            [
             button [ class "register_button" ] [ text "Register" ]
            ]
        ]

registration : Html Msg
registration =
    div [ class "registration" ]
        [
          label [] [text "Name"]
        , input [type_ "text", placeholder "Name"] []
        ]

prompter : Maybe Package -> Html Msg
prompter m =
    case m of
        Just package ->
            div [ class "prompter"]
                [
                  package_details package.title package.description
                -- , registration
                ]
        Nothing -> div [] []

view : Model -> Html Msg
view model =
    div [ class "showcase" ]
        [
         left_button
        ,Html.map UpdateSlideshow <| slideshow <| model.slideshow
        ,prompter <| get model.active_package model.packages
        ,right_button
        ]
