module Main (main) where

import Day1

main :: IO ()
main = do
  res <- getMaxThreeCalories "data/Day1.txt"
  print $ "res is " ++ (show res)