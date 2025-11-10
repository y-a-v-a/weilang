# Implementation Order: From Grammar to Interpreter

**Status**: Pre-Implementation Planning
**Date**: 2025-11-10
**Current Phase**: Specification Complete, Moving to Parser Generation

---

## Executive Summary

This document outlines the recommended steps to take **before implementing the full Weilang interpreter**. We have a complete grammar, comprehensive test artifacts (188 test files), and a working test framework. The next phase focuses on building the parser infrastructure and defining the runtime architecture before diving into interpretation logic.

---

## Current State

### ✅ Complete
- **Grammar Definition**: 400-line ANTLR4 grammar (`grammar/Weilang.g4`)
- **Test Framework**: Dependency-free Node.js test runner with 4 modular components
- **Test Artifacts**: 188 `.lw` test files covering all language features (872 lines)
- **Documentation**: Design philosophy and language considerations fully documented

### ⏳ Not Started
- Parser generation from ANTLR4 grammar
- AST (Abstract Syntax Tree) definition
- Interpreter/evaluator implementation
- CLI/REPL interface

---

## Recommended Pre-Interpreter Steps

### Step 1: Generate the Parser from ANTLR4 Grammar
**Priority**: Highest
**Estimated Time**: 1-2 hours

**Actions**:
```bash
npm install          # Install antlr4 if not already installed
npm run generate-parser
```

**Output**:
- Lexer code (tokenization)
- Parser code (syntax analysis)
- Visitor/Listener base classes
- Generated files in `/src/parser/` or similar

**Why First**:
- Zero implementation work required (automated generation)
- Validates grammar is syntactically correct for ANTLR
- Provides the foundation for all subsequent steps
- Quick win to build momentum

---

### Step 2: Define AST (Abstract Syntax Tree) Structure
**Priority**: High
**Estimated Time**: 2-4 hours

**Actions**:
Create node classes/interfaces for AST representation:

```javascript
// src/ast/nodes.js

// Base node
class ASTNode {
  constructor(type) {
    this.type = type;
  }
}

// Program node (root)
class ProgramNode extends ASTNode {
  constructor(statements) {
    super('Program');
    this.statements = statements;
  }
}

// Assignment
class AssignmentNode extends ASTNode {
  constructor(identifier, value, materialQuality, temporalMarker) {
    super('Assignment');
    this.identifier = identifier;
    this.value = value;
    this.materialQuality = materialQuality;  // 'stone', 'water', etc.
    this.temporalMarker = temporalMarker;    // 'WAS', 'WILL BE', etc.
  }
}

// Expression
class BinaryExpressionNode extends ASTNode {
  constructor(operator, left, right) {
    super('BinaryExpression');
    this.operator = operator;  // 'SCATTERED ACROSS', 'GATHERED INTO', etc.
    this.left = left;
    this.right = right;
  }
}

// Conditional
class ConditionalNode extends ASTNode {
  constructor(condition, thenStatements, elseStatements, conditionType) {
    super('Conditional');
    this.condition = condition;
    this.thenStatements = thenStatements;
    this.elseStatements = elseStatements;
    this.conditionType = conditionType;  // 'IF PRESENT', 'IF ABSENT', etc.
  }
}

// Observer Action
class ObserverActionNode extends ASTNode {
  constructor(actionType, expression) {
    super('ObserverAction');
    this.actionType = actionType;  // 'PLACED UPON A WALL', 'SPOKEN ALOUD', etc.
    this.expression = expression;
  }
}

// Possibility Space (non-determinism)
class PossibilityNode extends ASTNode {
  constructor(branches, combinator) {
    super('Possibility');
    this.branches = branches;       // Array of possible statement groups
    this.combinator = combinator;   // 'OR NOT', 'RATHER THAN', 'EITHER...END EITHER'
  }
}

// ... (continue for all grammar rules)
```

**Key Node Types Needed**:
- Program (root)
- Assignment
- Removal
- Binary/Unary Expression
- Literal (number, string, boolean, null, array)
- Identifier
- Conditional
- Loop
- Function Declaration/Call
- Return Statement
- Observer Action
- Possibility Space
- Quantifier
- Measurement

