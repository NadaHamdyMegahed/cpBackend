:- use_module(library(clpfd)).

:-include("print.pl").
:-include("helpers.pl").
:-include("constraint1.pl").
:-include("constraint2.pl").
:-include("constraint3.pl").
:-include("constraint4.pl").
:-include("constraint5.pl").
:-include("constraint6.pl").
:-include("constraint789.pl").
:-include("softConstraints.pl").
:-include("optionalGLobal.pl").



solve(Floor,Appartments,Corridors,Ducts,E,G1,GS1,G2,GS2,G3,GS3,G4,GS4):-

Floor=floor(FW,FL,S1,S2,S3,S4),
E=e(EX,3,EY,3),
%EX#=FW//2,EY#=FL//2,
length(Appartments,N),
getAppXWYL(Appartments,X,W,Y,L),
returnRooms(Appartments,Rooms),
checkAreaLW(Rooms,FW,FL),
% c5
generateDucts(N,Ducts),
getDuctsXY(Ducts,Dx,Dy),
checkKitchensBathrooms(Rooms,Ducts),


%c3
genrateCorridors(N,Corridors),
getCorridorsXY(Corridors,Cx,Cy),
checkCorridors(Corridors,Appartments,E),

%c4
getTotalArea(Rooms,Corridors,Ducts,Area),
returnAreas(Rooms,Areas),



flatten([X,W,Dx,Cx,EX],Xs),flatten([Y,L,Dy,Cy,EY],Ys),
Xs ins 0..FW, Ys ins 0..FL,
%flatten([W,L,Y,X,Dx,Dy,Cx,Cy],All),


%c2
checkAllHallways(Appartments),

%c6
sunRoomsExposedTOSL(Rooms,Floor),

%c789
checkAppAdj(Appartments),

%c1
notOverLapping(Appartments,Corridors,Ducts,E),

%soft constraints
checkSoftConstraints(Appartments,Floor),

% gloabl constraints
applyGlobalConstraints(Appartments,Floor,G1,GS1,G2,GS2,G3,GS3,G4,GS4),



checkRoomsBoundaries(Rooms,FW,FL),
checkDuctsBoundaries(Ducts,FW,FL),
 mix(Xs,Ys,All),
labeling([],All),
%labeling([max(Area)],All),

% to split with in the front end
write('stop'),nl,

printProblem(Appartments,[GS1,GS2,GS3,GS4],E,Ducts,Corridors).

mix([],[],[]).
mix([H1|T1],[H2|T2],[H1,H2|T]):-
mix(T1,T2,T).




