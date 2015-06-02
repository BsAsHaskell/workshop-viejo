{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module App.Csv (
    getCSV
  , Data(..)
  ) where

import           Control.Exception
import           Data.Csv
import           System.FilePath      ((</>))
import qualified Data.ByteString.Lazy as B
import qualified Data.Vector          as V

data Data a =
    Data (V.Vector a)
  | Error String
  deriving Show

getCSV :: FromNamedRecord a => String -> IO (Data a)
getCSV name = do
    f <- try . B.readFile $ "csvs/" </> name ++ ".csv"

    case f of
        Left (_ :: IOException) -> return . Error $ "IO Error"
        Right f -> case decodeByName f of
                    Left err -> return $ Error err
                    Right (_, csv) -> return $ Data csv
