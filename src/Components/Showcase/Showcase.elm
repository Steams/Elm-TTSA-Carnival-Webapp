module Showcase exposing (..)

import Html exposing (Html)

import Showcase.Types as Types exposing (..)
import Showcase.State as State
import Showcase.View as View

-- Types

type alias Msg = Types.Msg
type alias Model = Types.Model

-- State

initialModel : Model
initialModel = State.initialModel

update : Msg -> Model -> (Model, Cmd Msg)
update = State.update

subscriptions : Sub Msg
subscriptions = State.subscriptions

-- View

view : Model -> Html Msg
view = View.view
