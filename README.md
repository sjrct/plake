# Plake
Plake is a general build system written in Prolog.

## Installation

To install plake to the default locations, run the following series of commands:

    git clone https://github.com/sjrct/plake
    cd plake
    ./install

Note that `./install` probably requires root access.

The first argument to `./install` specifies the location of the executable file,
which is by default `/usr/bin/plake`.

The second argument to `./install` specifies the directory location to install the
source files to, which is by default `/opt/plake/`. If you change this location,
make sure to set the `PLAKE_DIR` environment variable accordingly.

## Invocation

The simplest invocation of plake is simple `plake`. This will search for a file
termed `plakefile.pl` in the current directory and attempt to perform the
verb `build` on the target predicate `all` specified in that file. By passing
an argument to plake, one can specify which verb to perform, and a second
argument will specify which target to perform that action on. For example,
`plake clean foo` will attempt to clean the target foo.

## Plakefiles

The plakefile tells plake how to build your application. A plakefile consists
of rules, which are specified via Prolog predicates, that tell plake how to
build different components.

Each rule has a target and a list of verbs it can perform on the target. The
most common verbs are `build` and `clean`. Though `test` and `install` are
also quite useful.
