module Model.Event exposing (..)

import Html exposing (Html, div, h2, p, a, text)
import Html.Attributes exposing (class, classList, href)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval, compare)

type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


compareEvents : Event -> Event -> Order
compareEvents event1 event2 =
    Interval.compare event1.interval event2.interval

sortByInterval : List Event -> List Event
sortByInterval events =
    List.sortWith compareEvents events


view : Event -> Html Never
view event =
    let
        evtClasses =
            [ ("event", True)
            , ("event-important", event.important)
            ]

        descClasses =
            [ ("event-description", True) ]
    in
    div [classList evtClasses]
        [ h2 [class "event-title"] [text event.title]
        , p [class "event-category"] [categoryView event.category]
        , p [class "event-interval"] [Interval.view event.interval]
        , p [classList descClasses] [event.description]
        , case event.url of
            Just link ->
                a [class "event-url", href link] [text "Event Link"]

            Nothing ->
                text ""
        ]
