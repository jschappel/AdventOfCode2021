module Day2 where

data Direction = 
  Forward Int
  | Up Int
  | Down Int
  deriving(Show)

type Position = (Int, Int)


filepath = "files/directions.txt"


parseInput :: String -> Direction
parseInput l = case dir of
  "forward" -> (Forward (read v))
  "up" -> Up (read v)
  "down" -> Down (read v)
  _ -> error $ "invalid case gaven: " ++ dir 
  where [dir,v] = words l

findPosition = do
  input <-fmap lines (readFile filepath)
  let (hd:dirs) = map parseInput input
      (x,y) = determinPosition dirs
  putStrLn $ show (x * y)



determinPosition :: [Direction] -> Position
determinPosition d = determinPosition' (0, 0) d
  where
    determinPosition' tup [] = tup
    determinPosition' (x,y) (z:zs) = case z of
      (Forward v) -> determinPosition' (v+x, y) zs
      (Up v) -> determinPosition' (x, y-v) zs
      (Down v) -> determinPosition' (x, y+v) zs


