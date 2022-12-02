module Main where

import Day1
import Day2
import Day3
import Day5
import Day6

main :: IO ()
main = do
        tmp <- Day1.sumDepths
        day6 <- Day6.numOfTotalFish
        putStrLn day6
