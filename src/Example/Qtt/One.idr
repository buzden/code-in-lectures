module Example.Qtt.One

%default total

---------------------------------
--- File remove grant example ---
---------------------------------

namespace FileRemoveGrantExample

  data File : Type where [external]

  data RmGrant : File -> Type where [external]

  wantToRemove : (fl : File) -> IO $ Maybe $ RmGrant fl
  remove : RmGrant fl -> IO ()

  readFileFromUser : IO File

  whatever : IO Bool
  whatever = do
    fl <- readFileFromUser
    Just rm <- wantToRemove fl
      | Nothing => pure False
    remove rm
    pure True

--------------------------------
--- Handle closing liability ---
--------------------------------

namespace HandleClosingLiability

  data File : Type where [external]

  data ClosingLia : File -> Type where [external]

  openFile  : (fl : File) -> IO $ Maybe $ ClosingLia fl
  readChar  : (fl : File) -> (0 _ : ClosingLia fl) => IO Char
  closeFile : ClosingLia h -> IO ()

  whatever : File -> IO $ Either String Char
  whatever fl = do
    Just cl <- openFile fl
      | Nothing => pure $ Left "Can't open"
    c <- readChar fl
    closeFile cl
    pure $ Right c

----------------------
--- First examples ---
----------------------

namespace AppendList

  data List' : Type -> Type where
    Nil  : List' a
    (::) : (1 _ : a) -> (1 _ : List' a) -> List' a

  append : (1 _ : List' a) -> (1 _ : List' a) -> List' a
  append []      ys = ys
  append (x::xs) ys = x :: append xs ys

  null : (_ : List' a) -> Bool
  null []     = True
  null (_::_) = False

-----------------------------------
--- Entering the linear context ---
-----------------------------------

namespace EnterLin

  data Params = MkParams
  data Result = MkResult

  data Resource : Type where
    [noHints]
    MkResource : (1 _ : Nat) -> Resource

  data LPair' : Type -> Type -> Type where
    (#) : a -> (1 _ : b) -> LPair' a b

  namespace ResultMark

    public export
    1 create : Params -> Resource
    create MkParams = MkResource 3

  namespace WrappingFunction

    runWithCreated : Params -> (1 _ : (1 _ : Resource) -> a) -> a
    runWithCreated MkParams f = f $ MkResource 3

  depend : (1 _ : Resource) -> LPair' Result Resource
  depend r = (MkResult # r)

  destroy : (1 _ : Resource) -> Result
  destroy $ MkResource Z     = MkResult
  destroy $ MkResource (S n) = MkResult
