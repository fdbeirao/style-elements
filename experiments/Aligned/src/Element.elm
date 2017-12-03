module Element
    exposing
        ( column
        , download
        , downloadAs
        , el
        , empty
        , fill
        , layout
        , layoutMode
        , link
        , newTabLink
        , paragraph
        , px
        , row
        , shrink
        , text
        , textPage
        , when
        , whenJust
        )

{-| -}

import Color
import Element.Attributes as Attributes
import Element.Color as Color
import Element.Events as Events
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes
import Internal.Model as Internal exposing (..)
import Internal.Style
import Json.Encode as Json
import VirtualDom


{-| -}
px : Float -> Length
px =
    Px


{-| -}
shrink : Length
shrink =
    Content


{-| -}
fill : Length
fill =
    Fill 1


{-| -}
layoutMode : RenderMode -> List (Attribute msg) -> Element msg -> Html msg
layoutMode mode attrs child =
    renderRoot mode
        (Color.background Color.blue
            :: Color.text Color.white
            :: Font.size 20
            :: Font.family
                [ Font.typeface "Open Sans"
                , Font.typeface "georgia"
                , Font.serif
                ]
            :: htmlClass "style-elements se el"
            :: attrs
        )
        child


layout : List (Attribute msg) -> Element msg -> Html msg
layout attrs child =
    renderRoot Layout
        (Color.background Color.blue
            :: Color.text Color.white
            :: Font.size 20
            :: Font.family
                [ Font.typeface "Open Sans"
                , Font.typeface "georgia"
                , Font.serif
                ]
            :: htmlClass "style-elements se el"
            :: attrs
        )
        child


{-| A helper function. This:

    when (x == 5) (text "yay, it's 5")

is sugar for

    if (x == 5) then
        text "yay, it's 5"
    else
        empty

-}
when : Bool -> Element msg -> Element msg
when bool elm =
    if bool then
        elm
    else
        empty


{-| Another helper function that defaults to `empty`

    whenJust (Just ("Hi!")) text

is sugar for

    case maybe of
        Nothing ->
            empty

        Just x ->
            text x

-}
whenJust : Maybe a -> (a -> Element msg) -> Element msg
whenJust maybe view =
    case maybe of
        Nothing ->
            empty

        Just thing ->
            view thing


{-| -}
empty : Element msg
empty =
    Internal.unstyled <| VirtualDom.text ""


{-| -}
text : String -> Element msg
text content =
    Internal.unstyled <|
        VirtualDom.node "div"
            [ VirtualDom.property "className" (Json.string "se text width-fill") ]
            [ VirtualDom.text content ]


{-| -}
el : List (Attribute msg) -> Element msg -> Element msg
el attrs child =
    element Internal.asEl
        Nothing
        (htmlClass "se el"
            :: Attributes.width shrink
            :: Attributes.height shrink
            :: Attributes.centerY
            :: Attributes.center
            :: attrs
        )
        [ child ]


{-| -}
row : List (Attribute msg) -> List (Element msg) -> Element msg
row attrs children =
    element Internal.asRow
        Nothing
        (htmlClass "se row"
            :: Class "y-content-align" "content-top"
            :: Class "x-content-align" "content-center-x"
            -- :: Attributes.spacing 20
            :: Attributes.width fill
            :: attrs
        )
        (unstyled
            (VirtualDom.node "alignLeft"
                [ Html.Attributes.class "se container align-container-left spacer" ]
                []
            )
            :: children
            ++ [ unstyled
                    (VirtualDom.node "alignRight"
                        [ Html.Attributes.class "se container align-container-right spacer" ]
                        []
                    )
               ]
        )


{-| -}
column : List (Attribute msg) -> List (Element msg) -> Element msg
column attrs children =
    element Internal.asColumn
        Nothing
        (htmlClass "se column"
            -- :: Attributes.spacing 20
            :: Class "y-content-align" "content-top"
            :: Attributes.height fill
            :: Attributes.width fill
            :: attrs
        )
        children


{-| TODO: element as 'p' if possible
-}
paragraph : List (Attribute msg) -> List (Element msg) -> Element msg
paragraph attrs children =
    element Internal.asEl (Just "p") (htmlClass "se paragraph" :: Attributes.width fill :: attrs) children


{-| -}
textPage : List (Attribute msg) -> List (Element msg) -> Element msg
textPage attrs children =
    element Internal.asEl Nothing (htmlClass "se page" :: Attributes.width (px 650) :: attrs) children


{-| For images, both a source and a description are required. The description will serve as the alt-text.
-}
image : List (Attribute msg) -> { src : String, description : String } -> Element msg
image attrs { src, description } =
    element Internal.asEl
        Nothing
        attrs
        [ Internal.unstyled <|
            VirtualDom.node "img"
                [ Html.Attributes.src src
                , Html.Attributes.alt description
                ]
                []
        ]


{-| If an image is purely decorative, you can skip the caption.
-}
decorativeImage : List (Attribute msg) -> { src : String } -> Element msg
decorativeImage attrs { src } =
    element Internal.asEl
        Nothing
        attrs
        [ Internal.unstyled <|
            VirtualDom.node "img"
                [ Html.Attributes.src src
                , Html.Attributes.alt ""
                ]
                []
        ]


{-|

    link "google.com" []
        (text "My link to Google")

    link []
        { url = "google.com"
        , label = text "My Link to Google"
        }

-}
link : List (Attribute msg) -> { url : String, label : Element msg } -> Element msg
link attrs { url, label } =
    element Internal.asEl
        (Just "a")
        (htmlClass "se el"
            :: Attr (Html.Attributes.href url)
            :: Attr (Html.Attributes.rel "noopener noreferrer")
            :: Attributes.width shrink
            :: Attributes.height shrink
            :: Attributes.centerY
            :: Attributes.center
            :: attrs
        )
        [ label ]


{-| -}
newTabLink : List (Attribute msg) -> { url : String, label : Element msg } -> Element msg
newTabLink attrs { url, label } =
    element Internal.asEl
        (Just "a")
        (htmlClass "se el"
            :: Attr (Html.Attributes.href url)
            :: Attr (Html.Attributes.rel "noopener noreferrer")
            :: Attr (Html.Attributes.target "_blank")
            :: Attributes.width shrink
            :: Attributes.height shrink
            :: Attributes.centerY
            :: Attributes.center
            :: attrs
        )
        [ label ]


{-|

    download []
        { url = "mydownload.pdf"
        , label = text "Download this"
        }

-}
download : List (Attribute msg) -> { url : String, label : Element msg } -> Element msg
download attrs { url, label } =
    element Internal.asEl
        (Just "a")
        (htmlClass "se el"
            :: Attr (Html.Attributes.href url)
            :: Attr (Html.Attributes.download True)
            :: Attributes.width shrink
            :: Attributes.height shrink
            :: Attributes.centerY
            :: Attributes.center
            :: attrs
        )
        [ label ]


{-|

     downloadAs []
        { url = "mydownload.pdf"
        , filename "your-thing.pdf"
        , label = text "Download this"
        }

-}
downloadAs : List (Attribute msg) -> { label : Element msg, filename : String, url : String } -> Element msg
downloadAs attrs { url, filename, label } =
    element Internal.asEl
        (Just "a")
        (htmlClass "se el"
            :: Attr (Html.Attributes.href url)
            :: Attr (Html.Attributes.downloadAs filename)
            :: Attributes.width shrink
            :: Attributes.height shrink
            :: Attributes.centerY
            :: Attributes.center
            :: attrs
        )
        [ label ]
