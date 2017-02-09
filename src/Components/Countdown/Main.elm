module Countdown.Main exposing (..)
import Html exposing (Html)

import Countdown.Data as Data exposing (..)
import Countdown.State as State
import Countdown.View as View

-- Types

type alias Msg = Data.Msg
type alias Model = Data.Model

-- State

init : Data.Model
init = State.init

update : Data.Msg -> (Data.Model, Cmd Data.Msg)
update = State.update

subscriptions : Sub Data.Msg
subscriptions = State.subscriptions

-- View

view : Model -> Html Data.Msg
view = View.view
