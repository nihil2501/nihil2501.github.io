module Header exposing (view)

import Element exposing (Attribute, Element)
import Element.Font
import Path exposing (Path)


view : Path -> Element msg
view currentPath =
    -- Can't figure out if there is a way to automatically get top level page
    -- paths. This seems to suggest it's not a thing:
    -- https://github.com/dillonkearns/elm-pages/blob/master/examples/docs/src/View/Header.elm#L74-L84
    -- Also, when importing an internal module `TemplateModulesBeta` that has a
    -- value that might have worked called `getStaticRoutes`, I think I saw a
    -- complaint about cyclic dependency.
    Element.row []
        [ headerLink currentPath "" "Home"
        , headerLink currentPath "projects" "Projects"
        , headerLink currentPath "blog" "Blog"
        , headerLink currentPath "resume" "Resume"
        ]


headerLink : Path -> String -> String -> Element msg
headerLink currentPath linkTo name =
    let
        isCurrentPath : Bool
        isCurrentPath =
            linkTo
                == Maybe.withDefault ""
                    (List.head (Path.toSegments currentPath))

        attrs : List (Attribute msg)
        attrs =
            if isCurrentPath then
                [ Element.Font.underline ]

            else
                []

        label : Element msg
        label =
            Element.el attrs (Element.text name)
    in
    Element.link [] { url = "/" ++ linkTo, label = label }
