module Day6 where

import Data.List.Split
import qualified Data.List as List

filepath = "files/lanternfish.txt"
numOfDays = 256

type Day = Int
type Total = Int


parseInput :: String -> [Day]
parseInput = map read . splitOn ","


buildAssocList :: [Int] -> Int -> [(Day, Total)]
buildAssocList _ (-1) = []
buildAssocList l n = (n, count):buildAssocList l (n-1)
  where 
    count = length $ filter (==n) l


simulateTime :: [(Day, Total)] -> Day -> [(Day, Total)]
simulateTime l 0 = l
simulateTime l days = simulateTime newList $ days - 1
  where
    newList = nextDay l [(x,0) | x <- [0..8]]
    nextDay [] acc = acc
    nextDay (x:xs) acc
      | d == 0  && t > 0  = nextDay xs (insertInto (8, t) . insertInto (6, t) $ acc)
      | otherwise = nextDay xs (insertInto (d-1,t) acc)
      where 
        (d,t) = x
        insertInto _ [] = []
        insertInto v ((d,t):xs)
          | d2 == d   = (d, t+t2):insertInto v xs
          | otherwise = (d,t):insertInto v xs
          where (d2, t2) = v


numOfTotalFish :: IO String 
numOfTotalFish = do
  ls <- fmap lines (readFile filepath)
  let fishs =  parseInput . head $ ls
      init = reverse $ buildAssocList fishs 8
      afterTime = simulateTime init numOfDays
      total =  List.foldr (\(_,t) acc -> acc + t) 0 afterTime
  return $ show total
