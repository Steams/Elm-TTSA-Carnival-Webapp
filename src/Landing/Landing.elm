module Landing exposing (..)

import Html exposing (Html)

import Landing.View as View
import Landing.Types as Types
import Landing.State as State

-- Types

type alias Model = Types.Model
type alias Msg = Types.Msg

-- State

initialModel : Model
initialModel = State.initialModel

update : Msg -> Model -> ( Model, Cmd Msg )
update = State.update

subscriptions : Sub Msg
subscriptions = State.subscriptions

-- View

view : Model -> Html Msg
view = View.view
