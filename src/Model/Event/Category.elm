module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    = AllSelected
    | NoneSelected
    | SomeSelected (List EventCategory)


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected =
    AllSelected
    --Debug.todo "Implement Model.Event.Category.allSelected"

{-| Returns an instance of `SelectedEventCategories` with no categories selected

-- isEventCategorySelected Academic noneSelected --> False

-}
noneSelected : SelectedEventCategories
noneSelected =
    NoneSelected
    --Debug.todo "Implement Model.Event.Category.noneSelected"

{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
    case current of
        AllSelected ->
            True

        NoneSelected ->
            False

        SomeSelected selectedCategories ->
            List.member category selectedCategories
    --Debug.todo "Implement Model.Event.Category.isEventCategorySelected"


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    case current of
        AllSelected ->
            if value then
                AllSelected
            else
                SomeSelected (List.filter (\cat -> cat /= category) eventCategories)

        NoneSelected ->
            if value then
                SomeSelected [category]
            else
                NoneSelected

        SomeSelected selectedCategories ->
            if value then
                if List.member category selectedCategories then
                    current
                else
                    SomeSelected (category :: selectedCategories)
            else
                SomeSelected (List.filter (\cat -> cat /= category) selectedCategories)
    --Debug.todo "Implement Model.Event.Category.set"


checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]


view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
    div []
        (List.map
            (\category ->
                checkbox (categoryToString category) (isEventCategorySelected category model) category
            )
            eventCategories
        )


categoryToString : EventCategory -> String
categoryToString category =
    case category of
        Academic ->
            "Academic"

        Work ->
            "Work"

        Project ->
            "Project"

        Award ->
            "Award"
    --Debug.todo "Implement the Model.Event.Category.view function"
