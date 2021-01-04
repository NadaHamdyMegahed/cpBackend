:- use_module(library(clpfd)).



%%%%%%%%%%%%%%%%%%%%%%%%%%assigned rooms adj

% assigned rooms are adjacent to each other
% A = 0 if room has no assigned room 
% incase of a dining room assign it automatically to same A of kitchen to handle last hard constraint 

adjAssignedHelper(room(X1,Y1,_,W1,L1,_,_,A,ID1),
[room(X2,Y2,_,W2,L2,_,_,A,ID2)|_]):-
A#\=0,
ID1#\=ID2,
adjacent(X1,Y1,W1,L1,X2,Y2,W2,L2).
 
adjAssignedHelper(room(X,Y,M,W,L,A,T,A1,ID1),
[room(_,_,_,_,_,_,_,A2,ID2)|Tail]):-
A1#\=0,
A1#\=A2;ID1#=ID2,
adjAssignedHelper(room(X,Y,M,W,L,A,T,A1,ID1),Tail).

% not assigned to any thing a
adjAssignedHelper(room(_,_,_,_,_,_,_,0,_),_).

% all assigned rooms are adjacent 
allAssignedAdjHelper([],_).
allAssignedAdjHelper([H|T],Rooms):-
adjAssignedHelper(H,Rooms),
allAssignedAdjHelper(T,Rooms),!.

allAdjacent(Rooms):-
allAssignedAdjHelper(Rooms,Rooms).

checkAppAdj([]).
checkAppAdj([[Rooms|_]|T]):-
allAdjacent(Rooms),
checkAppAdj(T).