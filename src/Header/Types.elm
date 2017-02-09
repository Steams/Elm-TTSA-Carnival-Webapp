module Header.Types exposing (..)

import Countdown

-- Types

type alias Model = { countdown : Countdown.Model }

type Msg = Update Countdown.Msg
