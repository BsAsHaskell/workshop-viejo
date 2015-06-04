{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.Vector            as V
import           Web.Scotty
import           Control.Applicative
import           Control.Monad.IO.Class
import           Data.Monoid

import           App.Model
import           App.Csv
import           App.Join
import           App.Json

main :: IO ()
main = scotty 3000 $ do

    get "/" $ do
        html "Hello World!\n"

    get "/episodes/" $ do
        csv <- liftIO $ (getCSV "episode" :: IO (Data Episode))
        case csv of
            Left err -> json $ jsonError err
            Right vals -> do
                json $ vals

    get "/episodes/:id" $ do
        csv <- liftIO $ getCSV "episode"
        id' <- param "id"
        case csv of
            Left err -> json $ jsonError err
            Right vals -> do
                let l = V.find (\x -> episodeId x == id') vals
                json $ l

    get "/speech/:speaker" $ do
        sentences <- liftIO $ getCSV "sentence"
        utterances <- liftIO $ getCSV "utterance"

        spk' <- param "speaker"
        case (,) <$> sentences <*> utterances of
            Left err -> json $ jsonError err
            Right (ss, us) -> do
                let us' = V.filter (\u -> utteranceSpeaker u == spk') us
                let speech = speechJoin ss us'

                json $ speech

    get "/wordfreq/:speaker" $ do
        sentences <- liftIO $ getCSV "sentence"
        utterances <- liftIO $ getCSV "utterance"

        spk' <- param "speaker"
        case (,) <$> sentences <*> utterances of
            Left err -> json $ jsonError err
            Right (ss, us) -> do
                let us' = V.filter (\u -> utteranceSpeaker u == spk') us
                let speech = speechJoin ss us'
                let word_freqs = wordFreq speech

                json $ word_freqs
