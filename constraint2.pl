:- use_module(library(clpfd)).

% count number of hallways
countHallWays([],0).

countHallWays([room(_,_,_,_,_,_,h,_,_)|T],N):-
countHallWays(T,N1),
N is N1+1.

countHallWays([room(_,_,_,_,_,_,Type,_,_)|T],N):-
Type\=h,
countHallWays(T,N).



% at least adj to one other hallways
adjToOneHallWay(room(X1,Y1,_,W1,L1,_,_,_,Id1),[room(X2,Y2,_,W2,L2,_,h,_,Id2)|_]):-
Id1\=Id2,adjacent(X1,Y1,W1,L1,X2,Y2,W2,L2).
adjToOneHallWay(R,[_|T]):-
adjToOneHallWay(R,T).

% all hallways and rooms are adjacent

allHallwaysAdj(Rooms):-allHallwaysAdjHelper(Rooms,Rooms).

allHallwaysAdjHelper([],_).

allHallwaysAdjHelper([R|T],AllRooms):-
R=room(_,_,_,_,_,_,h,_,_),
countHallWays(AllRooms,1),
allHallwaysAdjHelper(T,AllRooms).

allHallwaysAdjHelper([R|T],AllRooms):-
adjToOneHallWay(R,AllRooms),
allHallwaysAdjHelper(T,AllRooms).


%%%%
checkAllHallways([[Rooms|_]|T]):-
allHallwaysAdj(Rooms),checkAllHallways(T).
checkAllHallways([]).