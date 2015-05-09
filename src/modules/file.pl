%
% modules/file.pl
%

:- module(plake_file, [ c_rm/2, c_cat/3, r_cat/3 ]).

% rm
c_rm([_, dep], F) :-
    \+ exists(F).

c_rm([_, do],  F) :-
    format('rm ~w~n', [F]),
    rm(F).

% cat et al
c_cat([_, dep], In, Out) :-
    \+ remake(Out, In).

c_cat([_, do],  In, Out) :-
    format('cat ~w => ~w~n', [In, Out]),
    open(Out, write, OutStrm, [type(binary)]),
    cat_aux(In, OutStrm),
    close(OutStrm).

copy_strm(InStrm, _) :-
    at_end_of_stream(InStrm), !.

copy_strm(InStrm, OutStrm) :-
    get_byte(InStrm, Byte),
    put_byte(OutStrm, Byte),
    copy_strm(InStrm, OutStrm).

cat_aux([], _).
cat_aux([In | Ins], OutStrm) :-
    open(In, read, InStrm, [type(binary)]),
    copy_strm(InStrm, OutStrm),
    close(InStrm),
    cat_aux(Ins, OutStrm).

r_cat([build, A], I, O) :- c_cat([build, A], I, O).
r_cat([clean, A], _, O) :- c_rm([clean, A], O).
