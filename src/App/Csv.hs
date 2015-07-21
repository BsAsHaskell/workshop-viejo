{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module App.Csv (
    getCSV
  , Data(..)
  , (</>)
  ) where

import           Control.Applicative
import           Control.Exception
import           Data.Csv
import           System.FilePath      ((</>))
import qualified Data.ByteString.Lazy as B
import qualified Data.Vector          as V

import           App.Model

type Data a = Either String (V.Vector a)

getCSV :: FromNamedRecord a => String -> IO (Data a)
getCSV name = do
    f <- try . B.readFile $ "csvs/" </> name ++ ".csv"

    case f of
        Left (_ :: IOException) -> return . Left $ "IO Error"
        Right f -> case decodeByName f of
                    Left err -> return $ Left err
                    Right (_, csv) -> return $ Right csv

instance FromNamedRecord Episode where
    parseNamedRecord m = Episode <$>
        m .: "id" <*>
        m .: "season_number" <*>
        m .: "episode_number" <*>
        m .: "title" <*>
        m .: "the_date" <*>
        m .: "writer" <*>
        m .: "director"

instance FromNamedRecord Utterance where
    parseNamedRecord m = Utterance <$>
        m .: "id" <*>
        m .: "episode_id" <*>
        m .: "utterance_number" <*>
        m .: "speaker"

instance FromNamedRecord Sentence where
    parseNamedRecord m = Sentence <$>
        m .: "id" <*>
        m .: "utterance_id" <*>
        m .: "sentence_number" <*>
        m .: "text"
