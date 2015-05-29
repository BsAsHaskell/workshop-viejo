{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Csv               (HasHeader(..), decode)
import Data.ByteString.Lazy   as B
import Data.Vector            as V (Vector(..), take)
import Data.Aeson             (object, (.=))
import System.FilePath        ((</>))
import Web.Scotty
import Control.Monad.IO.Class

main :: IO ()
main = scotty 3000 $ do

    get "/" $ do
        html "Hello World!\n"

    get "/episodes/" $ do
        csv <- liftIO $ getCSV "episode"
        case csv of
            Left err -> json $ object ["error" .= err]
            Right vals -> do
                liftIO $ print $ V.take 10 vals
                json $ object ["ok" .= ("yes" :: String)]

getCSV :: String -> IO (Either String (Vector (Vector ByteString)))
getCSV name = do
    f <- B.readFile $ "csvs/" </> name ++ ".csv"
    return $ decode HasHeader f
