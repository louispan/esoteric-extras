module Data.Function.Esoteric where

-- A safer version of const where the second arg must be ()
const' :: a -> () -> a
const' = const
