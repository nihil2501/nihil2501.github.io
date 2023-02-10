module Data.BlogPost exposing (BlogPost, all)

import DataSource exposing (DataSource)
import DataSource.Port
import Json.Encode
import OptimizedDecoder as Decode


type alias BlogPost =
    { slug : String
    , title : String
    , body : String
    }


all : DataSource (List BlogPost)
all =
    DataSource.Port.get "getBlogPosts"
        Json.Encode.null
        (Decode.list
            (Decode.map3 BlogPost
                (Decode.field "slug" Decode.string)
                (Decode.field "title" Decode.string)
                (Decode.field "body" Decode.string)
            )
        )
