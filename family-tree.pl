:- initialization(main).
main :-
    findall(X, child(X, john), Children),
    write('Children of John: '), write(Children), nl,

    findall(X, sibling(ian, X), Siblings),
    write('Siblings of ian: '), write(Siblings), nl,

    (cousin(dave, tom) -> 
        write('dave is a cousin of Tom.'), nl 
    ; 
        write('dave is not a cousin of Tom.'), nl
    ),

    findall(X, descendant(X, john), Descendants),
    write('Descendants of John: '), write(Descendants), nl.



% Basic Facts
male(john).
female(jane).
male(ian).
female(susan).
male(dave).
female(lisa).
male(tom).
female(emily).
female(sammy).
male(jammie).

parent(john, ian).
parent(jane, ian).
parent(john, susan).
parent(jane, susan).

parent(ian, dave).
parent(lisa, dave).
parent(ian, emily).
parent(lisa, emily).

parent(susan, tom).
parent(susan, sammy).
parent(jammie, tom).
parent(jammie, sammy).

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
