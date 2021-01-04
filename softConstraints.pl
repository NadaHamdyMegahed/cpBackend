:- use_module(library(clpfd)).
:-include("soft1.pl").
:-include("soft2.pl").

checkSoftConstraints([H|T],Floor):-
checkAppartment(H,Floor),
checkSoftConstraints(T,Floor).

checkSoftConstraints([],_).

checkAppartment([Rooms,C1,S1,C2,S2,R1,R2,Value,Sign,_,0,_,0],Floor):-
% softe constraint 1
applySoft1(C1,S1,Rooms,Floor),
%soft constraint 2
checkDistanceBetween2Rooms(C2,S2,R1,R2,Value,Sign).
%soft constraint 3
%soft constraint 4.

