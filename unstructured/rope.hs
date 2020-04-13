type Offset = Int

data Rope
  = Branch Rope Rope Offset
  | Leaf Int String

empty_rope :: Rope
empty_rope = Leaf 0 ""

singleton_rope :: Rope
singleton_rope = Leaf 1 "a"

concat_rope :: Rope
concat_rope = Branch l r 1
  where
    l = Leaf 1 "a"
    r = Leaf 1 "b"

char_at :: Rope -> Int -> Char
char_at (Leaf len str) i = head . drop i $ str
char_at (Branch left right offset) i
  | i < offset = char_at left i
  | otherwise  = char_at right i'
  where i' = i - offset

main = do
  putStrLn . show $ char_at concat_rope 0
  putStrLn . show $ char_at concat_rope 1
  putStrLn . show $ char_at singleton_rope 0
