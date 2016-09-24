LIBANTLR=~/prog/antlr/antlr-4.5.3-complete.jar
EXTSRC=~/git/grammars-v4/antlr4/src/main/java 
GRMSRC=~/git/grammars-v4/antlr4
OUTSRC_ROOT=generated_src
OUTCLS_ROOT=classes
PKG=org.antlr.parser.antlr4
PKGDIR=org/antlr/parser/antlr4
MYPKGDIR=wrice127/ConvertToVisitorGrammar
SRC_ROOT=src

OUTSRC=$(OUTSRC_ROOT)/$(PKGDIR)
OUTCLS=$(OUTCLS_ROOT)/$(PKGDIR)
SRC=$(SRC_ROOT)/$(MYPKGDIR)
CLS=$(OUTCLS_ROOT)/$(MYPKGDIR)

all: $(CLS)/ConvertToVisitorGrammar.class

clean:
	rm -fr $(OUTSRC_ROOT)
	rm -fr $(OUTCLS_ROOT)

$(OUTSRC)/ANTLRv4Lexer.java $(OUTSRC)/ANTLRv4Lexer.tokens: $(GRMSRC)/ANTLRv4Lexer.g4
	java -jar $(LIBANTLR) -listener -package $(PKG) -o $(OUTSRC) $(GRMSRC)/ANTLRv4Lexer.g4

$(OUTSRC)/ANTLRv4Parser.java $(OUTSRC)/ANTLRv4Parser.tokens $(OUTSRC)/ANTLRv4ParserBaseListener.java: $(GRMSRC)/ANTLRv4Parser.g4 $(OUTSRC)/ANTLRv4Lexer.tokens
	java -jar $(LIBANTLR) -listener -package $(PKG) -o $(OUTSRC) $(GRMSRC)/ANTLRv4Parser.g4

$(OUTCLS_ROOT):
	mkdir $(OUTCLS_ROOT)

$(OUTCLS)/ANTLRv4Lexer.class: $(OUTSRC)/ANTLRv4Lexer.java $(OUTSRC)/ANTLRv4Lexer.tokens $(OUTCLS_ROOT)
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR) -sourcepath $(EXTSRC) $(OUTSRC)/ANTLRv4Lexer.java

$(OUTCLS)/ANTLRv4Parser.class: $(OUTSRC)/ANTLRv4Parser.java $(OUTSRC)/ANTLRv4Parser.tokens $(OUTCLS_ROOT)
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR) -sourcepath $(OUTSRC_ROOT) $(OUTSRC)/ANTLRv4Parser.java

$(OUTCLS)/ANTLRv4ParserBaseListener.class: $(OUTSRC)/ANTLRv4ParserBaseListener.java $(OUTCLS_ROOT)
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR) -sourcepath $(OUTSRC_ROOT) $(OUTSRC)/ANTLRv4ParserBaseListener.java

$(CLS)/MyListener.class: $(SRC)/MyListener.java $(OUTCLS)/ANTLRv4ParserBaseListener.class
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR):$(OUTCLS_ROOT) $(SRC)/MyListener.java

$(CLS)/ConvertToVisitorGrammar.class: $(SRC)/ConvertToVisitorGrammar.java $(CLS)/MyListener.class $(OUTCLS)/ANTLRv4Lexer.class
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR):$(OUTCLS_ROOT) $(SRC)/ConvertToVisitorGrammar.java
