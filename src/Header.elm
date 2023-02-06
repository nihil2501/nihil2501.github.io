module Header exposing (view)

import Element exposing (Attribute, Element)
import Element.Font
import Path
import Route exposing (Route)


view : List (Attribute msg) -> Maybe Route -> Element msg
view attrs currentMaybeRoute =
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
    Element.column
        (attrs
            ++ [ Element.Font.family
                    [ Element.Font.external
                        { name = "Nabla"
                        , url = "https://fonts.googleapis.com/css?family=Nabla"
                        }
                    ]
               ]
        )
        [ link currentRoute Route.Index "Home"
        , link currentRoute Route.Projects "Projects"
        , link currentRoute Route.Blog "Blog"
        , link currentRoute Route.Resume "Resume"
        ]


link : Route -> Route -> String -> Element msg
link currentRoute route name =
    let
        linkName : String
        linkName =
            case ( currentRoute, route ) of
                ( Route.Blog__Slug_ {}, Route.Blog ) ->
                    name ++ " *"

                _ ->
                    if currentRoute == route then
                        name ++ " *"

                    else
                        name

        label : Element msg
        label =
            Element.el [] (Element.text linkName)
    in
    Element.el
        [ Element.height (Element.px 40) ]
        (Element.link []
            { url = Path.toAbsolute (Route.toPath route)
            , label = label
            }
        )



-- link : Route -> Route -> String -> Element msg
-- link currentRoute route name =
--     let
--         attrs : List (Attribute msg)
--         attrs =
--             case ( currentRoute, route ) of
--                 ( Route.Blog__Slug_ {}, Route.Blog ) ->
--                     [ Element.Font.underline ]
--                 _ ->
--                     if currentRoute == route then
--                         [ Element.Font.underline ]
--                     else
--                         []
--         label : Element msg
--         label =
--             Element.el attrs (Element.text name)
--     in
--     Element.el
--         [ Element.width (Element.px 120)
--         , Element.height (Element.px 40)
--         ]
--         (Element.link []
--             { url = Path.toAbsolute (Route.toPath route)
--             , label = label
--             }
--         )
