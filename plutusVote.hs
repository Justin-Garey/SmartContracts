import qualified Data.Text            as T
import           Control.Monad        (void)
import           Ledger               (Address, ScriptContext)
import qualified Ledger.Constraints   as Constraints
import qualified Ledger.Typed.Scripts as Scripts
import           Ledger.Value         (Value)
import           Playground.Contract
import           Plutus.Contract
import qualified PlutusTx
import           PlutusTx.Prelude     hiding (Applicative (..))
import qualified Prelude              as Haskell

-- Validator function
validateVote :: ScriptContext -> Bool
validateVote _ = True

data Vote
instance Scripts.ValidatorTypes Vote where
    type instance DatumType Vote = VoteParams

type VoteSchema =
        Endpoint "vote" VoteParams

newtype VoteParams = VoteParams
    { ballot :: Haskell.String
    }
    deriving stock (Haskell.Eq, Haskell.Show, Generic)
    deriving anyclass (FromJSON, ToJSON, ToSchema, ToArgument)

-- Submit a vote from a wallet to the contract
vote :: AsContractError e => Promise () VoteSchema e ()
vote = endpoint @"vote" (logInfo @VoteParams)

-- Endpoints for playground to populate UI; The public interface
endpoints :: Contract () VoteSchema T.Text ()
endpoints = selectList [vote]

-- Generates "Glue Code" for the Playground
mkSchemaDefinitions ''VoteSchema

$(mkKnownCurrencies [])