// Validate that all test artifacts parse successfully
import antlr4 from 'antlr4';
import WeilangLexer from './parser/WeilangLexer.js';
import WeilangParser from './parser/WeilangParser.js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Error listener
class ErrorListener extends antlr4.error.ErrorListener {
  constructor() {
    super();
    this.errors = [];
  }

  syntaxError(recognizer, offendingSymbol, line, column, msg, err) {
    this.errors.push({ line, column, msg });
  }
}

// Find all .lw files in tests/artifacts
const artifactsDir = path.join(__dirname, '..', 'tests', 'artifacts');
const files = fs.readdirSync(artifactsDir)
  .filter(f => f.endsWith('.lw'))
  .sort();

console.log(`Found ${files.length} test artifacts\n`);

let passed = 0;
let failed = 0;
const failures = [];

for (const file of files) {
  const filePath = path.join(artifactsDir, file);
  const source = fs.readFileSync(filePath, 'utf8');

  try {
    const chars = new antlr4.InputStream(source);
    const lexer = new WeilangLexer(chars);
    const tokens = new antlr4.CommonTokenStream(lexer);
    const parser = new WeilangParser(tokens);

    const errorListener = new ErrorListener();
    parser.removeErrorListeners();
    parser.addErrorListener(errorListener);

    const tree = parser.program();

    if (errorListener.errors.length > 0) {
      failed++;
      failures.push({
        file,
        errors: errorListener.errors
      });
      process.stdout.write('✗');
    } else {
      passed++;
      process.stdout.write('✓');
    }

    // New line every 50 tests
    if ((passed + failed) % 50 === 0) {
      console.log();
    }

  } catch (error) {
    failed++;
    failures.push({
      file,
      errors: [{ line: 0, column: 0, msg: error.message }]
    });
    process.stdout.write('✗');
  }
}

console.log('\n');
console.log('='.repeat(60));
console.log(`Results: ${passed}/${files.length} passed, ${failed} failed`);
console.log('='.repeat(60));

if (failures.length > 0) {
  console.log('\nFailed files:');
  for (const failure of failures) {
    console.log(`\n${failure.file}:`);
    for (const error of failure.errors) {
      console.log(`  Line ${error.line}:${error.column} - ${error.msg}`);
    }
  }
  process.exit(1);
} else {
  console.log('\n✓ All test artifacts parsed successfully!');
}
