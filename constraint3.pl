:- use_module(library(clpfd)).


genrateCorridors(0,[]).
genrateCorridors(N,[c(_,3,_,3,N)|T]):-
N>0,
N2 #= N-1,
genrateCorridors(N2,T).



corridorAdjToHallway(c(X1,W1,Y1,L1,_),[room(X2,Y2,_,W2,L2,_,_,_,_)|_]):-
adjacent(X1,Y1,W1,L1,X2,Y2,W2,L2).
corridorAdjToHallway(C,[_,T]):-
corridorAdjToHallway(C,T).

corridorsAdjToAppartments([C1|Tc],A):-
A=[[Rooms|_]|Ta],
corridorAdjToHallway(C1,Rooms),
corridorsAdjToAppartments(Tc,Ta).

corridorsAdjToAppartments([],_).

corridorAdToOneCorridor(c(X1,W1,Y1,L1,Id1),[c(X2,W2,Y2,L2,Id2)|_]):-
Id1\=Id2,
adjacent(X1,Y1,W1,L1,X2,Y2,W2,L2).
corridorAdToOneCorridor(C,[_|T2]):-
corridorAdToOneCorridor(C,T2).

corridorsAdjToEachOthers([],_).

corridorsAdjToEachOthers([C|Tc],Corridors):-
corridorAdToOneCorridor(C,Corridors),
corridorsAdjToEachOthers(Tc,Corridors).

corridorsAdjToEachOthers2([_]).

corridorsAdjToEachOthers2([C1,C2|T]):-
C1=c(X1,W1,Y1,L1,_),C2=c(X2,W2,Y2,L2,_),
adjacent(X1,Y1,W1,L1,X2,Y2,W2,L2),
corridorsAdjToEachOthers2([C2|T]).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elevAdjToCorr(e(X1,W1,Y1,L1),[c(X2,W2,Y2,L2,_)|_]):-
adjacent(X1,Y1,W1,L1,X2,Y2,W2,L2).

elevAdjToCorr(E,[_|T]):-
elevAdjToCorr(E,T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
checkCorridors(Corridors,Appartments,Elevator):-
length(Appartments,N),
write(1),nl,
genrateCorridors(N,Corridors),
write(2),nl,
corridorsAdjToAppartments(Corridors,Appartments),
write(3),nl,
corridorsAdjToEachOthers2(Corridors),
write(4),nl,
elevAdjToCorr(Elevator,Corridors).


