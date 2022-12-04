module Day3(computeRucksackPriorities, computeRucksackGroupPriorities) where

import qualified Data.Set as Set

type RucksackGroup = (String, String, String)

computePriority :: Char -> Int
computePriority t
  | c `elem` [97..122] = c - 96
  | c `elem` [65..90] = (c - 64) + 26
  | otherwise = error "Invalid character code"
  where 
    c = fromEnum t

computeRucksackPriority :: String -> Int
computeRucksackPriority line = computePriority t
  where
    half = length line `div` 2
    firstHalf = Set.fromList $ take half line
    secondHalf = Set.fromList $ drop half line
    t = head $ Set.toList $ Set.intersection firstHalf secondHalf

computeRucksackPriorities :: FilePath -> IO Int
computeRucksackPriorities path = do
  sum . map computeRucksackPriority <$> (lines <$> readFile path)

computeRucksackGroupPriority :: RucksackGroup -> Int
computeRucksackGroupPriority (a,b,c) = computePriority $ head (Set.toList s)
  where
    s = Set.intersection (Set.fromList a) $ Set.intersection (Set.fromList b)  (Set.fromList c)

parseLines :: [String] -> [RucksackGroup]
parseLines [] = []
parseLines (a:b:c:r)= (a,b,c):parseLines r
parseLines _ = error "Expected Lists with len divisible by 3"

computeRucksackGroupPriorities :: FilePath -> IO Int
computeRucksackGroupPriorities path = do
  sum . map  computeRucksackGroupPriority <$> fmap parseLines (lines <$> readFile path)