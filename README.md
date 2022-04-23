### Register machine interpreter implementation in Prolog

Usage:

?- `compute(Registers, Program, Output).`

?- `computeFromFile(Filename, Registers, Output).`

Instructions clauses come in three flavours:
- `inc(R, L)`          = increment register R's content and jump to instruction labelled L
- `dec(R, L1, L2)`     = if register R > 0, decrement R's contents and jump to instruction labelled L1, 
                        or if R == 0, jump to instruction labelled L2
- `hALT`               = halts the program. ( halt is a keyword in Prolog so I couldn't use it :C )

The files which can be read as register machine programs are a list of Prolog clauses and are `.pl` files themselves.
For example, a program to compute f(x,y) = x+y `addition.pl` would be:
```
dec(1,1,2).
inc(0,0).
dec(2,3,4).
inc(0,2).
hALT.
```

You can *try* to search for programs (e.g. `compute([0,1], X, [1,0])`) but its almost guaranteed to crash or loop forever. 

