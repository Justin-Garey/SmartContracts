data Vote = Yes | No | Abstain deriving ( Eq )

countVotes :: [Vote] -> String
countVotes votes = show yesPercent ++ "% voted yes. " ++ show noPercent ++ "% voted no. " ++ show abstainPercent ++ "% chose to abstain."
    where yesPercent = fromIntegral(length(filter (== Yes) votes)) / fromIntegral(length votes) * 100
          noPercent = fromIntegral(length(filter (== No) votes)) / fromIntegral(length votes) * 100
          abstainPercent = fromIntegral(length(filter (== Abstain) votes)) / fromIntegral(length votes) * 100
