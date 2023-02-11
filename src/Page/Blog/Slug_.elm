module Page.Blog.Slug_ exposing (Data, Model, Msg, page)

import Data.BlogPost as BlogPost exposing (BlogPost)
import DataSource exposing (DataSource)
import Element
import Head
import Head.Seo as Seo
import Markdown
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    { slug : String }


page : Page RouteParams Data
page =
    Page.prerender
        { head = head
        , routes = routes
        , data = data
        }
        |> Page.buildNoState { view = view }


routes : DataSource (List RouteParams)
routes =
    BlogPost.all
        |> DataSource.map (List.map (\post -> { slug = post.slug }))


data : RouteParams -> DataSource Data
data routeParams =
    BlogPost.all
        |> DataSource.map (List.filter (\post -> post.slug == routeParams.slug) >> List.head)


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


type alias Data =
    Maybe BlogPost


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    let
        post : BlogPost
        post =
            Maybe.withDefault
                { title = "Whoops!"
                , body = "Whoops! Something went wrong."
                , slug = "woops"
                }
                static.data
    in
    { title = post.title
    , body = [ Element.paragraph [] [ Markdown.toUi post.body ] ]
    }
