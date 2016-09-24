package wrice127.ConvertToVisitorGrammar;

import java.io.*;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.antlr.parser.antlr4.*;

public class ConvertToVisitorGrammar {

	public static void main(String[] args) {
		String fileName = args[1];
		try {
			FileInputStream fis = new FileInputStream(fileName);
			ANTLRInputStream input = new ANTLRInputStream(fis);
			ANTLRv4Lexer lexer = new ANTLRv4Lexer(input);
			CommonTokenStream tokens = new CommonTokenStream(lexer);
			ANTLRv4Parser parser = new ANTLRv4Parser(tokens);
			ParseTree tree = parser.translationunit();

			MyVisitor visitor = new MyVisitor();
			System.out.println(visitor.visit(tree));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

