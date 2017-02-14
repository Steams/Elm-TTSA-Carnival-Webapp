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
        , input [type_ "email", placeholder "email@domain.com", onInput EmailInput] []
        , label [] [text "Additional Info"]
        , textarea [class "add_info", onInput AdditionalInput , placeholder "Choice of tank or t shirt etc.."] []
        , label [ class "wrapped" ] [text "Size"]
        , select [ class "wrapped", onInput SizeInput ]
            [
              option [value "Small"] [text "Sml"]
             ,option [value "Medium"] [text "Med"]
             ,option [value "Large"] [text "Lrg"]
            ]
        , label [ class "wrapped" ] [text "Color"]
        , select [ class "wrapped", onInput ColorInput ]
            [
              option [value "White"] [text "White"]
             ,option [value "Black"] [text "Black"]
            ]
        ]


package_details : Bool -> String -> String -> Html Msg -> Html Msg
package_details showForm name cost desc=
    if showForm then
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
               button [ class "register_cancel", onClick Cancel ] [ text "Cancel" ]
              ,button [ class "register_submit", onClick Submit ] [ text "Submit" ]
              ]
          ]
    else
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
          ,div [ class "package_footer" ]
              [
              button [ class "register_button", onClick Register ] [ text "Register" ]
              ]
          ]

prompter : Model -> Html Msg
prompter model =
    let
        pkg = get model.active_package model.packages
    in
        case pkg of
            Just package ->
                div [ class "prompter"]
                    [
                      left_button
                    , right_button
                    , package_details model.showForm package.title package.cost package.description
                    ]
            Nothing -> div [] []

view : Model -> Html Msg
view model =
    div [ class "showcase" ]
        [
         Html.map UpdateSlideshow <| slideshow model.slideshow
        ,prompter model
        ]
