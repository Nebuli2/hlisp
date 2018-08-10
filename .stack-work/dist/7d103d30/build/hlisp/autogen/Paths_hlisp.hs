{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_hlisp (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\bwhet\\haskell-workspace\\hlisp\\.stack-work\\install\\620260b6\\bin"
libdir     = "C:\\Users\\bwhet\\haskell-workspace\\hlisp\\.stack-work\\install\\620260b6\\lib\\x86_64-windows-ghc-8.4.3\\hlisp-0.1.0.0-B2Icz68iT9E7HtITCYDrcy-hlisp"
dynlibdir  = "C:\\Users\\bwhet\\haskell-workspace\\hlisp\\.stack-work\\install\\620260b6\\lib\\x86_64-windows-ghc-8.4.3"
datadir    = "C:\\Users\\bwhet\\haskell-workspace\\hlisp\\.stack-work\\install\\620260b6\\share\\x86_64-windows-ghc-8.4.3\\hlisp-0.1.0.0"
libexecdir = "C:\\Users\\bwhet\\haskell-workspace\\hlisp\\.stack-work\\install\\620260b6\\libexec\\x86_64-windows-ghc-8.4.3\\hlisp-0.1.0.0"
sysconfdir = "C:\\Users\\bwhet\\haskell-workspace\\hlisp\\.stack-work\\install\\620260b6\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hlisp_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hlisp_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "hlisp_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "hlisp_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hlisp_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hlisp_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
