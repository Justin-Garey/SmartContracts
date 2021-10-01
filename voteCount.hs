import Data.List
data Vote = Yes | No | Abstain deriving ( Eq )

testVotes = [Yes, Yes, No, Abstain]
testMultiChoice = "Abe George George Abe George Kennedy Kennedy Kennedy Kennedy"

countVotes :: [Vote] -> String
countVotes votes = show yesPercent ++ "% voted yes. " ++ show noPercent ++ "% voted no. " ++ show abstainPercent ++ "% chose to abstain."
    where yesPercent = fromIntegral(length(filter (== Yes) votes)) / fromIntegral(length votes) * 100
          noPercent = fromIntegral(length(filter (== No) votes)) / fromIntegral(length votes) * 100
          abstainPercent = fromIntegral(length(filter (== Abstain) votes)) / fromIntegral(length votes) * 100

countMultiChoice :: String -> [Int] -- Function to call on string of votes
countMultiChoice votes = countChoices (words votes)

-- Helper function for countMultiChoice
-- Turns a list of strings into a list of ints representing the
-- number of duplicates of each string
-- ["Abe", "George", "George", "George", "John", "John"] -> [1, 3, 2]
countChoices :: [String] -> [Int] 
countChoices votes = case votes of
    [] -> [0]
    (x:xs) -> case partition (==x) votes of
        (y, []) -> [length y]
        (y, ys) -> (length y: countChoices ys)

main = print(countMultiChoice testMultiChoice)