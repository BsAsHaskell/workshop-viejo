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

    get "/sentences/:speaker" $ do
        sentences <- liftIO $ (getCSV "sentence" :: IO (Data Sentence))
        utterances <- liftIO $ (getCSV "utterance" :: IO (Data Utterance))

        spk' <- param "speaker"
        case (,) <$> sentences <*> utterances of
            Left err -> html $ "error: " <> T.pack err
            Right (s, u) -> do
                let u' = V.filter (\x -> utteranceSpeaker x == spk') u
                html $ "ok: " <> (T.pack . show) u' <> "\n"
