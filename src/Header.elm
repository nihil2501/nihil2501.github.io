module Header exposing (view)

import Element exposing (Attribute, Element)
import Element.Font
import Path
import Route exposing (Route)


view : Maybe Route -> Element msg
view currentMaybeRoute =
    let
        currentRoute =
            Maybe.withDefault Route.Index currentMaybeRoute
    in
    -- Can't figure out if there is a way to automatically get top level page
    -- paths. This seems to suggest it's not a thing:
    -- https://github.com/dillonkearns/elm-pages/blob/master/examples/docs/src/View/Header.elm#L74-L84
    -- Also, when importing an internal module `TemplateModulesBeta` that has a
    -- value that might have worked called `getStaticRoutes`, I think I saw a
    -- complaint about cyclic dependency.
    Element.row []
        [ headerLink currentRoute Route.Index "Home"
        , headerLink currentRoute Route.Projects "Projects"
        , headerLink currentRoute Route.Blog "Blog"
        , headerLink currentRoute Route.Resume "Resume"
        ]


headerLink : Route -> Route -> String -> Element msg
headerLink currentRoute route name =
    let
        attrs : List (Attribute msg)
        attrs =
            case ( currentRoute, route ) of
                ( Route.Blog__Slug_ {}, Route.Blog ) ->
                    [ Element.Font.underline ]

                _ ->
                    if currentRoute == route then
                        [ Element.Font.underline ]

                    else
                        []

        label : Element msg
        label =
            Element.el attrs (Element.text name)
    in
    Element.link [] { url = Path.toAbsolute (Route.toPath route), label = label }
