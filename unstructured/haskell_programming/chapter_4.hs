isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x = x == reverse x

myAbs :: Integer -> Integer
myAbs x = if x < 0 then (-x) else x

x = (+)

f xs = w `x` 1
  where w = length xs

myId = \x -> x

myFirst = \(x:xs) -> x

myFst (a,_) = a
