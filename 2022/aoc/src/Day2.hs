module Day2(computeMyTotalScore, computeFixedScore) where

data Shape = Rock | Paper | Scissors deriving(Show, Eq, Enum)

instance Ord Shape where
  compare x y | x == y = EQ
  compare Rock Paper = LT
  compare Paper Scissors = LT
  compare Scissors Rock = LT
  compare _ _ = GT

-- coverts the data into scores
parseLines ::  [String] -> ([Shape], [Shape])
parseLines = foldl parseLine ([],[])
  where
    -- assumption: only 2 words per line
    parseLine (xs,ys) s = (calcType (head s):xs, calcType (last s):ys)
    calcType v = case v of
      'A' -> Rock
      'X' -> Rock
      'B' -> Paper
      'Y' -> Paper
      'C' -> Scissors
      'Z' -> Scissors
      _ -> error ("Invalid Game Type")

-- assumption: lists are the same length
calculateScores :: [Shape] -> [Shape] -> (Int, Int)
calculateScores l1 l2 = calculateScoresHelper l1 l2 (0,0)
  where
    calculateScoresHelper [] [] a = a
    calculateScoresHelper (x:xs) (y:ys) (p1,p2) =
      case compare x y of
        GT -> calculateScoresHelper xs ys (p1 + 6 + x_val,   p2 + y_val)
        LT -> calculateScoresHelper xs ys (p1 + x_val,       p2 + 6 + y_val)
        EQ -> calculateScoresHelper xs ys (p1 + 3 + x_val,   p2 + 3 + y_val)
      where
        y_val = 1 + fromEnum y
        x_val = 1 + fromEnum x
    calculateScoresHelper _ _ _ = error ("Unreachable!")


succ', pred' :: Shape -> Shape
succ' = toEnum . (`mod` 3) . succ . fromEnum
pred' = toEnum . (`mod` 3) . pred . fromEnum


-- assumption: lists are the same length
calculateMyMoves :: [Shape] -> [Shape] -> [Shape]
calculateMyMoves [] [] = []
calculateMyMoves (x:xs) (y:ys) = calcNextMove x y:calculateMyMoves xs ys
  where
    calcNextMove s m = case m of
      Scissors -> succ' s
      Rock -> pred' s
      Paper -> s
calculateMyMoves _ _ = error ("Unreachable!")

computeMyTotalScore :: FilePath -> IO Int
computeMyTotalScore path = do
  (x,y) <- fmap parseLines (lines <$> readFile path)
  let (_, p2s) = calculateScores x y
  return p2s


computeFixedScore :: FilePath -> IO Int
computeFixedScore path = do
  (x,y) <- fmap parseLines (lines <$> readFile path)
  let (_, p2s) = calculateScores x $ calculateMyMoves x y
  return p2s