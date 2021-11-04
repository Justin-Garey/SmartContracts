-- Imports
import qualified Data.Text           as T
import           Ledger               (ScriptContext)
import qualified Ledger.Typed.Scripts as Scripts
import           Playground.Contract
import           Plutus.Contract
import           PlutusTx.Prelude
import qualified Prelude             as Haskell

-- Schema
type Schema =
        Endpoint "vote" VoteParams

-- Validator function TODO: Set this up with the script
validateVote :: ScriptContext -> Bool
validateVote _ = True

-- Seems like it is needed
data Vote
instance Scripts.ValidatorTypes Vote where
    type instance DatumType Vote = VoteParams

-- Parameters for the "vote" endpoint
newtype VoteParams = VoteParams
    { ballot :: Haskell.String
    }
    deriving stock (Haskell.Eq, Haskell.Show, Generic)
    deriving anyclass (FromJSON, ToJSON, ToSchema, ToArgument)

-- Functions

-- Says 
vote :: AsContractError e => Promise () Schema e ()
vote = endpoint @"vote" (logInfo @VoteParams)

-- | Logs "The Polls are Open!!" and calls a vote 
poll :: AsContractError e => Contract () Schema e ()
poll = do
    logInfo @Haskell.String "The Polls are Open!!"
    selectList [vote]

-- endpoints function is what is called to run the contract
endpoints :: AsContractError e => Contract () Schema e ()
endpoints = poll

-- Set the endpoints in place
mkSchemaDefinitions ''Schema

$(mkKnownCurrencies [])