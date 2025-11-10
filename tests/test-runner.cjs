/**
 * Test runner for Weilang test artifacts
 */

const assert = require('assert');
const { registry } = require('./interpreter-interface.cjs');

/**
 * ANSI color codes for terminal output
 */
const colors = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  dim: '\x1b[2m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m',
  gray: '\x1b[90m'
};

/**
 * Test result statuses
 */
const TestStatus = {
  PASS: 'pass',
  FAIL: 'fail',
  SKIP: 'skip',
  PENDING: 'pending'
};

/**
 * Formats duration in milliseconds
 * @param {number} ms - Duration in milliseconds
 * @returns {string} Formatted duration
 */
function formatDuration(ms) {
  if (ms < 1) return `${(ms * 1000).toFixed(0)}μs`;
  if (ms < 1000) return `${ms.toFixed(2)}ms`;
  return `${(ms / 1000).toFixed(2)}s`;
}

/**
 * Runs a single test artifact
 * @param {Object} test - Test artifact object
 * @param {Object} options - Test options
 * @returns {Object} Test result
 */
function runTest(test, options = {}) {
  const startTime = Date.now();
  const interpreter = registry.get();

  // Check if interpreter is available
  if (!registry.isAvailable()) {
    return {
      test,
      status: TestStatus.SKIP,
      message: 'Interpreter not yet implemented',
      duration: Date.now() - startTime,
      output: null,
      error: null
    };
  }

  try {
    // Execute the test
    const result = interpreter.execute(test.source, {
      filename: test.filename,
      ...options
    });

    const duration = Date.now() - startTime;

    if (!result.success) {
      return {
        test,
        status: TestStatus.FAIL,
        message: result.error || 'Execution failed',
        duration,
        output: result.output,
        error: result.error
      };
    }

    // For now, if it executes without error, it passes
    // In the future, we can add expected output assertions
    return {
      test,
      status: TestStatus.PASS,
      message: 'Executed successfully',
      duration,
      output: result.output,
      error: null
    };
  } catch (error) {
    return {
      test,
      status: TestStatus.FAIL,
      message: error.message,
      duration: Date.now() - startTime,
      output: null,
      error: error.stack
    };
  }
}

/**
 * Runs multiple tests
 * @param {Array} tests - Array of test artifacts
 * @param {Object} options - Test options
 * @returns {Object} Test results summary
 */
function runTests(tests, options = {}) {
  const results = [];
  const summary = {
    total: tests.length,
    passed: 0,
    failed: 0,
    skipped: 0,
    duration: 0
  };

  const startTime = Date.now();

  for (const test of tests) {
    const result = runTest(test, options);
    results.push(result);

    switch (result.status) {
      case TestStatus.PASS:
        summary.passed++;
        break;
      case TestStatus.FAIL:
        summary.failed++;
        break;
      case TestStatus.SKIP:
        summary.skipped++;
        break;
    }
  }

  summary.duration = Date.now() - startTime;

  return { results, summary };
}

/**
 * Formats a test result for display
 * @param {Object} result - Test result
 * @param {boolean} verbose - Show detailed output
 * @returns {string} Formatted result
 */
function formatResult(result, verbose = false) {
  const { test, status, message, duration } = result;
  let output = '';

  // Status icon
  const icon = {
    [TestStatus.PASS]: `${colors.green}✓${colors.reset}`,
    [TestStatus.FAIL]: `${colors.red}✗${colors.reset}`,
    [TestStatus.SKIP]: `${colors.yellow}○${colors.reset}`,
    [TestStatus.PENDING]: `${colors.gray}⋯${colors.reset}`
  }[status];

  // Test name
  output += `  ${icon} ${colors.dim}${test.category}/${colors.reset}${test.name}`;

  // Duration
  if (status !== TestStatus.SKIP) {
    output += ` ${colors.gray}(${formatDuration(duration)})${colors.reset}`;
  }

  output += '\n';

  // Error details in verbose mode or for failures/skips
  if ((verbose || status === TestStatus.FAIL || status === TestStatus.SKIP) && message) {
    const messageColor = status === TestStatus.FAIL ? colors.red : colors.yellow;
    output += `    ${messageColor}${message}${colors.reset}\n`;
  }

  if (verbose && result.output) {
    output += `    ${colors.dim}Output: ${result.output}${colors.reset}\n`;
  }

  return output;
}

/**
 * Formats a summary of test results
 * @param {Object} summary - Test summary
 * @returns {string} Formatted summary
 */
function formatSummary(summary) {
  const { total, passed, failed, skipped, duration } = summary;
  let output = '\n';

  output += `${colors.bright}Test Summary${colors.reset}\n`;
  output += `${'='.repeat(50)}\n`;

  // Stats
  output += `Total:   ${total}\n`;
  output += `${colors.green}Passed:  ${passed}${colors.reset}\n`;

  if (failed > 0) {
    output += `${colors.red}Failed:  ${failed}${colors.reset}\n`;
  }

  if (skipped > 0) {
    output += `${colors.yellow}Skipped: ${skipped}${colors.reset}\n`;
  }

  output += `Duration: ${formatDuration(duration)}\n`;
  output += `${'='.repeat(50)}\n`;

  // Overall status
  if (failed > 0) {
    output += `\n${colors.red}${colors.bright}FAILED${colors.reset}\n`;
  } else if (skipped === total) {
    output += `\n${colors.yellow}${colors.bright}ALL SKIPPED (Interpreter not implemented)${colors.reset}\n`;
  } else {
    output += `\n${colors.green}${colors.bright}PASSED${colors.reset}\n`;
  }

  return output;
}

/**
 * Runs tests with formatted output
 * @param {Array} tests - Array of test artifacts
 * @param {Object} options - Test options
 * @returns {Object} Test results
 */
function runTestsWithOutput(tests, options = {}) {
  const verbose = options.verbose || false;

  console.log(`\n${colors.bright}${colors.blue}Running Weilang Test Suite${colors.reset}`);
  console.log(`${colors.dim}Found ${tests.length} test(s)${colors.reset}\n`);

  const { results, summary } = runTests(tests, options);

  // Print results
  for (const result of results) {
    console.log(formatResult(result, verbose));
  }

  // Print summary
  console.log(formatSummary(summary));

  return { results, summary };
}

module.exports = {
  runTest,
  runTests,
  runTestsWithOutput,
  formatResult,
  formatSummary,
  formatDuration,
  TestStatus,
  colors
};
