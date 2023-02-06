module Page.Blog exposing (Data, Model, Msg, page)

import Data.BlogPost as BlogPost exposing (BlogPost)
import DataSource exposing (DataSource)
import Element exposing (Element)
import Head
import Head.Seo as Seo
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Path
import Route exposing (Route)
import Shared
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    {}


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


type alias Data =
    List BlogPost


data : DataSource Data
data =
    DataSource.succeed BlogPost.all


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    let
        body : List (Element msg)
        body =
            List.map
                (\post ->
                    Element.link []
                        { label = Element.text post.title
                        , url = Path.toAbsolute (Route.toPath (Route.Blog__Slug_ { slug = post.slug }))
                        }
                )
                static.data
    in
    { body = body, title = "Blog" }
