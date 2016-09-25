# ConvertToVisitorGrammar
This program is to append labels on each parser rule for Antlr grammar.

This code requires Antlr tool and runtime binaries: http://www.antlr.org/download.html

This code depends on the other Git repository: https://github.com/antlr/grammars-v4
Once you clone it, you will need to modify Makefile to set where it is stored.

The make file starts with these three lines:
LIBANTLR=~/prog/antlr/antlr-4.5.3-complete.jar
EXTSRC=~/git/grammars-v4/antlr4/src/main/java 
GRMSRC=~/git/grammars-v4/antlr4

Change "LIBANTLR" to where you stored the Antlr binary JAR file.
Change EXTSRC and GRMSRC to where the grammar is stored.
