{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.Vector            as V
import qualified Data.Text.Lazy         as T
import           Web.Scotty
import           Control.Applicative
import           Control.Monad.IO.Class
import           Data.Monoid

import           App.Model
import           App.Csv

main :: IO ()
main = scotty 3000 $ do

    get "/" $ do
        html "Hello World!\n"

    get "/episodes/" $ do
        csv <- liftIO $ (getCSV "episode" :: IO (Data Episode))
        case csv of
            Left err -> html $ "error: " <> T.pack err
            Right vals -> do
                let l = V.length vals
                html $ "ok: " <> (T.pack . show) l <> " rows\n"

    get "/episodes/:id" $ do
        csv <- liftIO $ (getCSV "episode" :: IO (Data Episode))
        id' <- param "id"
        case csv of
            Left err -> html $ "error: " <> T.pack err
            Right vals -> do
                let l = V.find (\x -> episodeId x == id') vals
                html $ "ok: " <> (T.pack . show) l <> "\n"

    get "/speech/:speaker" $ do
        sentences <- liftIO $ (getCSV "sentence" :: IO (Data Sentence))
        utterances <- liftIO $ (getCSV "utterance" :: IO (Data Utterance))

        spk' <- param "speaker"
        case (,) <$> sentences <*> utterances of
            Left err -> html $ "error: " <> T.pack err
            Right (ss, us) -> do
                let findSentece uid = case V.find (\s -> sentenceUtterance s == uid) ss of
                                        Just v -> v
                                        Nothing -> error "welp"
                let join u l = Speech u (findSentece $ utteranceId u) : l
                let us' = V.filter (\u -> utteranceSpeaker u == spk') us
                let speech = V.foldr' join [] us'

                html $ "ok: " <> (T.pack . show) speech <> "\n"
