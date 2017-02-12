module Showcase.View exposing (..)

import Html exposing (Html, button, div, text, program, ul, li, img, span,input, label, textarea, select, option)
import Html.Attributes exposing (class, classList, src, height, width,type_, placeholder, value)
import Array exposing (get)
import Html.Events exposing (onClick,onInput)

import Slideshow

import Showcase.Types exposing (..)

left_button : Html Msg
left_button =
    div [ classList [("left_button",True)]]
        [
         button [ onClick PrevPackage ] [text "<"]
        ]

right_button : Html Msg
right_button =
    div [ classList [("right_button",True)]]
        [
         button [ onClick NextPackage ] [text ">"]
        ]

slideshow : Slideshow.Model -> Html Slideshow.Msg
slideshow = Slideshow.view

registration : Html Msg
registration =
    div [ class "registration" ]
        [
          label [] [text "Name"]
        , input [type_ "text", onInput NameInput ] []
        , label [] [text "Email"]
        , input [type_ "text", placeholder "email@domain.com", onInput EmailInput] []
        , label [] [text "Additional Info"]
        , textarea [class "add_info", onInput AdditionalInput ] []
        , label [ class "wrapped" ] [text "Sex"]
        , select [ class "wrapped", onInput GenderInput]
            [
              option [value "male"] [text "Male"]
             ,option [value "female"] [text "Female"]
            ]
        , label [ class "wrapped" ] [text "Size"]
        , select [ class "wrapped", onInput SizeInput ]
            [
              option [value "small"] [text "Sml"]
             ,option [value "medium"] [text "Med"]
             ,option [value "large"] [text "Lrg"]
            ]
        , label [ class "wrapped" ] [text "Color"]
        , select [ class "wrapped", onInput ColorInput ]
            [
              option [value "white"] [text "White"]
             ,option [value "black"] [text "Black"]
            ]
        ]


package_details : String -> String -> Html Msg -> Html Msg
package_details name cost desc=
    div [ class "package_details" ]
        [
         div [ class "package_header" ]
             [
              div [ class "package_title" ] [text name]
             ,div [ class "package_price" ] [text cost]
             ]
        ,div [ class "package_body" ]
            [
             div [class "package_description" ]
                 [
                  desc
                 ]
            ]
        , registration
        ,div [ class "package_footer" ]
            [
             button [ class "register_button", onClick Submit ] [ text "Register" ]
            ]
        ]

prompter : Maybe Package -> Html Msg
prompter m =
    case m of
        Just package ->
            div [ class "prompter"]
                [
                   left_button
                 , right_button
                 , package_details package.title package.cost package.description
                ]
        Nothing -> div [] []

view : Model -> Html Msg
view model =
    div [ class "showcase" ]
        [
         Html.map UpdateSlideshow <| slideshow model.slideshow
        ,prompter <| get model.active_package model.packages
        ]
