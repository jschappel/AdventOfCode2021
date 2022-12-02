module Day1 where

import Data.List as List

filepath = "files/depth.txt"


sumTriples :: (Num a) => [a] -> [a]
sumTriples (x:y:z:xs) = (x + y + z):sumTriples (y:z:xs)
sumTriples _ = []


sumDepths :: IO String
sumDepths = do
  ls <- fmap lines (readFile filepath)
  let f:rest = map (\x -> read x :: Integer) ls
      num = sum . snd . List.mapAccumL (\a x -> (x, if x > a then 1 else 0)) f $ rest
  return $ show num

sumDepthsAsTriples :: IO String
sumDepthsAsTriples = do
  ls <- fmap lines (readFile filepath)
  let f:rest = sumTriples (map (\x -> read x :: Integer) $ ls)
      num = sum . snd . List.mapAccumL (\a x -> (x, if x > a then 1 else 0)) f $ rest
  return $ show num