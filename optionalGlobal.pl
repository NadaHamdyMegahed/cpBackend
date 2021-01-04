:- use_module(library(clpfd)).
:-include("global1.pl").

%G1,SG1,G2,SG2,G3,SG3,G4,SG4

applyGlobalConstraints(Appartments,Floor,G1,SG1,_,0,_,0,_,0):-
% gobal constraint 1
applyG1(G1,SG1,Appartments,Floor).



