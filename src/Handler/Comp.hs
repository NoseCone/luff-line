{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Handler.Comp where

import Control.Monad.IO.Class  (liftIO)
import Data.Aeson (Value (Object, String))
import Data.Aeson (encode, object, (.=))
import Data.Aeson.Parser (json)
import Data.Conduit (($$+-))
import Data.Conduit.Attoparsec (sinkParser)
import Network.HTTP.Simple
import qualified Data.Text as T

import Import
import WireTypes.Comp

getCompR :: Text -> Handler Html
getCompR compPrefix = do
    tasks :: [Task] <- getCompTasks compPrefix
    defaultLayout $(widgetFile "tasks")

getCompTasks :: Text -> Handler [Task]
getCompTasks compPrefix = do
    req :: Request <- liftIO $ parseRequest ("http://" ++ T.unpack compPrefix ++ ".flaretiming.com/json/comp-input/tasks.json")
    res <- httpJSON req
    pure $ getResponseBody res