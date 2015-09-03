{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.Text.Lazy.IO      as T
import qualified Data.Vector            as V
import qualified Data.Map.Strict        as S
import           Web.Scotty
import           Control.Applicative
import           Control.Monad.IO.Class
import           Data.Monoid

import           Network.Wai.Middleware.RequestLogger

import           App.Model
import           App.Csv
import           App.Json

main :: IO ()
main = scotty 3000 $ do

    middleware logStdoutDev

    get "/" $ do
        f <- liftIO $ T.readFile $ "web" </> "index.html"
        html f

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
