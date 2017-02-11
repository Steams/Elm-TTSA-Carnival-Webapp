module Countdown exposing (..)
import Html exposing (Html)

import Countdown.Types as Types exposing (..)
import Countdown.State as State
import Countdown.View as View

-- Types

type alias Msg = Types.Msg
type alias Model = Types.Model

-- State

initialModel : Model
initialModel = State.initialModel

update : Msg -> (Model, Cmd Msg)
update = State.update

subscriptions : Sub Msg
subscriptions = State.subscriptions

-- View

view : Model -> Html Msg
view = View.view
