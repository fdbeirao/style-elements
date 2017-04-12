module Style.Background exposing (..)

{-| -}

import Style.Internal.Model as Internal
import Style.Internal.Render.Value as Render
import Color exposing (Color)
import Style exposing (Background, Repeat, GradientStep, GradientDirection)


{-| -}
color : Color -> Background
color bgColor =
    Internal.BackgroundElement "background-color" (Render.color bgColor)


step : Color -> GradientStep
step =
    Internal.ColorStep


percent : Color -> Float -> GradientStep
percent =
    Internal.PercentStep


px : Color -> Float -> GradientStep
px =
    Internal.PxStep


toUp : GradientDirection
toUp =
    Internal.ToUp


toDown : GradientDirection
toDown =
    Internal.ToDown


toRight : GradientDirection
toRight =
    Internal.ToRight


toTopRight : GradientDirection
toTopRight =
    Internal.ToTopRight


toBottomRight : GradientDirection
toBottomRight =
    Internal.ToBottomRight


toLeft : GradientDirection
toLeft =
    Internal.ToLeft


toTopLeft : GradientDirection
toTopLeft =
    Internal.ToTopLeft


toBottomLeft : GradientDirection
toBottomLeft =
    Internal.ToBottomLeft


{-| Gradient angle given in radians.
-}
toAngle : Float -> GradientDirection
toAngle =
    Internal.ToAngle


{-|
lnear gradient


linear-gradient(red, orange);


 background-image:
    linear-gradient(
      to right,
      red, #f06d06
    );


 linear-gradient(
      to top right,
      red, #f06d06
    );

background-image:
    linear-gradient(
      45deg,
      red, #f06d06
    );

-- With Stops
linear-gradient(
      to right,
      red,
      #f06d06,
      rgb(255, 255, 0),
      green
    );

-}
gradient : GradientDirection -> List GradientStep -> Background
gradient dir steps =
    Internal.BackgroundLinearGradient dir steps


{-| -}
image : String -> Background
image src =
    Internal.BackgroundImage
        { src = src
        , position = ( 0, 0 )
        , repeat = noRepeat
        }


{-| -}
imageWith :
    { src : String
    , position : ( Float, Float )
    , repeat : Repeat
    }
    -> Background
imageWith =
    Internal.BackgroundImage


{-| -}
repeatX : Repeat
repeatX =
    Internal.RepeatX


{-| -}
repeatY : Repeat
repeatY =
    Internal.RepeatY


{-| -}
repeat : Repeat
repeat =
    Internal.Repeat


{-| -}
space : Repeat
space =
    Internal.Space


{-| -}
round : Repeat
round =
    Internal.Round


{-| -}
noRepeat : Repeat
noRepeat =
    Internal.NoRepeat