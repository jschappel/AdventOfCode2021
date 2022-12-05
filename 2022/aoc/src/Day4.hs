module Day4(computeOverlappingGroups) where

data Range = Range Int Int deriving(Show)
data RangePair = RangePair Range Range deriving(Show)


parseLines :: [String] -> [RangePair]
parseLines = map parseLine 
  where
    parseLine :: String -> RangePair
    parseLine lst = RangePair (parseSingle x "") (parseSingle (tail y) "")
      where
        (x,y) = span (/=',') lst
        parseSingle ('-':xs) a = Range (read a :: Int) (read xs :: Int)
        parseSingle (z:zs) a = parseSingle zs $ a ++ [z]
        parseSingle _ _ = error "Unreachable"


fullyContains :: Range -> Range -> Bool
fullyContains (Range a b) (Range c d) = a <= c && b >= d || c <= a && d >= b


findOverlappingGroups :: [RangePair] -> Int
findOverlappingGroups [] = 0
findOverlappingGroups ((RangePair r1 r2):xs)
  | fullyContains r1 r2 = 1 + findOverlappingGroups xs
  | otherwise = findOverlappingGroups xs


computeOverlappingGroups :: FilePath -> IO Int
computeOverlappingGroups path = do
  ranges <- fmap parseLines (lines <$> readFile path)
  let tmp = findOverlappingGroups ranges
  return tmp