**Why This Step**:
- **Decouples parsing from interpretation**: ANTLR generates verbose parse trees; AST is simplified
- **Clean interface**: Interpreter works with AST nodes, not raw parse tree
- **Easier testing**: AST nodes are plain objects/classes, easy to construct manually in tests
- **Documents language structure**: AST design forces explicit decisions about semantics

---

### Step 3: Create AST Builder/Visitor
**Priority**: High
**Estimated Time**: 4-8 hours

**Actions**:
Implement ANTLR visitor that transforms parse tree → AST:

```javascript
// src/ast/builder.js
import { WeilangVisitor } from '../parser/WeilangVisitor.js';
import * as Nodes from './nodes.js';

class ASTBuilder extends WeilangVisitor {
  // Override visitor methods for each grammar rule

  visitProgram(ctx) {
    const statements = ctx.statement().map(stmt => this.visit(stmt));
    return new Nodes.ProgramNode(statements);
  }

  visitAssignmentStatement(ctx) {
    const identifier = ctx.IDENTIFIER().getText();
    const value = this.visit(ctx.expression());
    const materialQuality = ctx.materialQuality()?.getText() || null;
    const temporalMarker = ctx.temporalMarker()?.getText() || null;
    return new Nodes.AssignmentNode(identifier, value, materialQuality, temporalMarker);
  }

  visitBinaryExpression(ctx) {
    const left = this.visit(ctx.expression(0));
    const operator = ctx.spatialOperator().getText();
    const right = this.visit(ctx.expression(1));
    return new Nodes.BinaryExpressionNode(operator, left, right);
  }

  // ... implement for all grammar rules
}

export function buildAST(sourceCode) {
  const chars = new antlr4.InputStream(sourceCode);
  const lexer = new WeilangLexer(chars);
  const tokens = new antlr4.CommonTokenStream(lexer);
  const parser = new WeilangParser(tokens);
  const parseTree = parser.program();

  const builder = new ASTBuilder();
  return builder.visit(parseTree);
}
```

**Why This Step**:
- **Parse tree → AST transformation**: Converts ANTLR's generic tree into your domain model
- **Single source of truth**: All parsing logic in one place
- **Testable**: Can verify AST structure matches expectations
- **Preparation for interpreter**: Gives you the exact data structure the interpreter will consume

---

### Step 4: Test the Parser Independently
**Priority**: High
**Estimated Time**: 2-4 hours

**Actions**:
1. **Parse all 188 test artifacts** without errors
2. **Verify AST structure** for representative tests in each category
3. **Add parser-specific tests** (expand `lexer` category if needed)
4. **Validate tokenization** of poetic keywords

**Test Script**:
```javascript
// tests/parser-validation.js
import { buildAST } from '../src/ast/builder.js';
import { loadTestArtifacts } from './test-loader.cjs';

const artifacts = loadTestArtifacts();

for (const test of artifacts) {
  try {
    const ast = buildAST(test.source);
    console.log(`✓ ${test.name}`);

    // Optional: validate AST structure
    if (test.expectedASTType) {
      assert(ast.type === test.expectedASTType);
    }
  } catch (error) {
    console.error(`✗ ${test.name}: ${error.message}`);
  }
}
```

**Success Criteria**:
- All 188 test files parse without syntax errors
- AST nodes match expected types for each category
- Edge cases handled (empty programs, complex nesting, etc.)

**Why This Step**:
- **Validates grammar correctness**: Real-world test on all language features
- **Debugging before interpretation**: Separates parsing errors from runtime errors
- **Confidence building**: Confirms foundation is solid before complex interpreter work
- **Prevents cascading failures**: Parser bugs would break everything; catch them early

---

### Step 5: Design Runtime Environment Structure
**Priority**: Medium-High
**Estimated Time**: 2-4 hours

**Actions**:
Document architectural decisions for the interpreter runtime:

