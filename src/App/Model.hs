{-# LANGUAGE OverloadedStrings #-}
module App.Model where

data Episode = Episode {
    episodeId :: Int
  , episodeSeason :: Int
  , episodeNumber :: Int
  , episodeTitle :: String
  , episodeDate :: String
  , episodeWriter :: String
  , episodeDirector :: String
  } deriving Show

data Utterance = Utterance {
    utteranceId :: Int
  , utteranceEpisode :: Int
  , utteranceNumber :: Int
  , utteranceSpeaker :: String
  } deriving Show

data Sentence = Sentence {
    sentenceId :: Int
  , sentenceUtterance :: Int
  , sentenceNumber :: Int
  , sentenceText :: String
  } deriving Show
