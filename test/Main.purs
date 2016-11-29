module Test.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Undefinable (toUndefinable, toMaybe)

import Control.Monad.Eff.Console (logShow)

main = do
  logShow $ toUndefinable (Nothing :: Maybe Number)
  logShow $ toUndefinable (Just 42)

  logShow $ toMaybe $ toUndefinable (Nothing :: Maybe Number)
  logShow $ toMaybe $ toUndefinable (Just 42)

  logShow $ toUndefinable Nothing == toUndefinable (Just 42)
  logShow $ toUndefinable Nothing `compare` toUndefinable (Just 42)
