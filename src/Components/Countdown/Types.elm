module Countdown.Types exposing (..)

import Time exposing (..)
import Date exposing (..)

-- Messages

type Msg = UpdateCounter Time

-- Types

type alias Days = Int
type alias Hours = Int
type alias Minutes = Int
type alias Seconds = Int

type alias Now = Time
type alias Target = Time
type alias TimeRemaining = Int


-- Model

carnival_date : Time
carnival_date
    = case (Date.fromString "2017/03/16") of
          Ok date ->
              Date.toTime date
          Err err ->
              0

type alias Model =
    {
        days : Int
        , hours : Int
        , minutes : Int
        , seconds : Int
    }


