{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.Vector            as V
import qualified Data.Text.Lazy         as T
import           Web.Scotty
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
            Error err -> html $ "error: " <> T.pack err
            Data vals -> do
                liftIO $ print $ V.head vals
                let l = V.length vals
                html $ "ok: " <> (T.pack . show) l <> " rows\n"

    get "/utterances/" $ do
        csv <- liftIO $ (getCSV "utterance" :: IO (Data Utterance))
        case csv of
            Error err -> html $ "error: " <> T.pack err
            Data vals -> do
                liftIO $ print $ V.head vals
                let l = V.length vals
                html $ "ok: " <> (T.pack . show) l <> " rows\n"

    get "/sentences/" $ do
        csv <- liftIO $ (getCSV "sentence" :: IO (Data Sentence))
        case csv of
            Error err -> html $ "error: " <> T.pack err
            Data vals -> do
                liftIO $ print $ V.head vals
                let l = V.length vals
                html $ "ok: " <> (T.pack . show) l <> " rows\n"
