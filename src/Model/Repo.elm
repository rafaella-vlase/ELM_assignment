module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import List exposing (sortWith)
import Json.Decode as De


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }


view : Repo -> Html msg
view repo =
    div [class "repo"]
        [ p [class "repo-name"] [text repo.name]
        , p [class "repo-description"] (maybeToList (Maybe.map text repo.description))
        , p [class "repo-url"] [a [href repo.url] [text repo.url]]
        , p [class "repo-stars"] [text <| String.fromInt repo.stars]
        ]

maybeToList : Maybe a -> List a
maybeToList maybeValue =
    case maybeValue of
        Just value ->
            [value]

        Nothing ->
            []


sortByStars : List Repo -> List Repo
sortByStars =
    sortWith (\repo1 repo2 -> compare repo2.stars repo1.stars)


{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : De.Decoder Repo
decodeRepo =
    De.map5 Repo
        (De.field "name" De.string)
        (De.field "description" (De.maybe De.string))
        (De.field "html_url" De.string)
        (De.field "pushed_at" De.string)
        (De.field "stargazers_count" De.int)


decodeRepoMakeList : De.Decoder (List Repo)
decodeRepoMakeList =
    De.list decodeRepo
