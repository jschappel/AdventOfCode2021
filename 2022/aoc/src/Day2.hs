
module Day2(computeMyTotalScore) where


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
    parseLine (xs,ys) s = (calcType x:xs, calcType y:ys)
      where [x,y] = words s
    calcType v = case v of
      "A" -> Rock
      "X" -> Rock
      "B" -> Paper
      "Y" -> Paper
      "C" -> Scissors
      "Z" -> Scissors
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

computeMyTotalScore :: FilePath -> IO Int
computeMyTotalScore path = do
  d <- lines <$> readFile path
  let (p1, p2) = parseLines d
      (p1s, p2s) = calculateScores p1 p2
  putStrLn $ show p1s
  putStrLn $ show p2s
  return p2s

