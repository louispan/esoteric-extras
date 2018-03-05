module Control.Arrow.Esoteric where

import Control.Arrow

-- runK :: Kleisli m a1 b1
--     -> (a1 -> m b1)
-- runK = runKleisli

underK1 :: (Kleisli m a1 b1 -> Kleisli m a2 b2)
    -> (a1 -> m b1) -> (a2 -> m b2)
underK1 f x = runKleisli $ f (Kleisli x)


underK2 :: (Kleisli m a1 b1 -> Kleisli m a2 b2 -> Kleisli m a3 b3)
    -> (a1 -> m b1) -> (a2 -> m b2) -> (a3 -> m b3)
underK2 f x y = runKleisli $ f (Kleisli x) (Kleisli y)

