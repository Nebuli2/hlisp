module Main where

import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment
import Control.Monad

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

optionalSpaces :: Parser ()
optionalSpaces = skipMany space

spaces :: Parser ()
spaces = skipMany1 space

data Expression
  = List [Expression]
  | Number Double
  | String String
  | Bool Bool
  | Atom String

instance Show Expression where
  show (Number n) = show n
  show (String s) = "\"" ++ s ++ "\""
  show (Bool True) = "#t"
  show (Bool False) = "#f"
  show (Atom a) = a
  show (List xs) = "(" ++ (unwords . map show) xs ++ ")"

parseString :: Parser Expression
parseString = do
  char '"'
  x <- many (noneOf "\"")
  char '"'
  return $ String x

parseAtom :: Parser Expression
parseAtom = do
  first <- letter <|> symbol
  rest <- many (letter <|> digit <|> symbol)
  let atom = first : rest
  return $ case atom of
    "#t" -> Bool True
    "#f" -> Bool False
    atom -> Atom atom

parseNumber :: Parser Expression
parseNumber = liftM (Number . read) $ many1 digit

parseListInterior :: Parser Expression
-- parseListInterior = liftM List $ many (parseExpression <* spaces)
parseListInterior = liftM List $ sepBy parseExpression spaces

parseQuote :: Parser Expression
parseQuote = do
  char '\''
  x <- parseExpression
  return $ List [Atom "quote", x]

parseList :: Parser Expression
parseList = do
  char '('
  optionalSpaces
  x <- parseListInterior
  optionalSpaces
  char ')'
  return x

parseExpression :: Parser Expression
parseExpression = parseAtom
  <|> parseString
  <|> parseNumber
  <|> parseQuote
  <|> parseList

main :: IO ()
main = do
  putStrLn "Enter an expression:"
  line <- getLine
  let expr = parse parseExpression "lisp" line
  case expr of
    Right x -> print x
    Left err -> putStrLn $ "Error: " ++ show err
  main
