module Slideshow exposing (..)

import Html exposing (Html)

import Slideshow.Types as Types exposing (..)
import Slideshow.State as State
import Slideshow.View as View

-- TODO add Dir to elm-package

-- Types

type alias Msg = Types.Msg
type alias Model = Types.Model

-- State

initialModel : Model
initialModel = State.init

update : Msg -> (Model, Cmd Msg)
update = State.update

subscriptions : Sub Msg
subscriptions = State.subscriptions

-- View

view : Model -> Html Msg
view = View.view
