module Control.Arrow.Esoteric where

import Control.Arrow

rk :: Kleisli m a1 b1
    -> (a1 -> m b1)
rk = runKleisli

rk1 :: (Kleisli m a1 b1 -> Kleisli m a2 b2)
    -> (a1 -> m b1) -> (a2 -> m b2)
rk1 f x = runKleisli $ f (Kleisli x)


rk2 :: (Kleisli m a1 b1 -> Kleisli m a2 b2 -> Kleisli m a3 b3)
    -> (a1 -> m b1) -> (a2 -> m b2) -> (a3 -> m b3)
rk2 f x y = runKleisli $ f (Kleisli x) (Kleisli y)

