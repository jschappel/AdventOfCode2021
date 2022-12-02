
import Test.Hspec
import Day1
import Day2

main :: IO ()
main = hspec $ do
  describe "Day 1 Tests" $ do
    it "Calculates the elf with the max amount of calories" $ do
      actual <- getMaxCalories "test/data/Day1.txt"
      actual `shouldBe` 24000

    it "Calculates the sum of the Calories carried by the top three elves" $ do
      actual <- getMaxThreeCalories "test/data/Day1.txt"
      actual `shouldBe` 45000

    it "Calculates My total score" $ do
      actual <- computeMyTotalScore "test/data/Day2.txt"
      actual `shouldBe` 15
      
      