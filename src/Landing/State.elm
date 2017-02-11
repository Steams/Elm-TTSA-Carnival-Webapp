module Landing.State exposing (..)

import Landing.Types exposing (..)

import Showcase

initialModel : Model
initialModel =
    { showcaseModel = Showcase.initialModel  }

-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateShowcase subMsg ->
            let
                (new_model,showcaseCmd) = Showcase.update subMsg model.showcaseModel
            in
                ({model | showcaseModel = new_model }
                , Cmd.map UpdateShowcase showcaseCmd)



-- SUBSCRIPTIONS

subscriptions : Sub Msg
subscriptions =
    Sub.batch [ Sub.map UpdateShowcase Showcase.subscriptions ]
