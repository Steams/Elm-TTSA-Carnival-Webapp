module Header.State exposing (..)

import Header.Types exposing (..)

import Countdown

-- Init

initialModel : Model
initialModel = Model Countdown.initialModel

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update updateCounter ->
            let
                (new_model, updateMsg) = Countdown.update updateCounter
            in
                ({model | countdown = new_model}
                , Cmd.map Update updateMsg)

-- SUBSCRIPTIONS
subscriptions : Sub Msg
subscriptions =
    Sub.batch [Sub.map Update Countdown.subscriptions]
