:- use_module(plake(file)).

all(A) :-
    r_cat(A, ['hello', 'world'], 'hw').


