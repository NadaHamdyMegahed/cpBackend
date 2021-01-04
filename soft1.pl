:- use_module(library(clpfd)).

%room(X,Y,Min,W,L,A,T,Assign,Id)

allRoomsExposedToLightening([],_).

allRoomsExposedToLightening([R|Tail],Floor):-
isExposedToLight(R,Floor),
allRoomsExposedToLightening(Tail,Floor).


%not required
applySoft1(0,0,_,_).

%required and satisfied
applySoft1(1,1,Rooms,Floor):-
allRoomsExposedToLightening(Rooms,Floor).

%required but not satisfied
applySoft1(1,0,_,_).