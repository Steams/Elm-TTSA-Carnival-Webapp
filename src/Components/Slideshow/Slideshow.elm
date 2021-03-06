module Slideshow exposing (..)

import Html exposing (Html)

import Slideshow.Types as Types exposing (..)
import Slideshow.State as State
import Slideshow.View as View

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
