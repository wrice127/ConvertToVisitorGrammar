package wrice127.ConvertToVisitorGrammar;

import java.io.*;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.antlr.parser.antlr4.*;

public class ConvertToVisitorGrammar {

	public static void main(String[] args) {
		if (args.length != 1) throw new IllegalArgumentException("A grammar filename is expected as a command argument.");
		String fileName = args[0];

		try {
			FileInputStream fis = new FileInputStream(fileName);
			ANTLRInputStream input = new ANTLRInputStream(fis);
			ANTLRv4Lexer lexer = new ANTLRv4Lexer(input);
			CommonTokenStream tokens = new CommonTokenStream(lexer);
			ANTLRv4Parser parser = new ANTLRv4Parser(tokens);
			ParseTree tree = parser.grammarSpec();

			ParseTreeWalker walker = new ParseTreeWalker();
			MyListener myListener = new MyListener();
			walker.walk(myListener, tree);
			System.out.println(myListener.result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

