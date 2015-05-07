% util.pl
%
% Provides so functions for the sake of convience, perhaps these should be
% gnomed or something.
%

:- use_module(library(filesex)).

% filters out stuff in the given list from an list
filter([], _, []).
filter([X | Xs], Filter, [X | Ys]) :-
    \+ member(X, Filter),
    filter(Xs, Filter, Ys).
filter([X | Xs], Filter, Ys) :-
    member(X, Filter),
    filter(Xs, Filter, Ys).

% calls a predicate for every element in a list
%  map/2 throws away the result
%  map/3 defines the result as the 3rd argument
map(_, []).
map(F, [X | Xs]) :-
    call(F, X),
    map(F, Xs).

map(_, [], []).
map(F, [X | Xs], [Y | Ys]) :-
    call(F, X, Y),
    map(F, Xs, Ys).

% Adds a prefix to each string in the list
prefix(_, [], []).
prefix(Prefix, [X | Xs], [Y | Ys]) :-
    string_concat(Prefix, X, Y),
    prefix(Prefix, Xs, Ys).

% Adds a suffix to each string in the list
suffix(_, [], []).
suffix(Suffix, [X | Xs], [Y | Ys]) :-
    string_concat(Suffix, X, Y),
    suffix(Suffix, Xs, Ys).

% Convience function that acts like shell/1, but concats list first
lshell(Ls) :-
    concat(Ls, Cmd),
    shell(Cmd).

% Wraps to process_create, but returns false if status is non-0, rather than
% throw an error. Also calls alias on process name
process_do(Name, Args) :-
    process_create(path(Name), Args, [process(Pid)]),
    process_wait(Pid, exit(0)).

remake(Target, _) :-
    \+ exists(Target).
remake(Target, [D | Deps]) :-
    \+ exists(D);
    newer(D, Target);
    remake(Target, Deps).

% True if file A is newer (modified) than file B
newer(A, B) :-
    set_time_file(A, [modified(C)], []),
    set_time_file(B, [modified(D)], []),
    C > D.

% Returns true if F is a file or directory that exists
exists(F) :- exists_file(F).
exists(F) :- exists_directory(F).

