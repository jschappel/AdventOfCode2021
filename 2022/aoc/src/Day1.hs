module Day1 (getMaxCalories, getMaxThreeCalories) where
import Data.List (sortOn)
import Data.Ord

type Elf = Int

getMaxCalories :: FilePath -> IO Int
getMaxCalories path = do
  fmap (maximum . makeElves) (lines <$> readFile path)

getMaxThreeCalories :: FilePath -> IO Int
getMaxThreeCalories path = do
  elves <- fmap makeElves (lines <$> readFile path)
  return $ sum $ take 3 $ sortOn Down elves

makeElves :: [String] -> [Elf]
makeElves [] = []
makeElves ("":xs) = makeElves xs
makeElves input = makeElf:makeElves rest
  where
    current = takeWhile (/=[]) input
    rest = dropWhile (/=[]) input
    makeElf = sum $ map (\v -> read v :: Int) current

