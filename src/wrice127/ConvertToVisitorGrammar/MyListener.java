package wrice127.ConvertToVisitorGrammar;

import org.antlr.parser.antlr4.*;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class MyListener extends ANTLRv4ParserBaseListener {

	public String result = new String();
	private boolean bInLabeledAlt = false;
	private String label = new String();
	private String parserRuleSpec = new String();

	@Override public void visitTerminal(TerminalNode node) {
		result += node.getText() + " ";
		if (bInLabeledAlt) {
			String text = node.getText();
			label += "_";
			for (int i = 0; i < text.length(); i++) {
				char c = text.charAt(i);
				label += (Character.isLetterOrDigit(c) || c == '_'
					? c : Integer.toHexString(c));
			}
		}
	}
	@Override public void enterParserRuleSpec(ANTLRv4Parser.ParserRuleSpecContext ctx) {
		parserRuleSpec = ctx.RULE_REF().getSymbol().getText();
		result += "\n";
	}
	@Override public void enterLabeledAlt(ANTLRv4Parser.LabeledAltContext ctx) {
		if (bInLabeledAlt) throw new RuntimeException("Already in labeledAlt ");
		bInLabeledAlt = true;
	}
	@Override public void exitLabeledAlt(ANTLRv4Parser.LabeledAltContext ctx) {
		result += "# " + parserRuleSpec + label + "\n";
		label = "";
		bInLabeledAlt = false;
	}
}

