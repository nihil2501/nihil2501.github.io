module Data.BlogPost exposing (BlogPost, all)


type alias BlogPost =
    { slug : String
    , title : String
    }


all : List BlogPost
all =
    [ { slug = "foo", title = "Foo" }
    , { slug = "bar", title = "Bar" }
    ]
