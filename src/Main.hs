{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.ByteString.Lazy   as B
import qualified Data.Vector            as V
import qualified Data.Text.Lazy         as T
import           Data.Csv               (HasHeader(..), Header, decodeByName)
import           System.FilePath        ((</>))
import           Web.Scotty
import           Control.Monad.IO.Class
import           Data.Monoid

import           App.Model

main :: IO ()
main = scotty 3000 $ do

    get "/" $ do
        html "Hello World!\n"

    get "/episodes/" $ do
        csv <- liftIO $ getCSV "episode"
        case csv of
            Left err -> html $ "error: " <> T.pack err
            Right (_, vals) -> do
                liftIO $ print $ V.head vals
                let l = V.length vals
                html $ "ok: " <> (T.pack . show) l <> " rows"

getCSV :: String -> IO (Either String (Header, V.Vector Episode))
getCSV name = do
    f <- B.readFile $ "csvs/" </> name ++ ".csv"
    return $ decodeByName f
