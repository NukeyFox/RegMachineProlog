Usage:

?- compute(Registers, Prolog, Output). 

Instructions clauses come in three flavours:
inc(R, L)          = increment register R's content and jump to instruction labelled L
dec(R, L1, L2)     = if register R > 0, decrement R's contents and jump to instruction labelled L2, 
                        or if R == 0, jump to instruction labelled L2
hALT               = halts the program. (halt is a keyword in Prolog so I couldn't use it)

So for example, `compute([0,3,2], [dec(1,1,2), inc(0,0), dec(2,3,4), inc(0,2),hALT], X).` 
You can *try* to search for programs (`compute([0,1], X, [1,0])`) but its almost guaranteed to crash or loop forever. 
