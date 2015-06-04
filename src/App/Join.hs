{-# LANGUAGE OverloadedStrings #-}
module App.Join (
    speechJoin
  , wordFreq
  ) where

import qualified Data.Map.Strict  as S
import qualified Data.IntMap.Lazy as M
import qualified Data.Vector      as V
import           Data.List
import           Data.Char

import           App.Model

-- | Asocia un Vector de 'Utterance' y uno de 'Sentence'
-- generando un mapa del segundo e iterando por el primero.
speechJoin :: V.Vector Sentence -> V.Vector Utterance -> [Speech]
speechJoin ss us = V.foldr' join [] us
  where
    dict = M.fromAscList . map toTuple . V.toList $ ss
    toTuple s = (sentenceId s, s)
    join u l = Speech u (getS $ utteranceId u) : l
    getS uid = case M.lookup uid dict of
        Just v -> v
        Nothing -> error "welp"


wordFreq :: [Speech] -> S.Map String Int
wordFreq = analyze . corpus
  where
    corpus = concatMap (\s -> sentenceText $ speechSentence s)
    analyze = mapify . tokenize
    tokenize = words . map (toLower . spacify)
    spacify c = if isPunctuation c then ' ' else c
    mapify = foldl' (\m k -> S.insertWith (+) k 1 m) S.empty