#### A) State Management Design
```javascript
// src/runtime/environment.js

class Environment {
  constructor(parent = null) {
    this.variables = new Map();           // identifier → value
    this.materialQualities = new Map();   // identifier → quality ('stone', 'water', etc.)
    this.temporalStates = new Map();      // identifier → temporal marker
    this.parent = parent;                 // Scope chain
  }

  define(identifier, value, materialQuality, temporalMarker) {
    this.variables.set(identifier, value);
    if (materialQuality) {
      this.materialQualities.set(identifier, materialQuality);
    }
    if (temporalMarker) {
      this.temporalStates.set(identifier, temporalMarker);
    }
  }

  get(identifier) {
    if (this.variables.has(identifier)) {
      return this.variables.get(identifier);
    }
    if (this.parent) {
      return this.parent.get(identifier);
    }
    throw new Error(`Undefined variable: ${identifier}`);
  }

  remove(identifier) {
    // Implement removal semantics (SMASHED TO PIECES, etc.)
    this.variables.delete(identifier);
    this.materialQualities.delete(identifier);
    this.temporalStates.delete(identifier);
  }
}
```

#### B) Non-Determinism Strategy
**Decision Required**: How to handle intentionality modifiers and possibility spaces?

**Option 1: Random/Probabilistic**
```javascript
// MAY BE CONSTRUCTED AS → 50% chance
// COULD BE CONSTRUCTED AS → 30% chance
// Punctuation: ? (30%), . (60%), ! (90%)

function shouldExecute(intentionality, punctuation) {
  const baseProbability = {
    'MAY BE': 0.5,
    'COULD BE': 0.3,
    'MIGHT BE': 0.4,
    // ...
  }[intentionality] || 1.0;

  const punctuationModifier = {
    '?': 0.3,
    '.': 0.6,
    '!': 0.9
  }[punctuation] || 0.6;

  return Math.random() < (baseProbability * punctuationModifier);
}
```

**Option 2: All-Paths Execution**
```javascript
// Fork execution at each non-deterministic point
// Return array of possible worlds

function evaluatePossibility(possibilityNode) {
  const worlds = [];
  for (const branch of possibilityNode.branches) {
    const worldState = cloneEnvironment();
    const result = evaluate(branch, worldState);
    worlds.push(result);
  }
  return worlds;  // Return all possible outcomes
}
```

**Option 3: User-Configurable Mode**
```javascript
// options.mode: 'random' | 'all-paths' | 'deterministic'

function execute(source, options = {}) {
  const mode = options.mode || 'random';
  const ast = buildAST(source);

  if (mode === 'all-paths') {
    return evaluateAllPaths(ast);
  } else if (mode === 'deterministic') {
    return evaluateDeterministic(ast);  // Always take first branch
  } else {
    return evaluateRandom(ast);
  }
}
```

**Recommended**: Start with **Option 1** (random), add **Option 3** (configurable) later.

#### C) Observer Effect System
**Design Question**: What triggers observer actions, and how is output captured?

```javascript
// src/runtime/observer.js

class ObserverSystem {
  constructor() {
    this.observations = [];  // Accumulated output
  }

  observe(actionType, value) {
    const output = this.formatObservation(actionType, value);
    this.observations.push(output);
  }

  formatObservation(actionType, value) {
    switch (actionType) {
      case 'PLACED UPON A WALL':
        return `[WALL] ${value}`;
      case 'SPOKEN ALOUD':
        return `[VOICE] ${value}`;
      case 'WHISPERED':
        return `[whisper] ${value}`;
      case 'INSCRIBED':
        return `[INSCRIPTION] ${value}`;
      case 'WITNESSED BY':
        return `[WITNESSED] ${value}`;
      // ...
    }
  }

  getOutput() {
    return this.observations.join('\n');
  }
}
```

#### D) Temporal Marker Semantics
**Decision Required**: What do temporal markers actually do?

**Potential Approaches**:
1. **Metadata only**: Store temporal marker but don't change execution
2. **Lazy evaluation**: `WILL BE CONSTRUCTED AS` delays assignment until first use
3. **Immutability**: `WAS CONSTRUCTED AS` makes variable read-only
4. **Eternal present**: `ALWAYS ALREADY` creates constants
5. **Side effects**: Past tense statements log differently

