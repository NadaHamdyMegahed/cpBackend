:- use_module(library(clpfd)).

%%%%%%%%%%%%%%% not over lapping %%%%%%%%%
%%%%%%%% using disjoint%%%%%%%%%%%%%%%%

%%%%%%%%%% get Rooms Functor%%%%%%%%%%%

getAllRoomsFromApp([],[]).
getAllRoomsFromApp([[R|_]|T],T3):-
append(R,T2,T3),
getAllRoomsFromApp(T,T2).

getOneRoomFunctor(room(X, Y, _, W, L, _, _, _, _),r(X,W,Y,L)).

getRoomFunctors([],[]).
getRoomFunctors([H1|T1],[H2|T2]):-
getOneRoomFunctor(H1,H2),
getRoomFunctors(T1,T2).


getRoomFuncsFromApps(L,F):-
getAllRoomsFromApp(L,L2),
getRoomFunctors(L2,F).


%%%%%%%%%%%%%%% get Collidors Functor %%%%%%%%%%
getCorridorsFunctors(C,F):-
setof(c(X,W,Y,L),(Id^member(c(X,W,Y,L,Id),C)),F).

%%%%%%%%%%%%%%%%% get ducts functor %%%%%%%%%%%
% so far ducts already functors

%%%%%%%%%%%%% the main costraint 1 %%%%%%%%%%%%%

notOverLapping(Appartments,Corridors,Ducts,E):-
getRoomFuncsFromApps(Appartments,RoomsF),
getCorridorsFunctors(Corridors,CorridorsF),
flatten([RoomsF,CorridorsF,Ducts,[E]],L),
disjoint2(L).