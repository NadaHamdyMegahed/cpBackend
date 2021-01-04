%(1,R1,R2,0,Value,1) Con,r1,r2,v<d,distance,Sat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% room(X1,Y1,_,W1,L1,_,_,_,_)
% 0 -> Value less than Distance
% 1-> Value greater than Distance
helperBetweenRooms(room(X1,Y1,_,W1,L1,_,_,_,_),room(X2,Y2,_,W2,L2,_,_,_,_),D):-
    getCenter(X1,W1,Y1,L1,CX1,CY1),
    getCenter(X2,W2,Y2,L2,CX2,CY2),
    distance((CX1,CY1),(CX2,CY2),D).

distanceBetweenRooms(0,_,_,_,_,0).
% True CASES 
% 1) Less Than
distanceBetweenRooms(1,R1,R2,0,Value,1):-
    helperBetweenRooms(R1,R2,D),
    Value^2#=< D.
% 2) Greater Than
distanceBetweenRooms(1,R1,R2,1,Value,1):-
    helperBetweenRooms(R1,R2,D),
    Value^2#>= D.
	
% False Cases
% 1) Less Than
distanceBetweenRooms(1,R1,R2,0,Value,0):-
    helperBetweenRooms(R1,R2,D),
    not(Value^2#=< D).
% 2) Greater Than
distanceBetweenRooms(1,R1,R2,1,Value,0):-
    helperBetweenRooms(R1,R2,D),
    not(Value^2#>= D).
    
	
checkDistanceBetween2Rooms(C,S,R1,R2,Value,Sign):-
distanceBetweenRooms(C,R1,R2,Sign,Value,S).


