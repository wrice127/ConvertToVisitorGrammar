LIBANTLR=~/prog/antlr/antlr-4.5.3-complete.jar
GRAMMARSv4=~/git/grammars-v4

GRMSRC=$(GRAMMARSv4)/antlr4
EXTSRC=$(GRAMMARSv4)/antlr4/src/main/java 
OUTSRC_ROOT=generated_src
OUTCLS_ROOT=classes
PKG=org.antlr.parser.antlr4
PKGDIR=org/antlr/parser/antlr4
MYPKG=wrice127.ConvertToVisitorGrammar
MYPKGDIR=wrice127/ConvertToVisitorGrammar
SRC_ROOT=src

OUTSRC=$(OUTSRC_ROOT)/$(PKGDIR)
OUTCLS=$(OUTCLS_ROOT)/$(PKGDIR)
SRC=$(SRC_ROOT)/$(MYPKGDIR)
CLS=$(OUTCLS_ROOT)/$(MYPKGDIR)

all: $(OUTCLS)/ANTLRv4Lexer.class $(OUTCLS)/ANTLRv4Parser.class $(CLS)/MyListener.class $(CLS)/ConvertToVisitorGrammar.class

clean:
	rm -fr $(OUTSRC_ROOT)
	rm -fr $(OUTCLS_ROOT)

test: $(CLS)/ConvertToVisitorGrammar.class
	java -cp $(LIBANTLR):$(OUTCLS_ROOT) $(MYPKG).ConvertToVisitorGrammar $(GRMSRC)/ANTLRv4Parser.g4
	#java org.antlr.v4.gui.TestRig org.antlr.parser.antlr4.ANTLRv4 grammarSpec -tree $(GRMSRC)/ANTLRv4Parser.g4

$(OUTSRC)/ANTLRv4Lexer.java $(OUTSRC)/ANTLRv4Lexer.tokens: $(GRMSRC)/ANTLRv4Lexer.g4
	java -jar $(LIBANTLR) -listener -package $(PKG) -o $(OUTSRC) $(GRMSRC)/ANTLRv4Lexer.g4

$(OUTSRC)/ANTLRv4Parser.java $(OUTSRC)/ANTLRv4Parser.tokens $(OUTSRC)/ANTLRv4ParserBaseListener.java: $(GRMSRC)/ANTLRv4Parser.g4 $(OUTSRC)/ANTLRv4Lexer.tokens
	java -jar $(LIBANTLR) -listener -package $(PKG) -o $(OUTSRC) $(GRMSRC)/ANTLRv4Parser.g4

$(OUTCLS)/ANTLRv4Lexer.class: $(OUTSRC)/ANTLRv4Lexer.java $(OUTSRC)/ANTLRv4Lexer.tokens
	mkdir $(OUTCLS_ROOT)
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR) -sourcepath $(EXTSRC) $(OUTSRC)/ANTLRv4Lexer.java

$(OUTCLS)/ANTLRv4Parser.class: $(OUTSRC)/ANTLRv4Parser.java $(OUTSRC)/ANTLRv4Parser.tokens $(OUTCLS_ROOT)
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR) -sourcepath $(OUTSRC_ROOT) $(OUTSRC)/ANTLRv4Parser.java

$(OUTCLS)/ANTLRv4ParserBaseListener.class: $(OUTSRC)/ANTLRv4ParserBaseListener.java $(OUTCLS_ROOT)
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR) -sourcepath $(OUTSRC_ROOT) $(OUTSRC)/ANTLRv4ParserBaseListener.java

$(CLS)/MyListener.class: $(SRC)/MyListener.java $(OUTCLS)/ANTLRv4ParserBaseListener.class
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR):$(OUTCLS_ROOT) $(SRC)/MyListener.java

$(CLS)/ConvertToVisitorGrammar.class: $(SRC)/ConvertToVisitorGrammar.java
	javac -d $(OUTCLS_ROOT) -cp $(LIBANTLR):$(OUTCLS_ROOT) $(SRC)/ConvertToVisitorGrammar.java
