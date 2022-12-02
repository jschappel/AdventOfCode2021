module Main (main) where

import Day2

main :: IO ()
main = do
  res <- computeMyTotalScore "data/Day2.txt"
  print $ "res is " ++ (show res)