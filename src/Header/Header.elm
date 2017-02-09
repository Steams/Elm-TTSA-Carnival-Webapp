module Header exposing (..)

import Html exposing (Html)

import Header.Types as Types exposing (..)
import Header.State as State exposing (..)
import Header.View as View exposing (..)

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