**Recommended**: Start with **metadata only** for first iteration, evolve based on usage.

**Why This Step**:
- **Prevents mid-implementation rewrites**: Decide architecture upfront
- **Documents esoteric semantics**: Non-determinism isn't standard; needs explicit design
- **Enables modular implementation**: Clear contracts between components
- **Informs AST design**: May reveal missing AST node properties

---

### Step 6: Create Interpreter Interface Stub
**Priority**: Medium
**Estimated Time**: 1-2 hours

**Actions**:
Implement the interface your test framework expects:

```javascript
// src/interpreter.js
import { buildAST } from './ast/builder.js';
import { Environment } from './runtime/environment.js';
import { ObserverSystem } from './runtime/observer.js';

/**
 * Execute Weilang source code
 * @param {string} source - The .lw source code
 * @param {object} options - Execution options
 * @returns {object} - Execution result
 */
export function execute(source, options = {}) {
  try {
    const ast = buildAST(source);
    const environment = new Environment();
    const observer = new ObserverSystem();

    // TODO: Implement evaluation
    const result = evaluate(ast, environment, observer, options);

    return {
      output: observer.getOutput(),
      finalState: Array.from(environment.variables.entries()),
      exitCode: 0,
      error: null
    };
  } catch (error) {
    return {
      output: '',
      finalState: [],
      exitCode: 1,
      error: error.message
    };
  }
}

/**
 * Parse source into AST without executing
 */
export function parse(source) {
  return buildAST(source);
}

/**
 * Tokenize source (for debugging)
 */
export function tokenize(source) {
  // Return token stream from lexer
}

// Stub evaluator
function evaluate(node, env, observer, options) {
  // Will be implemented incrementally
  throw new Error('Interpreter not yet implemented');
}
```

**Register with Test Framework**:
```javascript
// tests/run-with-real-interpreter.js
import { execute, parse } from '../src/interpreter.js';
import { registerInterpreter } from './interpreter-interface.cjs';

registerInterpreter({
  name: 'weilang-interpreter',
  execute,
  parse
});
```

