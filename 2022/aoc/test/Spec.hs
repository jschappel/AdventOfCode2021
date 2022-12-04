
import Test.Hspec
import Day1
import Day2
import Day3

main :: IO ()
main = hspec $ do
  describe "Day 1 Tests" $ do
    it "Calculates the elf with the max amount of calories" $ do
      actual <- getMaxCalories "test/data/Day1.txt"
      actual `shouldBe` 24000

      actual_2 <- getMaxCalories "data/Day1.txt"
      actual_2 `shouldBe` 70720

    it "Calculates the sum of the Calories carried by the top three elves" $ do
      actual <- getMaxThreeCalories "test/data/Day1.txt"
      actual `shouldBe` 45000

      actual_2 <- getMaxThreeCalories "data/Day1.txt"
      actual_2 `shouldBe` 207148

  describe "Day 2 Tests" $ do
    it "Calculates My total score" $ do
      actual <- computeMyTotalScore "test/data/Day2.txt"
      actual `shouldBe` 15

      actual_2 <- computeMyTotalScore "data/Day2.txt"
      actual_2 `shouldBe` 12156

    it "Calculates My Fixed score" $ do
      actual <- computeFixedScore "test/data/Day2.txt"
      actual `shouldBe` 12

      actual_2 <- computeFixedScore "data/Day2.txt"
      actual_2 `shouldBe` 10835

  describe "Day 3 Tests" $ do
    it "Calculates the sum of the priorities" $ do
      actual <- computeRucksackPriorities "test/data/Day3.txt"
      actual `shouldBe` 157

      actual_2 <- computeRucksackPriorities "data/Day3.txt"
      actual_2 `shouldBe` 8185

    it "Calculates the sum of the groups priorities" $ do
      actual <- computeRucksackGroupPriorities "test/data/Day3.txt"
      actual `shouldBe` 70

    it "Calculates the sum of the groups priorities" $ do
      actual <- computeRucksackGroupPriorities "data/Day3.txt"
      actual `shouldBe` 2817

      