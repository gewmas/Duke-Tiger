LetExp([
 VarDec(N,true,NONE,
  IntExp(8)),
 FunctionDec[
  (printboard,[],
NONE,
   ForExp(
i,true,
    IntExp(0),
    OpExp(MinusOp,
     VarExp(
      SimpleVar(N)),
     IntExp(1)),
    CallExp(print,[
     StringExp(" O .")])))]],
 SeqExp[
  CallExp(printboard,[])])
