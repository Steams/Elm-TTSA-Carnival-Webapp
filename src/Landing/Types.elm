module Landing.Types exposing (..)

import Showcase

-- MESSAGES
type Msg
    = UpdateShowcase Showcase.Msg

-- MODEL

type alias Model = { showcaseModel : Showcase.Model }
