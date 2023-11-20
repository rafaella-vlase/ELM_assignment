module Model.PersonalDetails exposing (..)

import Html exposing (Html, div, h1, em, ul, li, a, text)
import Html.Attributes exposing (class, id, href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


view : PersonalDetails -> Html msg
view details =
    div []
        [ h1 [id "name"] [text details.name]
        , em [id "intro"] [text details.intro]
        , ul [] (List.map (renderContact "contact-detail") details.contacts)
        , ul [] (List.map (renderSocial "social-link") details.socials)
        ]


renderContact : String -> DetailWithName -> Html msg
renderContact className detail =
    li [class className] [text detail.detail]


renderSocial : String -> DetailWithName -> Html msg
renderSocial className detail =
    li [class className] [a [href detail.detail] [text detail.name]]
