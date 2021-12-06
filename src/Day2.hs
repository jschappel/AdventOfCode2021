module Day2 where

data Direction = 
  Forward Int
  | Up Int
  | Down Int
  deriving(Show)

type Position = (Int, Int) -- horizontal, depth
type PositionAim = (Int, Int, Int) -- horizontal, depth, aim

filepath = "files/directions.txt"


findPosition = do
  input <-fmap lines (readFile filepath)
  let dirs = map parseInput input
      (x,y) = determinPosition dirs
  putStrLn $ show (x * y)

findPositionWithAim = do
  input <-fmap lines (readFile filepath)
  let dirs = map parseInput input
      (x,y,z) = determinPositionWithAim dirs
  putStrLn $ show (x * y)


parseInput :: String -> Direction
parseInput l = case dir of
  "forward" -> (Forward (read v))
  "up" -> Up (read v)
  "down" -> Down (read v)
  _ -> error $ "invalid case gaven: " ++ dir 
  where [dir,v] = words l


determinPositionWithAim :: [Direction] -> PositionAim
determinPositionWithAim d = determinPositionWithAim' (0,0,0) d
  where
    determinPositionWithAim' tup [] = tup
    determinPositionWithAim' (x,y,z) (h:tl) = case h of
      (Forward v) -> determinPositionWithAim' (x+v, y+z*v, z) tl
      (Up v) -> determinPositionWithAim' (x,y,z-v) tl
      (Down v) -> determinPositionWithAim' (x,y,z+v) tl

determinPosition :: [Direction] -> Position
determinPosition d = determinPosition' (0, 0) d
  where
    determinPosition' tup [] = tup
    determinPosition' (x,y) (z:zs) = case z of
      (Forward v) -> determinPosition' (v+x, y) zs
      (Up v) -> determinPosition' (x, y-v) zs
      (Down v) -> determinPosition' (x, y+v) zs


