module Data.Foldable.Esoteric where

import Data.Foldable

-- A safer version of 'Data.Foldable.traverse_' where
-- mapping function results in unit ().
traverse_' :: (Foldable t, Applicative f) => (a -> f ()) -> t a -> f ()
traverse_' = traverse_
