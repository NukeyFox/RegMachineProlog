%nth(X,N,L) succeeds if X is the N-th item in list L
nth(X,0,[X|_]).
nth(X,N,[_|T]) :- M is N-1, nth(X,M,T).

%inc(X, N, Y) succeeds if Y is the list which have all the elements equal to X except the Nth element is one greater than that of X.
inc_op([N|T],0,[M|T]) :- M is N+1.
inc_op([H|T],N,[H|U]) :- M is N-1, inc_op(T,M,U).

%dec(X, N, Y, L1, L2, L) succeeds if:
    % both X and Y have 0 in index N and L = L2 (case when R == 0)
    % Y = X - 1, X > 0 and L = L1                      (case when R > 0)
dec_op([0|T],0,[0|T], _, L2, L2).
dec_op([N|T],0,[M|T], L1, _, L1) :- N > 0, M is N-1.
dec_op([H|T],N,[H|U], L1, L2, X) :- M is N-1, dec_op(T,M,U,L1,L2,X).

%nextConfig(Label, Reg, Prog, NextLabel, NextReg) succeeds when inc L1 and DEC L1 L2 instruction blah blah basically (you did the course you know what this is)
nextConfig(L, R, P, L1, R2) :-  nth(inc(I, L1), L, P), inc_op(R, I, R2).                  %inc R_i and jump to L1
nextConfig(L, R, P, NL, R2) :-  nth(dec(I, L1, L2), L, P), dec_op(R, I, R2, L1, L2, NL).  %dec R_i and jump to L1 (R_i > 0)

%step(L, R, P, R2) succeeds if R2 is the list of registers that halts starting from registers initial configuation (L, R) on program P
step(L, R, P, R) :- nth(hALT, L, P).      % NB: HALT instruction is written as hALT since halt was taken.
step(L, R, P, R) :- length(P,X), L >= X.  % For erroneous halts. 
step(L, R, P, R2) :- nextConfig(L, R, P, L1, R1), !, step(L1, R1, P, R2).

%compute(Reg, Prog, ResReg) succeeds if ResReg is the final configuration on running program Prog on initial registers Reg (basicall a wrapper for step)
compute(R, P, R1) :- step(0, R, P, R1).

% Try out these queries:
% 1. incition (0,x,y) -> (x+y,0,0)
%       compute([0,3,2],[dec(1,1,2), inc(0,0), dec(2,3,4), inc(0,2),hALT],X).
% 2. Truncated dectraction (0,x,y) -> (x-y,0,0)
%       compute([0,19,4],[dec(1,1,2),inc(0,0),dec(2,3,4),dec(0,2,4),hALT],X).
% 3. Power of 2 (0,x,0) -> (2^x,0,0)
%       compute([0,8,0],[inc(0,1),dec(1,2,7),dec(0,3,5),inc(2,4),inc(2,2),dec(2,6,1),inc(0,5),hALT],X)