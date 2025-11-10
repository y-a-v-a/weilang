#!/usr/bin/env node

/**
 * Main test suite entry point for Weilang
 *
 * Usage:
 *   node tests/test-suite.js                    # Run all tests
 *   node tests/test-suite.js --category=lexer   # Run tests in a category
 *   node tests/test-suite.js --verbose          # Verbose output
 *   node tests/test-suite.js --help             # Show help
 */

const path = require('path');
const { loadTestSuite } = require('./test-loader.cjs');
const { runTestsWithOutput } = require('./test-runner.cjs');
const { registry } = require('./interpreter-interface.cjs');

/**
 * Parse command line arguments
 * @returns {Object} Parsed arguments
 */
function parseArgs() {
  const args = process.argv.slice(2);
  const options = {
    verbose: false,
    category: null,
    help: false,
    filter: null
  };

  for (const arg of args) {
    if (arg === '--verbose' || arg === '-v') {
      options.verbose = true;
    } else if (arg === '--help' || arg === '-h') {
      options.help = true;
    } else if (arg.startsWith('--category=')) {
      options.category = arg.split('=')[1];
    } else if (arg.startsWith('--filter=')) {
      options.filter = arg.split('=')[1];
    }
  }

  return options;
}

/**
 * Display help message
 */
function showHelp() {
  console.log(`
Weilang Test Suite

Usage:
  node tests/test-suite.js [options]

Options:
  --verbose, -v              Show verbose output
  --category=<name>          Run only tests in specified category
  --filter=<pattern>         Run only tests matching pattern
  --help, -h                 Show this help message

Examples:
  node tests/test-suite.js
  node tests/test-suite.js --category=lexer
  node tests/test-suite.js --filter=assignment
  node tests/test-suite.js --verbose

Categories:
  Use --category with one of: assignment, conditional, expression, function,
  intentionality, inscription, lexer, literal, loop, measurement, observer,
  operator, possibility, punctuation, quantifier, removal, temporal, complex

Interpreter Injection:
  To inject a real interpreter, use:

  const { registry } = require('./tests/interpreter-interface.js');
  const myInterpreter = {
    execute: (source, options) => { /* implementation */ },
    parse: (source) => { /* implementation */ },
    tokenize: (source) => { /* implementation */ }
  };
  registry.register(myInterpreter);
`);
}

/**
 * Main test suite runner
 */
function main() {
  const options = parseArgs();

  if (options.help) {
    showHelp();
    process.exit(0);
  }

  // Load test suite
  const artifactsDir = path.join(__dirname, 'artifacts');
  const suite = loadTestSuite(artifactsDir);

  // Apply filters
  let testsToRun = suite.tests;

  if (options.category) {
    testsToRun = suite.getCategory(options.category);
    if (testsToRun.length === 0) {
      console.error(`Error: No tests found in category '${options.category}'`);
      console.log(`Available categories: ${suite.categories.join(', ')}`);
      process.exit(1);
    }
    console.log(`Filtering by category: ${options.category}`);
  }

  if (options.filter) {
    const pattern = new RegExp(options.filter, 'i');
    testsToRun = testsToRun.filter(test => pattern.test(test.name));
    if (testsToRun.length === 0) {
      console.error(`Error: No tests found matching filter '${options.filter}'`);
      process.exit(1);
    }
    console.log(`Filtering by pattern: ${options.filter}`);
  }

  // Check interpreter status
  if (!registry.isAvailable()) {
    console.log('\n⚠️  Note: Interpreter not yet implemented.');
    console.log('   All tests will be skipped until an interpreter is registered.\n');
  }

  // Run tests
  const { summary } = runTestsWithOutput(testsToRun, options);

  // Exit with appropriate code
  process.exit(summary.failed > 0 ? 1 : 0);
}

// Run if executed directly
if (require.main === module) {
  main();
}

module.exports = { main, parseArgs, showHelp };
