module Day3(computeRucksackPriorities) where

import qualified Data.Set as Set

computeRucksackPriority :: String -> Int
computeRucksackPriority line = computePriority . fromEnum $ t
  where
    half = length line `div` 2
    firstHalf = Set.fromList $ take half line
    secondHalf = Set.fromList $ drop half line
    t = head $ Set.toList $ Set.intersection firstHalf secondHalf
    computePriority c
      | c `elem` [97..122] = c - 96
      | c `elem` [65..90] = (c - 64) + 26
      | otherwise = error "Invalid character code"

computeRucksackPriorities :: FilePath -> IO Int
computeRucksackPriorities path = do
  sum . map computeRucksackPriority <$> (lines <$> readFile path)
