module Main exposing (..)

import Html exposing (Html, button, div, text, program, ul, li)
import Html.Attributes exposing (class)
import Landing
import Header

-- MESSAGES

type AppMsg
    = LandingMsg Landing.Msg
    | HeaderMsg Header.Msg

-- MODEL

type alias AppModel
    = {
        landingModel : Landing.Model
      , header : Header.Model
      }

-- Init

initialModel : AppModel
initialModel =
    {
      landingModel = Landing.initialModel
    , header = Header.initialModel
    }

init : ( AppModel, Cmd AppMsg )
init =
    ( initialModel, Cmd.none )


-- UPDATE

update : AppMsg -> AppModel -> ( AppModel, Cmd AppMsg )
update msg model =
    case msg of
        LandingMsg sub ->
            let
                ( updatedLandingModel, landingCmd ) =
                    Landing.update sub model.landingModel
            in
                ( {model | landingModel = updatedLandingModel},
                Cmd.map LandingMsg landingCmd)
        HeaderMsg sub ->
            let
                ( headerModel, headerCmd ) =
                    Header.update sub model.header
            in
                ( {model | header = headerModel}
                , Cmd.map HeaderMsg headerCmd)


-- SUBSCRIPTIONS

subscriptions : AppModel -> Sub AppMsg
subscriptions model =
    Sub.batch
        [
         Sub.map HeaderMsg (Header.subscriptions)
        ,Sub.map LandingMsg (Landing.subscriptions)
        ]

-- View

view : AppModel -> Html AppMsg
view model =
    div [class "main_container"]
        [
          Html.map HeaderMsg (Header.view model.header)
        , Html.map LandingMsg (Landing.view model.landingModel)
        ]

-- Main

main : Program Never AppModel AppMsg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
