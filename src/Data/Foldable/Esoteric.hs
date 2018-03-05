module Data.Foldable.Esoteric where

import Data.Foldable

-- A safer version of 'traverse_' where the left type arg must be unit ().
-- mapping function results in unit ().
traverse_' :: (Foldable t, Applicative f) => (a -> f ()) -> t a -> f ()
traverse_' = traverse_
