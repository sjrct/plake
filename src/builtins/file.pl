%
% posix.pl
%

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
    c_cat__aux(In, OutStrm),
    close(OutStrm).

c_cat__copy_strm(InStrm, _) :-
    at_end_of_stream(InStrm), !.

c_cat__copy_strm(InStrm, OutStrm) :-
    get_byte(InStrm, Byte),
    put_byte(OutStrm, Byte),
    c_cat__copy_strm(InStrm, OutStrm).

c_cat__aux([], _).
c_cat__aux([In | Ins], OutStrm) :-
    open(In, read, InStrm, [type(binary)]),
    c_cat__copy_strm(InStrm, OutStrm),
    close(InStrm),
    c_cat__aux(Ins, OutStrm).

r_cat([build, A], I, O) :- c_cat([build, A], I, O).
r_cat([clean, A], _, O) :- c_rm([clean, A], O).
