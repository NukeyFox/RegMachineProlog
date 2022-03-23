nth(X,0,[X|_]).
nth(X,N,[_|T]) :- M is N-1, nth(X,M,T).

inc_op([N|T],0,[M|T]) :- M is N+1.
inc_op([H|T],N,[H|U]) :- M is N-1, inc_op(T,M,U).

dec_op([0|T],0,[0|T], _, L2, L2).
dec_op([N|T],0,[M|T], L1, _, L1) :- N > 0, M is N-1.
dec_op([H|T],N,[H|U], L1, L2, X) :- M is N-1, dec_op(T,M,U,L1,L2,X).

nextConfig(L, R, P, L1, R2) :-  nth(inc(I, L1), L, P), inc_op(R, I, R2).                  
nextConfig(L, R, P, NL, R2) :-  nth(dec(I, L1, L2), L, P), dec_op(R, I, R2, L1, L2, NL).  

step(L, R, P, R) :- nth(hALT, L, P).      
step(L, R, P, R) :- length(P,X), L >= X.  
step(L, R, P, R2) :- nextConfig(L, R, P, L1, R1), !, step(L1, R1, P, R2).

compute(R, P, R1) :- step(0, R, P, R1).