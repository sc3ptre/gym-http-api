-------------------------------------------------------------------------------
-- |
-- Module    :  OpenAI.Gym.Data
-- License   :  MIT
-- Stability :  experimental
-- Portability: non-portable
-------------------------------------------------------------------------------
{-# LANGUAGE DeriveGeneric #-}
module OpenAI.Gym.Data
  ( GymEnv (..)
  , InstID (..)
  , Environment (..)
  , Observation (..)
  , Step (..)
  , Outcome (..)
  , Info (..)
  , Action (..)
  , Monitor (..)
  , Config (..)
  ) where

import OpenAI.Gym.Prelude
import qualified Data.Text as T

data GymEnv
  -- | Classic Control Environments
  = CartPoleV0               -- ^ Balance a pole on a cart (for a short time).
  | CartPoleV1               -- ^ Balance a pole on a cart.
  | AcrobotV1                -- ^ Swing up a two-link robot.
  | MountainCarV0            -- ^ Drive up a big hill.
  | MountainCarContinuousV0  -- ^ Drive up a big hill with continuous control.
  | PendulumV0               -- ^ Swing up a pendulum.

  -- | Atari Games
  | PongRamV0                -- ^ Maximize score in the game Pong, with RAM as input
  | PongV0                   -- ^ Maximize score in the game Pong
  deriving (Eq, Enum, Ord)


instance Show GymEnv where
  show CartPoleV0              = "CartPole-v0"
  show CartPoleV1              = "CartPole-v1"
  show AcrobotV1               = "Acrobot-v1"
  show MountainCarV0           = "MountainCar-v0"
  show MountainCarContinuousV0 = "MountainCarContinuous-v0"
  show PendulumV0              = "Pendulum-v0"
  show PongRamV0               = "Pong-ram-v0"
  show PongV0                  = "Pong-v0"


instance ToJSON GymEnv where
  toJSON env = object ["env_id" .= show env]


newtype InstID = InstID { instance_id :: Text }
  deriving (Eq, Show, Generic)

instance ToJSON InstID
instance FromJSON InstID


newtype Environment = Environment { all_envs :: HashMap Text Text }
  deriving (Eq, Show, Generic)

instance ToJSON Environment
instance FromJSON Environment


newtype Observation = Observation { observation :: Value }
  deriving (Eq, Show, Generic)

instance ToJSON Observation
instance FromJSON Observation


data Step = Step
  { action :: !Value
  , render :: !Bool
  } deriving Generic

instance ToJSON Step


data Outcome = Outcome
  { obs    :: !Value
  , reward :: !Double
  , done   :: !Bool
  , info   :: !Object
  } deriving (Eq, Show, Generic)

instance ToJSON Outcome where
  toJSON (Outcome o r d i) =
    object ["observation" .= o, "reward" .= r, "done" .= d, "info" .= i]
instance FromJSON Outcome


newtype Info = Info { info :: Object }
  deriving (Eq, Show, Generic)

instance ToJSON Info
instance FromJSON Info


newtype Action = Action { action :: Value }
  deriving (Eq, Show, Generic)

instance ToJSON Action
instance FromJSON Action


data Monitor = Monitor
  { directory      :: !Text
  , force          :: !Bool
  , resume         :: !Bool
  , video_callable :: !Bool
  } deriving Generic

instance ToJSON Monitor


data Config = Config
  { training_dir :: !Text
  , algorithm_id :: !Text
  , api_key      :: !Text
  } deriving Generic

instance ToJSON Config


