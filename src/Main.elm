module Main exposing (..)

import Color exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input


main =
    Element.layout
        [ Background.color white
        , width (px 900)
        , paddingLeft gutter
        ]
    <|
        column
            []
            [ headerArea
            , mainColumns
                { left =
                    [ paragraph
                        [ paddingLeft 20 ]
                        [ text "All People:" ]
                    , paragraph
                        [ paddingLeft 40
                        , height (px 180)
                        , Background.color lightGrey
                        ]
                        (List.map viewPeople model.people)
                    ]
                , right =
                    [ inputForm
                    , paragraph
                        [ paddingTop 20
                        ]
                        [ text "Filtered Results:" ]
                    , paragraph
                        [ paddingLeft 18
                        , Background.color lightGrey
                        ]
                        (List.map viewPeople model.filtered)
                    ]
                }
            , footerArea
            ]


type alias Model =
    { people : List String
    , filtered : List String
    , filter : String
    }


model : Model
model =
    { people = [ "Alice", "Anne", "Jane", "Joan", "Joanne", "Zane", "Zoe" ]
    , filtered = [ "Anne", "Jane", "Joanne", "Zane" ]
    , filter = "ne"
    }



-- UPDATE


type Msg
    = Filter String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Filter filter ->
            { model
                | filtered = List.filter (String.contains filter) model.people
                , filter = filter
            }


mainColumns { left, right } =
    row
        [ borderBottom 1
        , Border.color darkBlue
        ]
        [ column
            [ borderRight 1
            , Border.color darkBlue
            , paddingRight gutter
            ]
            left
        , column
            [ paddingLeft gutter ]
            right
        ]


inputForm : Element Msg
inputForm =
    Input.text
        [ Border.color Color.black ]
        { onChange = Just Filter
        , text = "ne"
        , placeholder = Nothing
        , label = Input.labelAbove [] (text "Filter People:")
        , notice = Nothing
        }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Atom.elm -}


gutter =
    20



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


borderRight n =
    Border.widthEach { right = n, left = 0, top = 0, bottom = 0 }


borderBottom n =
    Border.widthEach { right = 0, left = 0, top = 0, bottom = n }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingRight n =
    paddingEach { right = n, left = 0, top = 0, bottom = 0 }


paddingTop n =
    paddingEach { bottom = 0, top = n, left = 0, right = 0 }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingBottom n =
    paddingEach { bottom = n, top = 0, left = 0, right = 0 }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingLeft n =
    paddingEach { right = 0, left = n, top = 0, bottom = 0 }


headerArea =
    row
        [ Background.color white
        , Font.color darkBlue
        , borderBottom 1
        , Border.color darkBlue
        ]
        [ elmlogo
        , newTabLink
            [ padding gutter
            , Font.bold
            , Font.size 18
            , Font.underline
            , alignBottom
            ]
            { url = "http://package.elm-lang.org/packages/mdgriffith/stylish-elephants/3.0.2"
            , label = Element.text "stylish-elephants: package docs"
            }
        ]


elmlogo =
    row []
        [ image
            [ width (px 180)
            , height (px 70)
            , alignLeft
            ]
            { description = "the Elm Language logo", src = "elm_logo.png" }
        ]


viewPeople entry =
    paragraph []
        [ Element.text entry ]


footerArea =
    row
        [ Font.color darkBlue
        , paddingTop 20
        ]
        [ newTabLink
            [ Font.bold
            , Font.underline
            , Font.size 16
            , centerY
            ]
            { url = "https://github.com/jbrgfx"
            , label = Element.text "jbrgfx's github repos."
            }
        ]
