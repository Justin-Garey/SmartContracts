import System.Directory ( doesFileExist ) -- Check if file exists with doesFileExist
import System.Environment ( getArgs ) -- Gives us getArgs
import System.IO () -- For working with input
import Data.List ( nub, partition ) 

-- countChoices
-- Takes a list of strings
-- Returns a list of counted values
countChoices :: (Eq a) => [a] -> [Int] 
countChoices votes = case votes of
    [] -> [0]
    (x:xs) -> case partition (==x) votes of
        (y, []) -> [length y]
        (y, ys) -> length y : countChoices ys

-- main - runs on program call
main :: IO ()
main = do
    (fileN : _) <- getArgs
    fileExists <- doesFileExist fileN
    if fileExists
        then do contents <- readFile fileN
                print (nub (words contents) `zip` countChoices (words contents))
        else do putStrLn "The file does not exist"
