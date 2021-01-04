:- use_module(library(clpfd)).

% all appartments have lanscape view
% at least one room in the appartment adjacent to a landscapeside 2


%          _S1_
%       s2|_s3_|s4
% adjacent to s1==>Y=0 S3==>Y=length s2==>x=0 s4==>x=w


%floor(W,L,S1,S2,S3,S4)

%[room(Rx,Ry,MinArea,Width,Length,Area,Type,Assign,Id)]-->[r(Rx,Width,Ry,Length)]
roomAdjToLS(room(_,0,_,_,_,_,_,_,_),floor(_,_,S1,_,_,_)):-
S1#=2.

roomAdjToLS(room(0,_,_,_,_,_,_,_,_),floor(_,_,_,S2,_,_)):-
S2#=2.

roomAdjToLS(room(_,Y,_,_,L,_,_,_,_),floor(_,FL,_,_,S3,_)):-
S3#=2, Y+L#= FL.

roomAdjToLS(room(X,_,_,W,_,_,_,_,_),floor(FW,_,_,_,_,S4)):-
S4#=2,X+W#=FW.



% at least one room in the appartment adjacent to lanscape

appAdjToLandScape([R|_],F):-
roomAdjToLS(R,F).

appAdjToLandScape([_|T],F):-
appAdjToLandScape(T,F).


% all appartments adj to lanscape

allAppAdjToLS([],_).
allAppAdjToLS([[Rooms|_]|T],F):-
appAdjToLandScape(Rooms,F),
allAppAdjToLS(T,F).


% apply constraint

applyG1(0,0,_,_).


applyG1(1,1,Appartments,Floor):-
allAppAdjToLS(Appartments,Floor).


applyG1(1,0,_,_).


