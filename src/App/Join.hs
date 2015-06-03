{-# LANGUAGE OverloadedStrings #-}
module App.Join (
    speechJoin
  ) where

import qualified Data.IntMap.Lazy as M
import qualified Data.Vector      as V
import           App.Model

speechJoin :: V.Vector Sentence -> V.Vector Utterance -> [Speech]
speechJoin ss us = V.foldr' join [] us
  where
    dict = M.fromAscList . map toTuple . V.toList $ ss
    toTuple s = (sentenceId s, s)
    join u l = Speech u (getS $ utteranceId u) : l
    getS uid = case M.lookup uid dict of
        Just v -> v
        Nothing -> error "welp"
