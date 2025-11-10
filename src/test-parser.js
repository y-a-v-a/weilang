// Simple test to verify the generated parser works
import antlr4 from 'antlr4';
import WeilangLexer from './parser/WeilangLexer.js';
import WeilangParser from './parser/WeilangParser.js';

// Test programs
const testPrograms = [
  {
    name: 'Simple assignment',
    code: `SIMPLE PLACED AS 100.`
  },
  {
    name: 'Multiple assignments with operators',
    code: `SIMPLE PLACED AS 100.
ANOTHER PLACED AS 200.
RESULT PLACED AS SIMPLE PUT TOGETHER ANOTHER.`
  },
  {
    name: 'Conditional',
    code: `VALUE PLACED AS 100.
IF AS IF VALUE
    RESULT PLACED AS 42.
END AS IS`
  }
];

console.log('Testing Weilang Parser...\n');

// Build error listener to catch parsing errors
class ErrorListener extends antlr4.error.ErrorListener {
  constructor() {
    super();
    this.errors = [];
  }

  syntaxError(recognizer, offendingSymbol, line, column, msg, err) {
    this.errors.push(`Parse error at ${line}:${column} - ${msg}`);
  }
}

let passed = 0;
let failed = 0;

for (const test of testPrograms) {
  console.log(`Test: ${test.name}`);
  console.log(`Code: ${test.code.replace(/\n/g, '\\n')}`);

  try {
    // Create input stream
    const chars = new antlr4.InputStream(test.code);

    // Create lexer
    const lexer = new WeilangLexer(chars);
    const tokens = new antlr4.CommonTokenStream(lexer);

    // Create parser
    const parser = new WeilangParser(tokens);

    const errorListener = new ErrorListener();
    parser.removeErrorListeners();
    parser.addErrorListener(errorListener);

    // Parse the program
    const tree = parser.program();

    if (errorListener.errors.length > 0) {
      console.log('✗ Parsing failed with errors:');
      errorListener.errors.forEach(err => console.log('  ' + err));
      failed++;
    } else {
      console.log('✓ Parsing successful!');
      console.log(`  Parse tree: ${tree.constructor.name}, statements: ${tree.children ? tree.children.length : 0}`);
      passed++;
    }

  } catch (error) {
    console.log('✗ Exception:', error.message);
    failed++;
  }

  console.log('---\n');
}

console.log(`Results: ${passed} passed, ${failed} failed`);
if (failed > 0) {
  process.exit(1);
}
