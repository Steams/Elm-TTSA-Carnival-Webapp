module Main exposing (..)

import Html exposing (Html, button, div, text, program, ul, li)
import Landing exposing (..)
import Header exposing (..)

-- MODEL

type alias AppModel
    = {
        landingModel : Landing.Model
      , header : Header.Model
      }

-- MESSAGES

type AppMsg
    = LandingMsg Landing.LocalMsg
    | HeaderMsg Header.Msg

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
        [ Sub.map HeaderMsg (Header.subscriptions)]

-- View


view : AppModel -> Html AppMsg
view model =
    div []
        [
          Html.map HeaderMsg (Header.view model.header)
        -- , Html.map LandingMsg (Landing.view model.landingModel)
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
