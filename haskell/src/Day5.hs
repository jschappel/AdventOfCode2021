module Day5 where

import Data.List.Split
import Data.List as List
import qualified Data.Map as M

type Point = (Int, Int)
type Graph = M.Map Point Int

filepath = "files/vents.txt"


addToGraph :: Graph -> Point -> Graph
addToGraph m p = case M.lookup p m of
  Nothing -> M.insert p 1 m
  Just n  -> M.insert p (n+1) m


parseInput :: String -> [Point]
parseInput = map toPoint . splitOn "->"
  where 
    toPoint l = (read x, read y)
      where 
        [x, y] = splitOn "," l


addMissingPts :: Point -> Point -> [Point]
addMissingPts (x1,y1) (x2,y2)
  | x1 == x2 && y1 == y2 = [(x1, x2)]
  | x1 == x2 = [(x1, y) | y <- range y1 y2]
  | y1 == y2 = [(x, y1) | x <- range x1 x2]
  | otherwise = zip (range x1 x2) (range y1 y2)
  where
    range a b 
      | a < b     = [a..b]
      | otherwise = [a,a-1..b]


numOfDangerousAreas = do
  ls <- fmap lines (readFile filepath)
  let parsedInput = map parseInput ls
      pts = List.concatMap (\[p1, p2] -> addMissingPts p1 p2) $ parsedInput
      m = List.foldl addToGraph M.empty pts
      ans = M.foldr (\v a -> if v >= 2 then a+1 else a) 0 m
  putStrLn $ show ans
