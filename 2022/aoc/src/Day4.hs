module Day4(computeOverlappingGroups, computeFullyContainedGroups) where

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


fullyContains :: RangePair -> Bool
fullyContains (RangePair (Range a b) (Range c d)) =
  a <= c && b >= d || c <= a && d >= b


hasOverlap :: RangePair -> Bool
hasOverlap (RangePair (Range a b) (Range c d)) =
  foldl (\acc x-> acc || (x `elem` [a..b])) False [c..d]


findOverlappingGroups :: [RangePair] -> Int
findOverlappingGroups [] = 0
findOverlappingGroups (x:xs)
  | fullyContains x = 1 + findOverlappingGroups xs
  | otherwise = findOverlappingGroups xs


computeFullyContainedGroups :: FilePath -> IO Int
computeFullyContainedGroups path = do
  fmap (findOverlappingGroups . parseLines) (lines <$> readFile path)


computeOverlappingGroups :: FilePath -> IO Int
computeOverlappingGroups path = do
  let incr a x = if hasOverlap x then a + 1 else a
  foldl incr 0 <$> fmap parseLines (lines <$> readFile path)
  