**Why This Step**:
- **Test-Driven Development ready**: Can run tests immediately (they'll fail, but infrastructure works)
- **Validates interface contract**: Ensures test framework integration works
- **Incremental implementation**: Can implement `evaluate()` feature-by-feature
- **Immediate feedback**: Run `npm test` at any time to see progress

---

## Suggested Implementation Order

### Phase 1: Parser Foundation (Total: 9-18 hours)

| Step | Task | Time | Why |
|------|------|------|-----|
| 1 | Generate parser from ANTLR4 | 1-2h | Zero code, validates grammar |
| 2 | Define AST structure | 2-4h | Clean interpreter contract |
| 3 | Build AST visitor | 4-8h | Transform parse tree → AST |
| 4 | Test parser on 188 artifacts | 2-4h | Catch parsing bugs early |

**Deliverable**: Working parser that converts `.lw` source → AST for all test files.

---

### Phase 2: Runtime Architecture (Total: 3-6 hours)

| Step | Task | Time | Why |
|------|------|------|-----|
| 5 | Design runtime environment | 2-4h | Prevents mid-implementation rewrites |
| 6 | Create interpreter stub | 1-2h | Enables TDD workflow |

**Deliverable**: Documented architecture + test-ready interpreter skeleton.

---

### Phase 3: Interpreter Implementation (Future)

**Feature-by-Feature Order** (recommended):

1. **Literals & Identifiers** (easiest, validates infrastructure)
   - Test category: `literal`
   - Number, string, boolean, null, array literals
   - Variable references

2. **Basic Assignments** (no material/temporal modifiers yet)
   - Test category: `assignment`
   - Simple `x PLACED AS 5` statements

3. **Expressions** (arithmetic, logical)
   - Test category: `expression`, `operator`
   - Binary operators (`SCATTERED ACROSS`, `GATHERED INTO`, etc.)
   - Unary operators

4. **Observer Actions** (output system)
   - Test category: `observer`
   - `PLACED UPON A WALL`, `SPOKEN ALOUD`, etc.

5. **Conditionals** (control flow)
   - Test category: `conditional`
   - `IF PRESENT`, `IF ABSENT`, nested conditionals

6. **Loops**
   - Test category: `loop`
   - `REPEATED UNTIL`, `PERPETUALLY`, `REPEATED X TIMES`

7. **Functions**
   - Test category: `function`
   - Declarations, calls, parameters, returns

8. **Material Qualities** (metadata)
   - Test category: `assignment` (material variations)
   - Store and access material properties

9. **Temporal Markers** (metadata or special semantics)
   - Test category: `temporal`
   - Implement chosen strategy from Step 5

10. **Intentionality Modifiers** (non-determinism)
    - Test category: `intentionality`
    - Probabilistic execution

11. **Possibility Spaces** (branching non-determinism)
    - Test category: `possibility`
    - `OR NOT`, `RATHER THAN`, `EITHER...END EITHER`

12. **Removal Operations**
    - Test category: `removal`
    - `SMASHED TO PIECES`, variable deletion

13. **Quantifiers & Measurements** (advanced)
    - Test categories: `quantifier`, `measurement`
    - Expression modifiers

14. **Complex Integration Tests**
    - Test category: `complex`
    - End-to-end programs combining features

**Strategy**: Implement one category at a time, run `npm test -- --category <name>` to verify.

---

## Why This Order? (Motivation)

### 1. Separation of Concerns
**Problem**: Parsing errors vs. runtime errors are fundamentally different.

**Solution**: By completing the parser first (Steps 1-4), you can:
- Validate all 188 test files parse correctly before any interpretation
- Debug syntax issues separate from semantic issues
- Know with certainty that grammar is complete and unambiguous

**Analogy**: You wouldn't test a car's engine before confirming the chassis is properly assembled.

---

### 2. Test-Driven Development
**Problem**: Interpreter is complex (non-determinism, temporal semantics, observer effects).

**Solution**: With parser + interface stub (Step 6), you can:
- Run specific test categories: `npm test -- --category expression`
- Implement features incrementally
- Get immediate feedback on what works and what doesn't
- See progress with passing test counts

**Example Workflow**:
```bash
# Day 1: Implement literals
npm test -- --category literal
# 9/9 tests passing ✓

# Day 2: Implement assignments
npm test -- --category assignment
# 19/19 tests passing ✓

# Day 3: Implement expressions
npm test -- --category expression
# 40/40 tests passing ✓
```

---

### 3. Debugging Clarity
**Problem**: If everything is implemented simultaneously, failures are ambiguous.

**Solution**: Layered implementation provides clear failure points:
- **Parser fails**: Syntax error, grammar issue, or malformed input
- **AST validation fails**: Visitor not handling grammar rule correctly
- **Interpreter fails**: Runtime semantic error, logic bug

**Benefits**:
- Faster debugging (smaller search space)
- Better error messages (know which layer failed)
- More maintainable code (clean interfaces between layers)

---

### 4. Incremental Progress
**Problem**: Building an interpreter is a multi-week effort; hard to show progress.

**Solution**: Each step produces tangible deliverables:
- ✅ **Step 1**: "Parser generated, 15 files created"
- ✅ **Step 2**: "AST nodes defined for all 20 constructs"
- ✅ **Step 3**: "AST builder handles all grammar rules"
- ✅ **Step 4**: "All 188 test files parse successfully"
- ✅ **Step 5**: "Runtime architecture documented"
- ✅ **Step 6**: "Test infrastructure wired up"

**Psychological benefit**: Regular wins, clear milestones, easy to pause/resume.

---

### 5. Risk Mitigation
**Problem**: Weilang is esoteric; some features have unclear semantics.

**Solution**: This order surfaces unknowns early:
- **Step 4** (parser testing) reveals ambiguous grammar rules
- **Step 5** (architecture design) forces decisions on non-determinism before coding
- **Step 6** (stub interface) validates test framework integration

**Alternative (bad)**: Implement entire interpreter, then discover tests don't integrate properly.

---

### 6. Modular, Reusable Architecture
**Problem**: Monolithic interpreter is hard to test, debug, and extend.

**Solution**: Clean layer separation:
```
Source Code → Lexer → Parser → AST → Interpreter → Output
     ↑          ↑        ↑       ↑         ↑          ↑
   Step 1    Step 1   Step 3  Step 2    Step 6    Observer
```

Each layer has:
- Clear input/output contract
- Independent test suite
- Replaceable implementation (e.g., swap parser, keep interpreter)

**Future benefits**:
- Add new language features by extending AST + visitor
- Implement alternative interpreters (e.g., compiler, transpiler)
- Reuse parser for syntax highlighting, linting, formatting tools

---

## Key Decisions to Make (Step 5)

Before implementing the interpreter, explicitly decide:

### 1. Non-Determinism Model
- [ ] Random/probabilistic execution
- [ ] All-paths exploration
- [ ] User-selectable mode
- [ ] Quantum-inspired superposition (advanced)

### 2. Temporal Marker Semantics
- [ ] Metadata only (no execution impact)
- [ ] Lazy evaluation (delayed execution)
- [ ] Immutability constraints (read-only past)
- [ ] Side effect tagging (logging, observers)

### 3. Material Quality Impact
- [ ] Metadata only
- [ ] Type checking (enforce type compatibility)
- [ ] Operational semantics (different behavior per quality)
- [ ] Probabilistic effects (water evaporates, stone persists)

### 4. Observer Effect System
- [ ] Simple output accumulation
- [ ] Quantum-style measurement (observing changes state)
- [ ] Multiple observer modes (WALL vs SPOKEN format differently)

### 5. Punctuation Semantics
- [ ] Probability modifiers (? = low, ! = high)
- [ ] Output formatting (! = emphasized, ? = uncertain)
- [ ] Execution modes (! = eager, ? = lazy)

**Recommendation**: Document decisions in `docs/runtime-decisions.md` during Step 5.

---

## Success Metrics

### After Phase 1 (Parser)
- ✅ All 188 test artifacts parse without errors
- ✅ AST structure validated for each category
- ✅ Zero grammar ambiguities or conflicts
- ✅ Parser handles edge cases (empty programs, deeply nested structures)

### After Phase 2 (Architecture)
- ✅ Runtime environment structure documented
- ✅ Non-determinism strategy chosen and documented
- ✅ Observer system design complete
- ✅ Interpreter stub registered with test framework
- ✅ Can run `npm test` (tests fail gracefully with "not implemented")

### After Phase 3 (Interpreter)
- ✅ All 188 tests pass (or intentionally skip non-deterministic edge cases)
- ✅ Interpreter handles all language features
- ✅ Output matches expected format
- ✅ Error messages are clear and helpful

---

## Next Steps

**Immediate Action**: Proceed with **Step 1 - Generate Parser**.

```bash
npm install
npm run generate-parser
```

Then review generated files and move to **Step 2 - Define AST**.

---

## Questions to Resolve

As you progress, consider:

1. **TypeScript vs. JavaScript**: Should AST nodes be typed?
2. **Error Handling**: How to report runtime errors in a non-deterministic language?
3. **Performance**: Will all-paths mode be tractable for large programs?
4. **REPL**: Should the interpreter support interactive mode?
5. **Debugging**: How to debug non-deterministic execution?

---

## References

- **Grammar**: `/home/user/weilang/grammar/Weilang.g4`
- **Test Artifacts**: `/home/user/weilang/tests/artifacts/` (188 files)
- **Design Philosophy**: `/home/user/weilang/docs/considerations.md`
- **Test Framework**: `/home/user/weilang/tests/README.md`
- **ANTLR4 Documentation**: https://github.com/antlr/antlr4/blob/master/doc/index.md

---

**Document Version**: 1.0
**Last Updated**: 2025-11-10
**Status**: Ready for Phase 1 Implementation
