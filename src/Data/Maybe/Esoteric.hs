module Data.Maybe.Esoteric where

-- | Eg. keepMaybes :: [(a, Maybe b)] -> [(a, b)]
-- Create a [(a, b)] with only the Just values in a list of (a, Maybe b)
keepMaybes :: (Monoid (f (t b)), Applicative f, Foldable f, Traversable t) => f (t (Maybe b)) -> f (t b)
keepMaybes = foldMap $ maybe mempty pure . sequenceA
