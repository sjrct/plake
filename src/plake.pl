%
% plake.pl
%

:- [util, builtins].
:- [plakefile].

% Verb should succeed if target not dirty
verb(Verb, Target) :-
    call(Target, [Verb, dep]),
    write('nothing to do'), nl,
    !.

% Or if performing the verb succeeds
verb(Verb, Target) :-
    format('~wing ~w~n', [Verb, Target]),
    call(Target, [Verb, do]),
    format('~w successful!~n', [Verb]),
    !.

% Fail otherwise
verb(Verb, _) :-
    format('~w failed :(~n', [Verb]), false.

% Main entry point
plake_main(Verb, Target) :-
    verb(Verb, Target),
    halt(0).

plake_main(_, _) :-
    halt(1).

