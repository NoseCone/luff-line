{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Comps where

import Import

getCompsR :: Handler Html
getCompsR = defaultLayout $(widgetFile "comps")

getCompR :: Text -> Handler Html
getCompR compPrefix = do
    defaultLayout $(widgetFile "tasks")