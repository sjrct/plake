%
% plake.pl
%

% Tell prolog where to load plake modules from
:- prolog_load_context(directory, PlakeDir),
   atom_concat(PlakeDir, '/modules', ModuleDir),
   assert(file_search_path(plake, ModuleDir)).

:- [util].
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

