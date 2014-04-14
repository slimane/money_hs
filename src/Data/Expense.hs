--module Data.Expense(
--                  Expense
--                  , ExpensesKind
--                  , insertExpense
--                  , amount
--                ) where


import qualified Data.Time as T
import qualified Data.List as L

data ExpensesKind = Food
                  | Sweet
                  | Gum
                  | Wear
                  | Manga
                  | TechBook
                  | Phoen
                  | Electric
                  | Electricity
                  | Transportation
                  | Gas
                  | Water
                  | Internet
                  | Cleaning
                  deriving (Show, Eq, Ord, Read, Enum, Bounded)


data Expense = Expense{date :: T.ZonedTime
                      , name :: String
                      , price :: Double
                      , kind :: ExpensesKind}
                      deriving (Show, Eq, Ord)


instance Eq T.ZonedTime where
  x == y = T.zonedTimeToUTC x == T.zonedTimeToUTC y

instance Ord T.ZonedTime where
  x `compare` y = T.zonedTimeToUTC x `compare` T.zonedTimeToUTC y


amount :: [Expense] -> Double
amount  = L.foldl' (+) 0 . map price


insertExpense :: IO Expense
insertExpense = do
      d <- T.getZonedTime
      putStrLn "name is"
      n <- getLine
      p <- prompt "price" :: IO Double
      let kinds = L.foldl' (++) "" . map ((" " ++) . show) $ ([minBound..maxBound] :: [ExpensesKind])
      k <- prompt $ "kind(" ++ kinds ++ ")" :: IO ExpensesKind
      return Expense{date = d, name = n, price = p, kind = k}
    where
      prompt s = do
        putStrLn $ s ++ " is"
        ss <- getLine
        return $ read ss


main :: IO ()
main = do
  --houji <- insertExpense "ほうじちゃ" 106 Food
  --uron <- insertExpense "ウーロン茶" 106 Food
  --lemon <-  insertExpense "レモンガム" 103 Gum
  --kogane <- insertExpense "はこだて黄金" 307 Food

  --mapM_ (putStrLn . show) . L.sort $ [houji, uron, lemon, kogane]
  --putStrLn . show $ amount [uron, lemon]
  a <- insertExpense
  putStrLn . show $ a
