module Day3 where
import Data.List as List


filepath = "files/binaryDiagnostic.txt"

type Epsilon = Int
type Gamma = Int

computeAlphaEpsilon :: [String] -> (Gamma, Epsilon)
computeAlphaEpsilon l = compute l ("", "")
  where
    compute [] (g,e) = (binStrToInt g, binStrToInt e)
    compute (x:xs) (g,e) = compute xs (g ++ gamma, e ++ epsilon)
      where
        ones = length $ filter (=='1') x
        zeros = length $ filter (=='0') x
        gamma = if ones > zeros then "1" else "0"
        epsilon = if ones < zeros then "1" else "0" 


ratingCalculator :: [String] -> (Int -> Int -> Char) -> Int
ratingCalculator l f = solve l 0 
  where
    solve [x] _ = binStrToInt x 
    solve l i = solve filteredList (i+1)
      where 
        vals = map (\l -> l !! i) l
        ones = length $ filter (=='1') vals
        zeros = length $ filter (=='0') vals
        mostCommon = f ones zeros
        filteredList = filter (\v -> mostCommon ==  v !! i) l



binStrToInt :: String -> Int
binStrToInt = bintodec . read 
  where
    bintodec 0 = 0
    bintodec i = 2 * bintodec (div i 10) + (mod i 10)


binaryDiagnostic = do 
  input <-fmap (transpose . lines) $ readFile filepath
  let (gamma, epsilon) = computeAlphaEpsilon input
      powerConsumption = gamma * epsilon
  putStrLn $ show powerConsumption


lifeSupportRating = do
  input <-fmap  lines $ readFile filepath
  let oxygen = ratingCalculator input (\o z -> if o >= z then '1' else '0')
      co2 = ratingCalculator input (\o z -> if z <= o then '0' else '1')
  putStrLn $ show (oxygen * co2)