:- use_module(library(clpfd)).




%%%%%%%%%%% New %%%%%%%%%%%%%%
getDuctsArea(Ducts,A):-
    length(Ducts,N),
    A#=N*10*10.
    
    getCorridorsArea(Corridors,A):-
    length(Corridors,N),
    A#=N*3*3.
    
    
    getRoomsAreas([],0).
    getRoomsAreas([room(_,_,_,_,_,Area,_,_,_)|T],A2):-
    A2#=Area+A,
    getRoomsAreas(T,A).
    
    
    getTotalArea(Rooms,Corridors,Ducts,Area):-
    EA#=3*3,%elevator area
    getDuctsArea(Ducts,A1),
    getCorridorsArea(Corridors,A2),
    getRoomsAreas(Rooms,A3),
    Area#=A1+A2+A3+EA.



