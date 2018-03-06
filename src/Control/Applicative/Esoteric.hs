module Control.Applicative.Esoteric where

import Control.Applicative

-- A safer version of '*>' where the left type arg must be unit ().
(!*>) :: Applicative f => f () -> f b -> f b
(!*>) = (*>)
infixl 4 !*> -- like *>

($*>) :: (Applicative m, Applicative f) => m (f a) -> m (f b) -> m (f b)
($*>) = liftA2 (*>)
infixl 4 $*> -- like *>

($!*>) :: (Applicative m, Applicative f) => m (f ()) -> m (f b) -> m (f b)
($!*>) = liftA2 (!*>)
infixl 4 $!*> -- like *>

($<*>) :: (Applicative m, Applicative f) => m (f (a -> b)) -> m (f a) -> m (f b)
($<*>) = liftA2 (<*>)
infixl 4 $<*> -- like <*>
