# Weilang Test Framework

A dependency-free, pure Node.js test framework for the Weilang programming language. This framework uses only Node.js built-in modules (assert, fs, path) and is designed to test the Weilang interpreter once it's implemented.

## Architecture

The test framework consists of four main modules:

### 1. `interpreter-interface.cjs`
Provides an abstraction layer for the Weilang interpreter that hasn't been built yet.

**Key Features:**
- Mock interpreter that returns "not implemented" messages
- Registry pattern for dependency injection
- Validation of interpreter interface contracts
- Singleton instance for global access

### 2. `test-loader.cjs`
Discovers and loads test artifacts from the `tests/artifacts` directory.

**Key Features:**
- Automatic test discovery for `.lw` files
- Categorization based on filename patterns
- Grouping tests by category
- Filtering capabilities

### 3. `test-runner.cjs`
Executes tests and formats output using Node.js assert module.

**Key Features:**
- Individual and batch test execution
- Colored terminal output with ANSI codes
- Test status tracking (pass, fail, skip)
- Performance timing for each test
- Detailed error reporting

### 4. `test-suite.cjs`
Main entry point that ties everything together.

**Key Features:**
- Command-line argument parsing
- Category and pattern filtering
- Help system
- Exit codes for CI/CD integration

## Usage

### Using npm Scripts (Recommended)

The easiest way to run tests is using the npm scripts defined in `package.json`:

```bash
# Run all tests
npm test

# Run with verbose output
npm run test:verbose

# Show help
npm run test:help

# Run tests by category
npm run test:lexer
npm run test:assignment
npm run test:conditional
npm run test:expression
npm run test:function
npm run test:loop
npm run test:operator
npm run test:literal
npm run test:complex
```

### Direct Node.js Usage

You can also run the test suite directly:

#### Running All Tests

```bash
node tests/test-suite.cjs
```

#### Running Tests by Category

```bash
node tests/test-suite.cjs --category=lexer
node tests/test-suite.cjs --category=assignment
node tests/test-suite.cjs --category=conditional
```

#### Running Tests with Pattern Filter

```bash
node tests/test-suite.cjs --filter=assignment
node tests/test-suite.cjs --filter=loop
```

#### Verbose Output

```bash
node tests/test-suite.cjs --verbose
node tests/test-suite.cjs --category=lexer --verbose
```

#### Getting Help

```bash
node tests/test-suite.cjs --help
```

## Test Categories

Tests are automatically categorized based on filename prefixes:

- `assignment` - Variable assignment tests
- `conditional` - Conditional statement tests
- `expression` - Expression evaluation tests
- `function` - Function declaration and call tests
- `intentionality` - Intentionality modifier tests
- `inscription` - Comment and metadata tests
- `lexer` - Lexical analysis tests
- `literal` - Literal value tests
- `loop` - Loop construct tests
- `measurement` - Measurement unit tests
- `observer` - Observer action tests
- `operator` - Operator tests
- `possibility` - Possibility/non-deterministic tests
- `punctuation` - Punctuation mode tests
- `quantifier` - Quantifier tests
- `removal` - Variable removal tests
- `temporal` - Temporal marker tests
- `complex` - Complex integration tests

## Interpreter Injection

Once the Weilang interpreter is implemented, inject it into the test framework:

### Example Integration

```javascript
// In your interpreter module or test setup file
const { registry } = require('./tests/interpreter-interface.cjs');

// Your interpreter implementation
const weilangInterpreter = {
  /**
   * Execute Weilang source code
   * @param {string} source - The Weilang source code
   * @param {Object} options - Execution options
   * @returns {Object} Execution result
   */
  execute(source, options = {}) {
    // Your implementation here
    return {
      success: true,      // or false if execution failed
      output: '...',      // captured output
      error: null,        // error message if failed
      ast: {...},         // optional AST
      executionTime: 42   // optional execution time in ms
    };
  },

  /**
   * Parse Weilang source code without executing
   * @param {string} source - The Weilang source code
   * @returns {Object} Parse result
   */
  parse(source) {
    // Your implementation here
    return {
      success: true,
      ast: {...},
      error: null
    };
  },

  /**
   * Tokenize Weilang source code
   * @param {string} source - The Weilang source code
   * @returns {Object} Tokenization result
   */
  tokenize(source) {
    // Your implementation here
    return {
      success: true,
      tokens: [...],
      error: null
    };
  }
};

// Register the interpreter
registry.register(weilangInterpreter);
```

### In-File Test Setup

You can also create a setup file that registers the interpreter before running tests:

```javascript
// tests/setup.cjs
const { registry } = require('./interpreter-interface.cjs');
const interpreter = require('../src/interpreter.cjs'); // Your interpreter

registry.register(interpreter);
```

Then run:

```bash
node -r ./tests/setup.cjs tests/test-suite.cjs
```

## Test Artifacts

All test artifacts are stored in `tests/artifacts/` as `.lw` files. Each file contains valid Weilang source code that tests a specific feature.

### Example Artifact Structure

```
tests/artifacts/
├── assignment-basic.lw
├── assignment-of-stone.lw
├── conditional-basic.lw
├── loop-over-and-over.lw
├── lexer-identifiers.lw
└── ...
```

### Adding New Tests

1. Create a new `.lw` file in `tests/artifacts/`
2. Use a descriptive name with category prefix (e.g., `operator-new-feature.lw`)
3. The test will be automatically discovered and categorized
4. No configuration needed!

## Output Format

The test runner provides colored, formatted output:

- ✓ (green) - Test passed
- ✗ (red) - Test failed
- ○ (yellow) - Test skipped (interpreter not available)

### Example Output

```
Running Weilang Test Suite
Found 188 test(s)

  ○ assignment/assignment-basic
    Interpreter not yet implemented

  ○ assignment/assignment-compressed
    Interpreter not yet implemented

  ...

Test Summary
==================================================
Total:   188
Passed:  0
Skipped: 188
Duration: 0μs
==================================================

ALL SKIPPED (Interpreter not implemented)
```

## Exit Codes

The test suite returns appropriate exit codes for CI/CD integration:

- `0` - All tests passed or skipped
- `1` - One or more tests failed

## Future Enhancements

Once the interpreter is implemented, you can enhance the test framework with:

1. **Expected Output Assertions**: Add expected output to test artifacts
2. **Snapshot Testing**: Compare AST snapshots
3. **Performance Benchmarks**: Track execution time trends
4. **Coverage Reports**: Code coverage analysis
5. **Parallel Execution**: Run tests concurrently
6. **Test Generation**: Auto-generate tests from grammar

## Technical Details

### Dependencies

- **Node.js built-in modules only**:
  - `assert` - For assertions (ready for future use)
  - `fs` - For file system operations
  - `path` - For path manipulations

### File Format

- Pure JavaScript using CommonJS (`.cjs` extension)
- Compatible with ES module projects
- No transpilation or build step required

### Performance

- Fast test discovery using synchronous fs operations
- Minimal memory footprint
- Designed for hundreds of test files

## Contributing

To add new test categories or features:

1. Add test artifacts in `tests/artifacts/`
2. Tests are automatically discovered and categorized
3. Update this README if adding major features
4. Ensure all changes maintain zero external dependencies

## License

Same as the Weilang project.
