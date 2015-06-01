{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.ByteString.Lazy   as B
import qualified Data.Vector            as V
import qualified Data.Text.Lazy         as T
import           Data.Csv               (HasHeader(..), decode)
import           System.FilePath        ((</>))
import           Web.Scotty
import           Control.Monad.IO.Class
import           Data.Monoid

main :: IO ()
main = scotty 3000 $ do

    get "/" $ do
        html "Hello World!\n"

    get "/episodes/" $ do
        csv <- liftIO $ getCSV "episode"
        case csv of
            Left err -> html $ "error: " <> T.pack err
            Right vals -> do
                liftIO $ print $ V.head vals
                let l = V.length vals
                html $ "ok: " <> (T.pack . show) l <> " rows"

getCSV :: String -> IO (Either String (V.Vector [B.ByteString]))
getCSV name = do
    f <- B.readFile $ "csvs/" </> name ++ ".csv"
    return $ decode HasHeader f
