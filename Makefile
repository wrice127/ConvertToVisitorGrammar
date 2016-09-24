LIBANTLR=~/prog/antlr/antlr-4.5.3-complete.jar
PKG=org.antlr.parser.antlr4
PKGDIR=org/antlr/parser/antlr4
OUTSRC_ROOT=generated_src
OUTCLS_ROOT=classes
OUTSRC=$(OUTSRC_ROOT)/$(PKGDIR)
OUTCLS=$(OUTCLS_ROOT)/$(PKGDIR)
EXTSRC=~/git/grammars-v4/antlr4/src/main/java 
GRMSRC=~/git/grammars-v4/antlr4

all: $(OUTCLS)/ANTLRv4Parser.class
#all: $(OUTSRC)/ANTLRv4Lexer.java $(OUTSRC)/ANTLRv4Parser.java

clean:
	rm -fr $(OUTSRC_ROOT)
	rm -fr $(OUTCLS_ROOT)

$(OUTSRC)/ANTLRv4Lexer.java $(OUTSRC)/ANTLRv4Lexer.tokens: $(GRMSRC)/ANTLRv4Lexer.g4
	java -jar $(LIBANTLR) -package $(PKG) -o $(OUTSRC) $(GRMSRC)/ANTLRv4Lexer.g4

$(OUTSRC)/ANTLRv4Parser.java $(OUTSRC)/ANTLRv4Parser.tokens: $(GRMSRC)/ANTLRv4Parser.g4 $(OUTSRC)/ANTLRv4Lexer.tokens
	java -jar $(LIBANTLR) -package $(PKG) -o $(OUTSRC) $(GRMSRC)/ANTLRv4Parser.g4

$(OUTCLS_ROOT):
	mkdir $(OUTCLS_ROOT)

$(OUTCLS)/ANTLRv4Lexer.class: $(OUTSRC)/ANTLRv4Lexer.java $(OUTSRC)/ANTLRv4Lexer.tokens $(OUTSRC)/LexerAdaptor.java $(OUTCLS_ROOT)
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR) -sourcepath $(OUTSRC_ROOT):$(EXTSRC) $(OUTSRC)/ANTLRv4Lexer.java

$(OUTCLS)/ANTLRv4Parser.class: $(OUTSRC)/ANTLRv4Parser.java $(OUTSRC)/ANTLRv4Parser.tokens $(OUTCLS_ROOT)
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR) -sourcepath $(OUTSRC_ROOT):$(EXTSRC) $(OUTSRC)/ANTLRv4Parser.java
