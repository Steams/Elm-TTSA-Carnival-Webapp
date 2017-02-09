module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Countdown.State as CounterState exposing (..)
import Time exposing (Time)
import Date exposing (Date)



all : Test
all =
    describe "Components Test Suite"
        [ describe "Countdown tests"
            [ test "Expect days to equal 1 when target is 1 day ahead of base" <|
                \() ->
                  let
                      base_date : Time
                      base_date = case (Date.fromString "2017/03/16") of
                                Ok date ->
                                    Date.toTime date
                                Err err ->
                                    0
                      target_date : Time
                      target_date = case (Date.fromString "2017/03/17") of
                                Ok date ->
                                    Date.toTime date
                                Err err ->
                                    0
                      result = CounterState.timeRemaining base_date target_date
                  in
                      Expect.equal result.days 1
            , test "Expect hours to equal 0 when target is 1 day ahead of base" <|
                \() ->
                  let
                      base_date : Time
                      base_date = case (Date.fromString "2017/03/16") of
                                Ok date ->
                                    Date.toTime date
                                Err err ->
                                    0
                      target_date : Time
                      target_date = case (Date.fromString "2017/03/17") of
                                Ok date ->
                                    Date.toTime date
                                Err err ->
                                    0
                      result = CounterState.timeRemaining base_date target_date
                  in
                      Expect.equal result.hours 0

            ]
        ]
