module Data.SKey
( SKey
, betweenSKey
, largerSKey
, smallerSKey
) where

import qualified Data.List.NonEmpty as NE

-- | A key where you can always create
-- another key ordered between two different keys,
-- or another key above or below this key.
-- Memonic: S for smooth and continuous.
-- Not named CKey to avoid clashing with 'System.Posix.Types.CKey'
type SKey = NE.NonEmpty Int

-- | Make a key that will fit in between the two provided keys,
-- Except when the inputs are equal, then it will return the same key.
betweenSKey :: NE.NonEmpty Int -> NE.NonEmpty Int -> NE.NonEmpty Int
betweenSKey xx@(x NE.:| xs) yy@(y NE.:| ys) =
    case compare x y of
        LT -> makeSKey xx y
        GT -> makeSKey yy x
        EQ -> x NE.:| betweenSKey' xs ys
  where
    -- Must only be called if we already know the Int is larger
    -- (it cannot be equal to the head in x)
    -- Creates a new key in between.
    makeSKey :: NE.NonEmpty Int -> Int -> NE.NonEmpty Int
    makeSKey (smaller NE.:| smaller') larger =
        let h = quot (larger + smaller) 2
        in if h == smaller -- can only happen if y = x + 1
            then smaller NE.:| largerSKey' smaller'
            else h NE.:| []

-- | Internal: Make a key that will fit in between the two provided keys,
-- with no guarantees on how close it is to the mid point.
-- Except when the inputs are equal, then it will return the same key.
betweenSKey' :: [Int] -> [Int] -> [Int]
betweenSKey' [] [] = []
betweenSKey' [] (y : _) = [quot y 2]
betweenSKey' (x : _) [] = [x - 1]
betweenSKey' (x : xs) (y : ys) = NE.toList $ betweenSKey (x NE.:| xs) (y NE.:| ys)

-- | Internal: Create a key larger than the input key.
-- NB. It does not create the smallest key that is larger.
largerSKey' :: [Int] -> [Int]
largerSKey' [] = [0]
largerSKey' (a : _) = [a + step']

-- | Internal: an arbitrary step
step' :: Int
step' = 32

-- | Create a key larger than the input key.
-- NB. It does not create the smallest key that is larger.
largerSKey :: NE.NonEmpty Int -> NE.NonEmpty Int
largerSKey (a NE.:| _) = (a + step') NE.:| []

-- | Create a key smaller than the input key.
-- NB. It does not create the largest key that is smaller.
smallerSKey :: NE.NonEmpty Int -> NE.NonEmpty Int
smallerSKey (a NE.:| _) = (a - step') NE.:| []
