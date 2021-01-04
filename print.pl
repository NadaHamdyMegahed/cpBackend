

%%%%%%%%%%%%%
 printRooms([]).
 printRooms([room(Rx,Ry,MinArea,Width,Length,Area,Type,Assign,Id)|T]):-
 write(' room '),write(Id),nl,
 write('X: '),write(Rx),write(' Y: '),write(Ry),nl,
 write('width: '),write(Width),write(' length: '),write(Length),nl,
 write('area: '),write(Area),write(' min area: '), write(MinArea),nl,
 write('type: '),printRoomType(Type),write(' assigned: '),write(Assign),nl,
 write('______________________________'),nl,
 printRooms(T).


 printAppartmentsHelper([],_).
 
 printAppartmentsHelper([[H,_,S1,_,S2,_,_,_,_,_,S3,_,S4]|T],Indx):-
 write('Appartment '),write(Indx),write('  satisfiedConstraints: '),
 printASatisfiedConstriants([S1,S2,S3,S4],1),nl,
 write('_______________'),nl,
 printRooms(H),

 Indx2 is Indx+1,
 printAppartmentsHelper(T,Indx2).

 printAppartments(A):-
 printAppartmentsHelper(A,1).


 printRoomType(k):-write('kitchen').
 printRoomType(ms):-write('masterbathroom').
 printRoomType(mn):-write('minorbathroom').
 printRoomType(b):-write('bedroom').
 printRoomType(h):-write('hallway').
 printRoomType(d):-write('diningroom').
printRoomType(s):-write('sunroom').

 printASatisfiedConstriants([],_).
 printASatisfiedConstriants([1|T],I):-
 write(softconstraint),write(I),write("  "),
 I2 is I+1,
 printASatisfiedConstriants(T,I2).
 printASatisfiedConstriants([0|T],I):-
 I2 is I+1,
 printASatisfiedConstriants(T,I2).


 printGenralConst([],_).
 printGenralConst([1|T],I):-
 write(globalConstraint),write(I),write("  "),
 I2 is I+1,
 printGenralConst(T,I2).

 printGenralConst([0|T],I):-
 I2 is I+1,
 printGenralConst(T,I2).


printCoords([X,W,Y,L]):-
write('x: '),write(X),write(' y: '),write(Y),write(' width: '),write(W),write(' length: '),write(L).
printElevator(e(X,W,Y,L)):-
write('Elevator: '),
printCoords([X,W,Y,L]),nl,
write('________________________________').

printDucts([],_).
printDucts([duct(X,W,Y,L)|T],Id):-
write('duct'),write(Id),write(' : '), printCoords([X,W,Y,L]),nl,
Id2 is Id+1,
printDucts(T,Id2).

printCorridors([],_).
printCorridors([c(X,W,Y,L,_)|T],Id):-
write('corridor'),write(Id),write(' : '), printCoords([X,W,Y,L]),nl,
Id2 is Id+1,
printCorridors(T,Id2).


 printProblem(A,GeneralConstraints,E,Ducts,Corridors):-
 printElevator(E),nl,
 write('Ducts: '),nl,
 printDucts(Ducts,1),nl,
 write("_______________________________"),nl,
  write('Corridors: '),nl,
 printCorridors(Corridors,1),nl,
 write("_______________________________"),nl,
 printAppartments(A),nl,
 write('satisfied generalConstraints: '),nl,
 printGenralConst(GeneralConstraints,1),nl,
 write("_______________________________").
















