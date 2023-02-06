module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import Browser.Navigation
import DataSource
import Element
import Element.Background
import Element.Font
import Header exposing (view)
import Html exposing (Html)
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Path exposing (Path)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Just OnPageChange
    }


type Msg
    = OnPageChange
        { path : Path
        , query : Maybe String
        , fragment : Maybe String
        }
    | SharedMsg SharedMsg


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    { showMobileMenu : Bool
    }


init :
    Maybe Browser.Navigation.Key
    -> Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : Path
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Cmd Msg )
init navigationKey flags maybePagePath =
    ( { showMobileMenu = False }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPageChange _ ->
            ( { model | showMobileMenu = False }, Cmd.none )

        SharedMsg globalMsg ->
            ( model, Cmd.none )


subscriptions : Path -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


view :
    Data
    ->
        { path : Path
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : Html msg, title : String }
view sharedData page model toMsg pageView =
    { body =
        Element.layout
            [ Element.Background.color (Element.rgb 0.15 0.15 0.15)
            , Element.Font.color (Element.rgb 0.8 0.8 0.8)
            , Element.paddingXY 40 40
            ]
            (Element.row
                [ Element.centerX
                , Element.width (Element.fill |> Element.maximum 800)
                ]
                [ Header.view
                    [ Element.alignTop
                    , Element.width (Element.px 160)
                    ]
                    page.route
                , Element.column
                    [ Element.width Element.fill
                    , Element.alignTop
                    , Element.Font.size 20
                    , Element.Font.family
                        [ Element.Font.external
                            { name = "Ubuntu"
                            , url = "https://fonts.googleapis.com/css?family=Ubuntu"
                            }
                        ]
                    ]
                    pageView.body
                ]
            )
    , title = pageView.title
    }
