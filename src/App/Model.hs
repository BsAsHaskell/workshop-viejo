{-# LANGUAGE OverloadedStrings #-}

module App.Model where

import Data.Csv
import Control.Applicative

data Episode = Episode {
    episodeId :: Int
  , episodeSeason :: Int
  , episodeNumber :: Int
  , episodeTitle :: String
  , episodeDate :: String
  , episodeWriter :: String
  , episodeDirector :: String
  } deriving Show

instance FromNamedRecord Episode where
    parseNamedRecord m = Episode <$>
        m .: "id" <*>
        m .: "season_number" <*>
        m .: "episode_number" <*>
        m .: "title" <*>
        m .: "the_date" <*>
        m .: "writer" <*>
        m .: "director"

data Utterance = Utterance {
    utteranceId :: Int
  , utteranceEpisode :: Int
  , utteranceNumber :: Int
  , utteranceSpeaker :: Int
  } deriving Show

instance FromNamedRecord Utterance where
    parseNamedRecord m = Utterance <$>
        m .: "id" <*>
        m .: "episode_id" <*>
        m .: "utterance_number" <*>
        m .: "speaker"

data Sentence = Sentence {
    sentenceId :: Int
  , sentenceUtterance :: Int
  , sentenceNumber :: Int
  , sentenceText :: String
  } deriving Show

instance FromNamedRecord Sentence where
    parseNamedRecord m = Sentence <$>
        m .: "id" <*>
        m .: "utterance_id" <*>
        m .: "sentence_number" <*>
        m .: "text"
