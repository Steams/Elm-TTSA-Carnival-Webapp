module Landing.View exposing (view)

import Html exposing (Html, button, div, text, program, ul, li, img)
import Html.Attributes exposing (class, classList, src, height, width)

import Landing.Types exposing (..)

-- VIEW
left_button : Html Msg
left_button =
    div [ classList [("slideshow_button",True)]]
        [
         button [] [text "<"]
        ]
image_panel : Html Msg
image_panel =
    div [class "image_panel"]
        [img [src "./136.jpg", height 330, width 600] []]

right_button : Html Msg
right_button =
    div [ classList [("slideshow_button",True)]]
        [
         button [] [text ">"]
        ]

slideshow_container : Html Msg
slideshow_container =
    div [ class "slideshow_container" ]
        [
         left_button,
         image_panel,
         right_button
        ]

slideshow_description_container : Html Msg
slideshow_description_container =
    div [ class "slideshow_description_container"]
        [
         div [class "description_title"] [text "HEY IM TITLE TEXT YEAH!"],
         div [class "description_body"] [text "Im a paragraph of smaller subtext explaining things that need to be explained and such and so on and soforth and im sure sofroth might not be a word but i typed it anyways #yolo swag you only yolo once hahahaha please kill yourself"],
         div [class "description_button"] [button [] [text "action"]]
        ]

info : Html Msg
info =
    div [ class "info_container "]
    [
     div [class "info_title"] [text "Some Info"],
     div [class "info_body"] [text "More text in a ox god yes i love text in boxes with 4 sides that are more or less of equal length, rick and morty season 3 when ??? More text in a ox god yes i love text in boxes with 4 sides that are more or less of equal length, rick and morty season 3 when ???More text in a ox god yes i love text in boxes with 4 sides that are more or less of equal length, rick and morty season 3 when ???"]
    ]

left : Html Msg
left =
    div [ class "landing_left"]
        [
         slideshow_container,
         slideshow_description_container
        ]

right : Model -> Html Msg
right model =
    if not model.showRegistration then
    div [ class "landing_right"]
        [
         info
        ]
    else div [ class "landing_right" ]
        [
         text "registration form"
        ]


view : Model -> Html Msg
view model =
    div [ class "landing_container" ]
        [
         left,
         right model
        ]
