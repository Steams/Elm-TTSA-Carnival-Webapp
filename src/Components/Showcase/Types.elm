module Showcase.Types exposing (..)

import Html exposing (Html)
import Array exposing (Array)
import Slideshow
import Slideshow.Types exposing (..)
import Http
import Json.Encode
import Json.Decode.Extra exposing ((|:))
import Json.Decode

-- Messages

type Msg
    = NextPackage
    | PrevPackage
    | UpdateSlideshow Slideshow.Msg
    | NameInput String
    | EmailInput String
    | AdditionalInput String
    | GenderInput String
    | ColorInput String
    | SizeInput String
    | Submit
    | PostResponse (Result Http.Error String)

-- Types

type alias Package =
    {
          title : String
        , cost : String
        , description : Html Msg
        , slides : Array Slide
    }


-- Model
type alias Form =
    {
      name : String
    , email : String
    , additional : String
    , gender : String
    , size : String
    , color : String
    }

type alias Model =
    {
         packages : Array Package
       , active_package : Int
       , slideshow : Slideshow.Model
       , info : Form
    }

-- type alias Something =
--     { meta : Something_meta
--     , links : Something_links
--     , items : List Order
--     }

-- type alias Something_meta =
--     { page : Int
--     , total : Int
--     , max_results : Int
--     }

-- type alias Something_linksSelf =
--     { href : String
--     , title : String
--     }

-- type alias Something_linksParent =
--     { href : String
--     , title : String
--     }

-- type alias Something_links =
--     { self : Something_linksSelf
--     , parent : Something_linksParent
--     }

-- (:=) = (,)

-- decodeSomething : Json.Decode.Decoder Something
-- decodeSomething =
--     Json.Decode.succeed  Something
--         |: ("_meta" := decodeSomething_meta)
--         |: ("_links" := decodeSomething_links)
--         |: ("_items" := Json.Decode.list decodeOrder)

-- decodeSomething_meta : Json.Decode.Decoder Something_meta
-- decodeSomething_meta =
--     Json.Decode.succeed Something_meta
--         |: ("page" := Json.Decode.int)
--         |: ("total" := Json.Decode.int)
--         |: ("max_results" := Json.Decode.int)

-- decodeSomething_linksSelf : Json.Decode.Decoder Something_linksSelf
-- decodeSomething_linksSelf =
--     Json.Decode.succeed Something_linksSelf
--         |: ("href" := Json.Decode.string)
--         |: ("title" := Json.Decode.string)

-- decodeSomething_linksParent : Json.Decode.Decoder Something_linksParent
-- decodeSomething_linksParent =
--     Json.Decode.succeed Something_linksParent
--         |: ("href" := Json.Decode.string)
--         |: ("title" := Json.Decode.string)

-- decodeSomething_links : Json.Decode.Decoder Something_links
-- decodeSomething_links =
--     Json.Decode.succeed Something_links
--         |: ("self" := decodeSomething_linksSelf)
--         |: ("parent" := decodeSomething_linksParent)

-- encodeSomething : Something -> Json.Encode.Value
-- encodeSomething record =
--     Json.Encode.object
--         [ ("_meta",  encodeSomething_meta <| record.meta)
--         , ("_links",  encodeSomething_links <| record.links)
--         , ("_items",  Json.Encode.list <| List.map encodeOrder <| record.items)
--         ]

-- encodeSomething_meta : Something_meta -> Json.Encode.Value
-- encodeSomething_meta record =
--     Json.Encode.object
--         [ ("page",  Json.Encode.int <| record.page)
--         , ("total",  Json.Encode.int <| record.total)
--         , ("max_results",  Json.Encode.int <| record.max_results)
--         ]

-- encodeSomething_linksSelf : Something_linksSelf -> Json.Encode.Value
-- encodeSomething_linksSelf record =
--     Json.Encode.object
--         [ ("href",  Json.Encode.string <| record.href)
--         , ("title",  Json.Encode.string <| record.title)
--         ]

-- encodeSomething_linksParent : Something_linksParent -> Json.Encode.Value
-- encodeSomething_linksParent record =
--     Json.Encode.object
--         [ ("href",  Json.Encode.string <| record.href)
--         , ("title",  Json.Encode.string <| record.title)
--         ]

-- encodeSomething_links : Something_links -> Json.Encode.Value
-- encodeSomething_links record =
--     Json.Encode.object
--         [ ("self",  encodeSomething_linksSelf <| record.self)
--         , ("parent",  encodeSomething_linksParent <| record.parent)
--         ]
-- type alias Order =
--     { links : Order_links
--     , size : String
--     , created : String
--     , name : String
--     , id : String
--     , additional : String
--     , etag : String
--     , email : String
--     , updated : String
--     , color : String
--     , gender : String
--     }

-- type alias Order_linksSelf =
--     { href : String
--     , title : String
--     }

-- type alias Order_links =
--     { self : Order_linksSelf
--     }

-- decodeOrder : Json.Decode.Decoder Order
-- decodeOrder =
--     Json.Decode.succeed Order
--         |: ("_links" := decodeOrder_links)
--         |: ("size" := Json.Decode.string)
--         |: ("_created" := Json.Decode.string)
--         |: ("name" := Json.Decode.string)
--         |: ("_id" := Json.Decode.string)
--         |: ("additional" := Json.Decode.string)
--         |: ("_etag" := Json.Decode.string)
--         |: ("email" := Json.Decode.string)
--         |: ("_updated" := Json.Decode.string)
--         |: ("color" := Json.Decode.string)
--         |: ("gender" := Json.Decode.string)

-- decodeOrder_linksSelf : Json.Decode.Decoder Order_linksSelf
-- decodeOrder_linksSelf =
--     Json.Decode.succeed Order_linksSelf
--         |: ("href" := Json.Decode.string)
--         |: ("title" := Json.Decode.string)

-- decodeOrder_links : Json.Decode.Decoder Order_links
-- decodeOrder_links =
--     Json.Decode.succeed Order_links
--         |: ("self" := decodeOrder_linksSelf)

-- encodeOrder : Order -> Json.Encode.Value
-- encodeOrder record =
--     Json.Encode.object
--         [ ("_links",  encodeOrder_links <| record.links)
--         , ("size",  Json.Encode.string <| record.size)
--         , ("_created",  Json.Encode.string <| record.created)
--         , ("name",  Json.Encode.string <| record.name)
--         , ("_id",  Json.Encode.string <| record.id)
--         , ("additional",  Json.Encode.string <| record.additional)
--         , ("_etag",  Json.Encode.string <| record.etag)
--         , ("email",  Json.Encode.string <| record.email)
--         , ("_updated",  Json.Encode.string <| record.updated)
--         , ("color",  Json.Encode.string <| record.color)
--         , ("gender",  Json.Encode.string <| record.gender)
--         ]

-- encodeOrder_linksSelf : Order_linksSelf -> Json.Encode.Value
-- encodeOrder_linksSelf record =
--     Json.Encode.object
--         [ ("href",  Json.Encode.string <| record.href)
--         , ("title",  Json.Encode.string <| record.title)
--         ]

-- encodeOrder_links : Order_links -> Json.Encode.Value
-- encodeOrder_links record =
--     Json.Encode.object
--         [ ("self",  encodeOrder_linksSelf <| record.self)
--         ]
