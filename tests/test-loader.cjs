/**
 * Test loader for discovering and loading Weilang test artifacts
 */

const fs = require('fs');
const path = require('path');

/**
 * Categorizes test files by their naming convention
 * @param {string} filename - Test filename
 * @returns {Object} Category information
 */
function categorizeTest(filename) {
  const name = path.basename(filename, '.lw');
  const parts = name.split('-');

  if (parts.length === 0) {
    return { category: 'uncategorized', subcategory: null, name };
  }

  const category = parts[0];
  const subcategory = parts.slice(1).join('-');

  return { category, subcategory, name };
}

/**
 * Loads a single test artifact
 * @param {string} filePath - Path to the test file
 * @returns {Object} Test artifact object
 */
function loadTestArtifact(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const filename = path.basename(filePath);
  const { category, subcategory, name } = categorizeTest(filename);

  return {
    filename,
    name,
    category,
    subcategory,
    path: filePath,
    source: content,
    size: content.length,
    lines: content.split('\n').length
  };
}

/**
 * Discovers all test artifacts in a directory
 * @param {string} artifactsDir - Directory containing test artifacts
 * @returns {Array} Array of test artifact objects
 */
function discoverTests(artifactsDir) {
  const files = fs.readdirSync(artifactsDir);
  const testFiles = files.filter(file => {
    return file.endsWith('.lw') && fs.statSync(path.join(artifactsDir, file)).isFile();
  });

  return testFiles.map(file => {
    return loadTestArtifact(path.join(artifactsDir, file));
  });
}

/**
 * Groups tests by category
 * @param {Array} tests - Array of test artifacts
 * @returns {Object} Tests grouped by category
 */
function groupByCategory(tests) {
  const grouped = {};

  for (const test of tests) {
    if (!grouped[test.category]) {
      grouped[test.category] = [];
    }
    grouped[test.category].push(test);
  }

  return grouped;
}

/**
 * Loads all tests and provides organized access
 * @param {string} artifactsDir - Directory containing test artifacts
 * @returns {Object} Test suite object
 */
function loadTestSuite(artifactsDir) {
  const tests = discoverTests(artifactsDir);
  const grouped = groupByCategory(tests);
  const categories = Object.keys(grouped).sort();

  return {
    tests,
    grouped,
    categories,
    count: tests.count,

    /**
     * Get tests by category
     * @param {string} category - Category name
     * @returns {Array} Tests in that category
     */
    getCategory(category) {
      return grouped[category] || [];
    },

    /**
     * Get a specific test by name
     * @param {string} name - Test name
     * @returns {Object|null} Test artifact or null
     */
    getTest(name) {
      return tests.find(t => t.name === name) || null;
    },

    /**
     * Filter tests by a predicate function
     * @param {Function} predicate - Filter function
     * @returns {Array} Filtered tests
     */
    filter(predicate) {
      return tests.filter(predicate);
    }
  };
}

module.exports = {
  loadTestArtifact,
  discoverTests,
  groupByCategory,
  loadTestSuite,
  categorizeTest
};
