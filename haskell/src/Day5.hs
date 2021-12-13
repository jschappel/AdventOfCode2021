module Day5 where

type Point = (Int, Int)

data Graph = Graph [[Maybe(Int)]]
    deriving(Show)

filepath = "files/vents.txt"

parseInput :: String -> Point
parseInput input = p1
  where 
    [[xl, ',', yl], "->", [x2, ',', y2]] = words input
    p1 = (read xl :: Int, read yl :: Int)
    --p2 = (x2, y2)

numOfDangerousAreas = do
  ls <- fmap lines (readFile filepath)
  let tmp = map parseInput ls
  putStrLn $ show tmp