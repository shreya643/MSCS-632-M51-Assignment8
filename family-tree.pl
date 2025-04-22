:- initialization(main).
main :-
    findall(X, child(X, john), Children),
    write('Children of John: '), write(Children), nl,

    findall(X, sibling(paul, X), Siblings),
    write('Siblings of Paul: '), write(Siblings), nl,

    (cousin(david, tom) -> 
        write('David is a cousin of Tom.'), nl 
    ; 
        write('David is not a cousin of Tom.'), nl
    ),

    findall(X, descendant(X, john), Descendants),
    write('Descendants of John: '), write(Descendants), nl.



% Basic Facts
male(john).
female(mary).
male(paul).
female(susan).
male(david).
female(lisa).
male(tom).
female(emily).
female(sophia).
male(james).

parent(john, paul).
parent(mary, paul).
parent(john, susan).
parent(mary, susan).

parent(paul, david).
parent(lisa, david).
parent(paul, emily).
parent(lisa, emily).

parent(susan, tom).
parent(susan, sophia).
parent(james, tom).
parent(james, sophia).

% Derived Relationships

% Grandparent Rule
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% Sibling Rule
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% Cousin Rule
cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    sibling(P1, P2),
    X \= Y.

% Children Query
child(X, Y) :- parent(Y, X).

% Descendant Rule (recursive)
descendant(X, Y) :- parent(Y, X).
descendant(X, Y) :- parent(Z, X), descendant(Z, Y).
