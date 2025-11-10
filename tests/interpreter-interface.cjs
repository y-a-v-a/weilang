/**
 * Abstract interface for the Weilang interpreter
 *
 * This provides a contract for what the interpreter should implement.
 * When the interpreter is ready, inject it into the test runner.
 */

/**
 * Creates a mock interpreter that can be replaced with the real implementation
 * @returns {Object} Interpreter interface
 */
function createMockInterpreter() {
  return {
    /**
     * Execute Weilang source code
     * @param {string} source - The Weilang source code
     * @param {Object} options - Execution options
     * @returns {Object} Execution result with output, error, and ast
     */
    execute(source, options = {}) {
      return {
        success: false,
        output: '',
        error: 'Interpreter not yet implemented',
        ast: null,
        executionTime: 0
      };
    },

    /**
     * Parse Weilang source code without executing
     * @param {string} source - The Weilang source code
     * @returns {Object} Parse result with ast or error
     */
    parse(source) {
      return {
        success: false,
        ast: null,
        error: 'Parser not yet implemented'
      };
    },

    /**
     * Tokenize Weilang source code
     * @param {string} source - The Weilang source code
     * @returns {Object} Tokenization result
     */
    tokenize(source) {
      return {
        success: false,
        tokens: [],
        error: 'Lexer not yet implemented'
      };
    }
  };
}

/**
 * Interpreter registry for dependency injection
 */
class InterpreterRegistry {
  constructor() {
    this.interpreter = createMockInterpreter();
    this.hasRealInterpreter = false;
  }

  /**
   * Register a real interpreter implementation
   * @param {Object} interpreter - The interpreter instance
   */
  register(interpreter) {
    // Validate the interpreter has required methods
    const requiredMethods = ['execute', 'parse', 'tokenize'];
    for (const method of requiredMethods) {
      if (typeof interpreter[method] !== 'function') {
        throw new Error(`Interpreter must implement method: ${method}`);
      }
    }
    this.interpreter = interpreter;
    this.hasRealInterpreter = true;
  }

  /**
   * Get the current interpreter instance
   * @returns {Object} Interpreter instance
   */
  get() {
    return this.interpreter;
  }

  /**
   * Check if a real interpreter is registered
   * @returns {boolean} True if a real interpreter is available
   */
  isAvailable() {
    return this.hasRealInterpreter;
  }
}

// Singleton instance
const registry = new InterpreterRegistry();

module.exports = {
  createMockInterpreter,
  InterpreterRegistry,
  registry
};
