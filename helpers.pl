:- use_module(library(clpfd)).

%%%%%Y guess this takes to much time !!!!!
adjacent(RX,RY,RW,RL,CX,CY,CW,CL):-
% adjacent from the above 
RY#=CY+CL #/\ ((CX#>=RX #/\ CX#<RX+RW)#\/(CX+CW#>RX #/\ CX+CW#=<RX+RW)#\/(RX#>=CX#/\(RX+RW)#=<(CX+CW)))#<==> C1,
% adjacent from the bottom
RY+RL#=CY #/\ ((CX#>=RX #/\ CX#<RX+RW)#\/(CX+CW#>RX #/\ CX+CW#=<RX+RW)#\/(RX#>=CX#/\(RX+RW)#=<(CX+CW)))#<==> C2,
% adjacent from the left 
RX#=CX+CW #/\ ((CY#>RY #/\ CY#<RY+RL)#\/(CY+CL#>RY #/\ CY+CL#=<RY+RL)#\/(RY#>=CY#/\(RY+RL)#=<(CY+CL)))#<==> C3,
% adjacent from the right 
RX+RW#=CX #/\ ((CY#>RY #/\ CY#<RY+RL)#\/(CY+CL#>RY #/\ CY+CL#=<RY+RL)#\/(RY#>=CY#/\(RY+RL)#=<(CY+CL)))#<==> C4,
% one corridor at least satisfies the conditions
C1#\/C2#\/C3#\/C4.


%%%%%%%%%%%%%%%% get all Rooms Coordinates %%%%%%%%%%%%%%%%%%%%%

getRoomsXWYL(Rooms,C1,C2,C3,C4):-
setof(X,(Id^A^T^Min^Ar^Y^L^W^member(room(X,Y,Min,W,L,Ar,T,A,Id),Rooms)),C1),
setof(W,(Id^A^T^Min^Ar^Y^L^X^member(room(X,Y,Min,W,L,Ar,T,A,Id),Rooms)),C2),
% flatten(C1,XW),
setof(Y,(Id^A^T^Min^Ar^X^W^L^member(room(X,Y,Min,W,L,Ar,T,A,Id),Rooms)),C3),
setof(L,(Id^A^T^Min^Ar^X^W^Y^member(room(X,Y,Min,W,L,Ar,T,A,Id),Rooms)),C4).
% flatten(C2,YL).

getAppXWYL([],[],[],[],[]).
getAppXWYL([[Rooms|_]|T],X,W,Y,L):-
getRoomsXWYL(Rooms,H1,H2,H3,H4),
getAppXWYL(T,T1,T2,T3,T4),
flatten([H1|T1],X),
flatten([H2|T2],W),
flatten([H3|T3],Y),
flatten([H4|T4],L).

%%%%%%%%%%%%%%%%%%%%%%% get Ducts X %%%%%%%%%%%%%%%%%%%%
getDuctsXY(Ducts,Xs,Ys):-
setof(X,(W^Y^L^member(duct(X,W,Y,L),Ducts)),Xs),
setof(Y,(W^X^L^member(duct(X,W,Y,L),Ducts)),Ys).


%%%%%%%%%%%%%%%%%%%%%%% get Corridors X %%%%%%%%%%%%

getCorridorsXY(Corridors,C1,C2):-
setof(X,(W^Y^L^Id^member(c(X,W,Y,L,Id),Corridors)),C1),
setof(Y,(W^X^L^Id^member(c(X,W,Y,L,Id),Corridors)),C2).


%%%%%%%%%%%%%%%% get all rooms %%%%%%%%%%%%%%%%%%
returnRooms(App,L):-
setof(R,T^member([R|T],App),Rooms),
flatten(Rooms,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% add max area
%check Area=Length*Width
checkAreaLW([],_,_).
checkAreaLW([room(_,_,MinArea,Width,Length,Area,_,_,_)|T],FW,FL):-
Area#>=MinArea,
Area#=Width*Length,
Area #=< FW*FL,
checkAreaLW(T,FW,FL).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
returnAreas(Rooms,Areas):-
setof(A,X^Y^Min^W^L^T^AA^Id^member(room(X,Y,Min,W,L,A,T,AA,Id),Rooms),Areas).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%check boundaries%%%%%%%%%%%%%%%%%%%%%

checkRoomsBoundaries([room(X,Y,_,W,L,_,_,_,_)|T],FW,FH):-
X+W#=<FW,Y+L#=<FH,
checkRoomsBoundaries(T,FW,FH).


checkRoomsBoundaries([],_,_).

checkDuctsBoundaries([duct(X,W,Y,L)|T],FW,FH):-
X+W#=<FW,Y+L#=<FH,
checkDuctsBoundaries(T,FW,FH).

checkDuctsBoundaries([],_,_).

checkCorridorsBoundaries([c(X,W,Y,L,_)|T],FW,FH):-
X+W#=<FW,Y+L#=<FH,
checkCorridorsBoundaries(T,FW,FH).

checkCorridorsBoundaries([],_,_).

checkBoundaries(Rooms,Ducts,Corridors,W,H):-
checkRoomsBoundaries(Rooms,W,H),
checkDuctsBoundaries(Ducts,W,H),
checkCorridorsBoundaries(Corridors,W,H).



%%%%%%%%%%%%%%%%%%%%%%%%%%%soft constraints helpers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% get center 
getCenter(X,W,Y,L,CX,CY):-
    HalfWidth#= div(W,2),
    HalfLength#= div(L,2),
    CX#= X+ HalfWidth,
    CY#= Y+ HalfLength.
    
    
    
    % get distance between 2 points 5 ignore the square root (x1-x2)^2+(y1-y2)^2
    distance(N1,N2,D) :- N1=(X1,Y1), 
                         N2=(X2,Y2),
                         D #=(X2-X1)^2 + (Y2-Y1)^2.
    