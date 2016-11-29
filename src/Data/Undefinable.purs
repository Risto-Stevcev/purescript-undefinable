-- | This module defines types and functions for working with undefinable types
-- | using the FFI.

module Data.Undefinable
  ( Undefinable
  , toMaybe
  , toUndefinable
  ) where

import Prelude

import Data.Function (on)
import Data.Function.Uncurried (Fn3, runFn3)
import Data.Maybe (Maybe(..), maybe)

-- | An undefinable type.
-- |
-- | This type constructor may be useful when interoperating with JavaScript functions
-- | which accept or return undefined values.
foreign import data Undefinable :: * -> *

-- | The undefined value.
foreign import undefined :: forall a. Undefinable a

foreign import undefinable :: forall a r. Fn3 (Undefinable a) r (a -> r) r

-- | Wrap a non-undefined value.
foreign import notUndefined :: forall a. a -> Undefinable a

-- | Takes `Nothing` to `undefined`, and `Just a` to `a`.
toUndefinable :: forall a. Maybe a -> Undefinable a
toUndefinable = maybe undefined notUndefined

-- | Represent `undefined` using `Maybe a` as `Nothing`.
toMaybe :: forall a. Undefinable a -> Maybe a
toMaybe n = runFn3 undefinable n Nothing Just

instance showUndefinable :: Show a => Show (Undefinable a) where
  show = maybe "undefined" show <<< toMaybe

instance eqUndefinable :: (Eq a) => Eq (Undefinable a) where
  eq = eq `on` toMaybe

instance ordUndefinable :: (Ord a) => Ord (Undefinable a) where
  compare = compare `on` toMaybe
