{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}
module App.Json where

import           Data.Aeson
import qualified Data.Text.Lazy      as T

import           App.Model

jsonError :: String -> Value
jsonError msg = object ["error" .= T.pack msg]

instance ToJSON Episode where
    toJSON Episode{..} = object [ "id" .= episodeId
                                , "season" .= episodeSeason
                                , "number" .= episodeNumber
                                , "title" .= episodeTitle
                                , "date" .= episodeDate
                                , "writer" .= episodeWriter
                                , "director" .= episodeDirector
                                ]

instance ToJSON Utterance where
    toJSON Utterance{..} = object [ "id" .= utteranceId
                                  , "episode" .= utteranceEpisode
                                  , "number" .= utteranceNumber
                                  , "speaker" .= utteranceSpeaker
                                  ]

instance ToJSON Sentence where
    toJSON Sentence{..} = object [ "id" .= sentenceId
                                 , "utterance" .= sentenceUtterance
                                 , "number" .= sentenceNumber
                                 , "text" .= sentenceText
                                 ]

instance ToJSON Speech where
    toJSON Speech{..} = object [ "utterance" .= toJSON speechUtterance
                               , "sentence" .= toJSON speechSentence
                               ]
