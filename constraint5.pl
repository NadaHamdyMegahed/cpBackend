:- use_module(library(clpfd)).
%room(X,Y,Min,W,L,A,T,AA,Id)
% kitchen and bathrooms are adjacent to ducts

%%% New 

roomAdjToDuct(room(X1,Y1,_,W1,L1,_,_,_,_),duct(X2,W2,Y2,L2)):-
    adjacent(X1,Y1,W1,L1,X2,Y2,W2,L2).
    
    roomAdjToAtLeastOneDuct(R,[D|_]):-
    roomAdjToDuct(R,D).
    
    roomAdjToAtLeastOneDuct(R,[_|T]):-
    roomAdjToAtLeastOneDuct(R,T).
    
    
    checkKitchensBathrooms([],_).
    checkKitchensBathrooms([R|Tail],Ducts):-
    R=room(_,_,_,_,_,_,T,_,_),
    T\=b,T\=s,T\=h,
    roomAdjToAtLeastOneDuct(R,Ducts),
    checkKitchensBathrooms(Tail,Ducts).
    
    checkKitchensBathrooms([R|Tail],Ducts):-
    R=room(_,_,_,_,_,_,T,_,_),
    T\=mn,T\=ms,T\=k,
    checkKitchensBathrooms(Tail,Ducts).
    
    
    generateDucts(0,[duct(_,10,_,10)]):-!.
    generateDucts(1,[duct(_,10,_,10)]):-!.
    generateDucts(2,[duct(_,10,_,10)]):-!.
    generateDucts(N,[duct(_,10,_,10)|T]):-
    N2 is N-1,
    generateDucts(N2,T).
    