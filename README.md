# ConvertToVisitorGrammar
This program is to append labels on each parser rule for Antlr grammar.

This code requires Antlr tool and runtime binaries: http://www.antlr.org/download.html

This code depends on the other Git repository: https://github.com/antlr/grammars-v4
Once you clone it, you will need to modify Makefile to set where it is stored.

The make file starts with these three lines:

LIBANTLR=~/prog/antlr/antlr-4.5.3-complete.jar : change to where you stored ANTLR binary JAR.

GRAMMARSv4=~/git/grammars-v4 : change to where you cloned grammars-v4

