module Landing.State exposing (..)

import Landing.Types exposing (..)

initialModel : Model
initialModel =
    { showRegistration = False }

-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleRegistration ->
            ( {model | showRegistration = False }, Cmd.none )



-- SUBSCRIPTIONS

-- subscriptions : Model -> Sub LocalMsg
-- subscriptions model =
--     Mouse.moves MouseMove
