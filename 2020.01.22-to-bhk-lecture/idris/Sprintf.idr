-- Originally developed at a solution to the kata at codewars:
-- https://www.codewars.com/kata/5c7fe5c859036f142eccaabb

module Sprintf

%access export
%default total

namespace SideThought

  public export total
  SprintfType : List Char -> Type
  SprintfType []                   =            String
  SprintfType ('%' :: '%' :: rest) =            SprintfType rest
  SprintfType ('%' :: 'd' :: rest) = Integer -> SprintfType rest
  SprintfType ('%' :: 'f' :: rest) = Double  -> SprintfType rest
  SprintfType ('%' :: 'c' :: rest) = Char    -> SprintfType rest
  SprintfType ('%' :: rest)        = Void    -> SprintfType rest
  SprintfType (_   :: rest)        =            SprintfType rest

public export
strToSty : (curr : String) -> (str : List Char) -> (t : Type ** t)
strToSty c []             = (_ ** c)
strToSty c ('%'::'%'::ks) = strToSty (c ++ "%") ks
strToSty c ('%'::'d'::ks) = (_ ** \n : Integer => snd $ strToSty (c ++ show n) ks)
strToSty c ('%'::'f'::ks) = (_ ** \x : Double  => snd $ strToSty (c ++ show x) ks)
strToSty c ('%'::'c'::ks) = (_ ** \k : Char    => snd $ strToSty (c ++ singleton k) ks)
strToSty c ('%':: ks)     = (_ ** \v : Void    => snd $ strToSty c ks)
strToSty c ( k :: ks)     = strToSty (c ++ singleton k) ks

sprintf : (str : String) -> fst $ strToSty "" $ unpack str
sprintf str = snd $ strToSty "" $ unpack str
