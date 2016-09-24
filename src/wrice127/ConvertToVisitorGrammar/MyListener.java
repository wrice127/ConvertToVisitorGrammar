package wrice127.ConvertToVisitorGrammar;

import org.antlr.parser.antlr4.*;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class MyListener extends ANTLRv4ParserBaseListener {

	public String result = new String();

	@Override public void visitTerminal(TerminalNode node) {
		result += node.getText() + "\n";
	}
}

