:- use_module(library(clpfd)).
% sun room adjacent to source of sun light
% S=0 no light S=1or2 means sunlight 
% 1 open source 2 landscapes
% S can be 0-> neither nor 1-> landscape 2->openareas
%          _S1_
%       s2|_s3_|s4
% adjacent to s1==>Y=0 S3==>Y=length s2==>x=0 s4==>x=w
% assume that daylight means openarea or landscape

%floor(W,L,S1,S2,S3,S4)

%[room(Rx,Ry,MinArea,Width,Length,Area,Type,Assign,Id)]-->[r(Rx,Width,Ry,Length)]
isExposedToLight(room(_,0,_,_,_,_,_,_,_),floor(_,_,S1,_,_,_)):-
S1#\=0.

isExposedToLight(room(0,_,_,_,_,_,_,_,_),floor(_,_,_,S2,_,_)):-
S2#\=0.

isExposedToLight(room(_,Y,_,_,L,_,_,_,_),floor(_,FL,_,_,S3,_)):-
S3#\=0, Y+L#= FL.

isExposedToLight(room(X,_,_,W,_,_,_,_,_),floor(FW,_,_,_,_,S4)):-
S4#\=0,X+W#=FW.




% sun room is exposed to sunlight
sunRoomsExposedTOSL([],_).

sunRoomsExposedTOSL([Room|T],Floor):-
Room = room(_,_,_,_,_,_,s,_,_),
isExposedToLight(Room,Floor),
sunRoomsExposedTOSL(T,Floor).

sunRoomsExposedTOSL([Room|T],Floor):-
Room = room(_,_,_,_,_,_,Type,_,_),
Type\=s,
sunRoomsExposedTOSL(T,Floor).