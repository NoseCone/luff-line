let ghc-opts = [ "-Wall", "-Wtabs" ]

in  { name = "luff-line"
    , version = "0.0.0"
    , dependencies =
      [ "base >=4.9.1.0 && <5"
      , "aeson >=1.4 && <2.3"
      , "bytestring >=0.10 && <0.13"
      , "case-insensitive"
      , "classy-prelude >=1.5 && <1.6"
      , "classy-prelude-conduit >=1.5 && <1.6"
      , "classy-prelude-yesod >=1.5 && <1.6"
      , "conduit >=1.0 && <2.0"
      , "containers"
      , "data-default"
      , "directory >=1.1 && <1.4"
      , "fast-logger >=2.2 && <3.3"
      , "file-embed"
      , "foreign-store"
      , "hjsmin >=0.1 && <0.3"
      , "http-client-tls >=0.3 && <0.4"
      , "http-conduit >=2.3 && <2.4"
      , "monad-control >=0.3 && <1.1"
      , "monad-logger >=0.3 && <0.4"
      , "safe"
      , "shakespeare >=2.0 && <2.2"
      , "template-haskell"
      , "text >=0.11 && <2.2"
      , "time"
      , "unordered-containers"
      , "vector"
      , "wai"
      , "wai-extra >=3.0 && <3.2"
      , "wai-logger >=2.2 && <2.6"
      , "warp >=3.0 && <3.5"
      , "yaml >=0.11 && <0.12"
      , "yesod >=1.6 && <1.7"
      , "yesod-core >=1.6 && <1.7"
      , "yesod-form >=1.6 && <1.8"
      , "yesod-static >=1.6 && <1.7"
      ]
    , library =
      { source-dirs = "src"
      , when =
        { condition = "(flag(dev)) || (flag(library-only))"
        , `then` =
          { ghc-options = ghc-opts # [ "-O0" ]
          , cpp-options = [ "-DDEVELOPMENT" ]
          }
        , `else` =
          { ghc-options = ghc-opts # [ "-O2" ], cpp-options = [] : List Text }
        }
      }
    , executables.luff-line
      =
      { main = "main.hs"
      , source-dirs = "app"
      , ghc-options = [ "-threaded", "-rtsopts", "-with-rtsopts=-N" ]
      , dependencies = "luff-line"
      , when = { condition = "flag(library-only)", buildable = False }
      }
    , tests.luff-line-test
      =
      { main = "Spec.hs"
      , source-dirs = "test"
      , ghc-options = "-Wall"
      , dependencies = [ "luff-line", "hspec >=2.0.0", "yesod-test" ]
      }
    , flags =
      { dev =
        { description =
            "Turn on development settings, like auto-reload templates."
        , manual = False
        , default = False
        }
      , library-only =
        { description = "Build for use with \"yesod devel\""
        , manual = False
        , default = False
        }
      }
    }
