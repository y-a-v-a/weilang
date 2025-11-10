# Weilang AST Specification

**Version**: 1.0
**Date**: 2025-11-10
**Status**: Step 2 Complete

---

## Overview

The Weilang Abstract Syntax Tree (AST) is a simplified, interpreter-friendly representation of parsed Weilang programs. The AST decouples parsing from interpretation, providing clean interfaces for:

- Static analysis
- Optimization
- Code generation
- Interpretation/execution

---

## Design Principles

1. **Semantic Focus**: AST nodes represent semantic concepts, not syntactic details
2. **Metadata Preservation**: Temporal markers, intentionality modifiers, and punctuation are preserved
3. **Non-Determinism First-Class**: Possibility spaces are explicit AST structures
4. **Visitor Pattern Support**: Base visitor class for easy traversal
5. **Serializable**: Plain JavaScript objects (can be JSON-serialized)

---

## Node Type Hierarchy

```
ASTNode (base)
├── ProgramNode
├── PossibilityNode
├── StatementNode
├── Core Statements
│   ├── AssignmentNode
│   ├── RemovalNode
│   ├── ConditionalNode
│   ├── LoopNode
│   ├── FunctionDeclarationNode
│   ├── FunctionCallNode
│   ├── ReturnNode
│   └── ObserverActionNode
└── Expressions
    ├── BinaryExpressionNode
    ├── UnaryExpressionNode
    ├── IdentifierNode
    ├── LiteralNode
    ├── ArrayLiteralNode
    └── QuantifiedExpressionNode
```

---

## Node Type Reference

### ProgramNode

**Purpose**: Root node of the AST
**Fields**:
- `possibilities`: Array<PossibilityNode> - Top-level possibilities

**Example**:
```javascript
{
  type: 'Program',
  possibilities: [...]
}
```

---

### PossibilityNode

**Purpose**: Represents non-deterministic execution paths
**Fields**:
- `statements`: Array<StatementNode> - Primary statements
- `alternatives`: Array<StatementNode> | null - Alternative execution paths
- `combinator`: string | null - How alternatives combine: `'OR NOT'`, `'RATHER THAN'`, `'EITHER'`

**Example**: Simple possibility (single path)
```javascript
{
  type: 'Possibility',
  statements: [statement1, statement2],
  alternatives: null,
  combinator: null
}
```

**Example**: Non-deterministic choice
```javascript
{
  type: 'Possibility',
  statements: [assignmentA],
  alternatives: [assignmentB],
  combinator: 'OR NOT'
}
```

---

### StatementNode

**Purpose**: Wraps core statements with execution modifiers
**Fields**:
- `coreStatement`: ASTNode - The actual statement (assignment, conditional, etc.)
- `temporalMarker`: string | null - Temporal context: `'AS IT WAS'`, `'ALWAYS ALREADY'`, etc.
- `intentionalityModifier`: string | null - Execution modality: `'MAY BE CONSTRUCTED AS'`, etc.
- `punctuation`: string | null - Execution certainty: `'.'`, `'!'`, `'?'`

**Example**:
```javascript
{
  type: 'Statement',
  coreStatement: AssignmentNode,
  temporalMarker: 'AS IT WAS',
  intentionalityModifier: 'MAY BE CONSTRUCTED AS',
  punctuation: '?'
}
```

---

### AssignmentNode

**Purpose**: Variable creation or update
**Fields**:
- `identifier`: string - Variable name (without framing pipes)
- `value`: ExpressionNode - Value to assign
- `materialQualities`: Array<string> - Physical properties: `['OF STONE', 'POLISHED']`

**Example**:
```javascript
{
  type: 'Assignment',
  identifier: 'WEIGHT',
  value: LiteralNode(100),
  materialQualities: ['OF STONE', 'POLISHED']
}
```

---

### RemovalNode

**Purpose**: Variable deletion (Weiner's concept of absence)
**Fields**:
- `identifier`: string - Variable to remove
- `removalType`: string - Type of removal: `'REMOVE'`, `'UN-PLACED'`, `'ABSENCE OF'`, `'THE REMOVAL TO THE LATHING OF'`

**Example**:
```javascript
{
  type: 'Removal',
  identifier: 'TEMPORARY',
  removalType: 'SMASHED TO PIECES'
}
```

---

### ConditionalNode

**Purpose**: If/then/else control flow
**Fields**:
- `condition`: ExpressionNode - Condition to evaluate
- `thenStatements`: Array<StatementNode> - Execute if true
- `elseStatements`: Array<StatementNode> - Execute if false
- `conditionType`: string - Condition type: `'IF AS IF'`, `'IF PRESENT'`, `'IF ABSENT'`, etc.

**Example**:
```javascript
{
  type: 'Conditional',
  condition: IdentifierNode('VALUE'),
  thenStatements: [statement1, statement2],
  elseStatements: [statement3],
  conditionType: 'IF PRESENT'
}
```

---

### LoopNode

**Purpose**: Repetition constructs
**Fields**:
- `body`: Array<StatementNode> - Statements to repeat
- `loopType`: string - `'OVER AND OVER'`, `'UNTIL OTHERWISE'`, `'PERPETUALLY'`, `'REPEATED TIMES'`
- `condition`: ExpressionNode | null - Loop condition (for UNTIL OTHERWISE)
- `count`: ExpressionNode | null - Number of iterations (for REPEATED TIMES)
- `iteratorVar`: string | null - Iterator variable (for EACH IN)
- `iterableExpr`: ExpressionNode | null - Collection to iterate (for EACH IN)

**Example**: Fixed iteration count
```javascript
{
  type: 'Loop',
  body: [statement1],
  loopType: 'REPEATED TIMES',
  condition: null,
  count: LiteralNode(5),
  iteratorVar: null,
  iterableExpr: null
}
```

**Example**: For-each loop
```javascript
{
  type: 'Loop',
  body: [statement1],
  loopType: 'OVER AND OVER',
  condition: null,
  count: null,
  iteratorVar: 'ITEM',
  iterableExpr: IdentifierNode('ITEMS')
}
```

---

### FunctionDeclarationNode

**Purpose**: Function definition
**Fields**:
- `name`: string - Function name
- `parameters`: Array<string> - Parameter names
- `body`: Array<StatementNode> - Function body

**Example**:
```javascript
{
  type: 'FunctionDeclaration',
  name: 'ADD_NUMBERS',
  parameters: ['A', 'B'],
  body: [returnStatement]
}
```

---

### FunctionCallNode

**Purpose**: Function invocation
**Fields**:
- `name`: string - Function name
- `arguments`: Array<ExpressionNode> - Arguments to pass

**Example**:
```javascript
{
  type: 'FunctionCall',
  name: 'ADD_NUMBERS',
  arguments: [LiteralNode(5), LiteralNode(10)]
}
```

---

### ReturnNode

**Purpose**: Return value from function
**Fields**:
- `value`: ExpressionNode - Value to return

**Example**:
```javascript
{
  type: 'Return',
  value: IdentifierNode('RESULT')
}
```

---

### ObserverActionNode

**Purpose**: Output and observation
**Fields**:
- `actionType`: string - `'PLACED UPON A WALL'`, `'SPOKEN ALOUD'`, `'WHISPERED'`, `'INSCRIBED'`, `'PRESENTED AS'`, etc.
- `expression`: ExpressionNode - What to observe
- `target`: string | null - Observer target (e.g., `'THE RECEIVER'`)

**Example**:
```javascript
{
  type: 'ObserverAction',
  actionType: 'PLACED UPON A WALL',
  expression: IdentifierNode('RESULT'),
  target: null
}
```

---

### BinaryExpressionNode

**Purpose**: Two operands with operator
**Fields**:
- `operator`: string - Spatial/gestural operator: `'SCATTERED ACROSS'`, `'PUT TOGETHER'`, `'TO BE DIMINISHED BY'`, etc.
- `left`: ExpressionNode - Left operand
- `right`: ExpressionNode - Right operand

**Example**:
```javascript
{
  type: 'BinaryExpression',
  operator: 'PUT TOGETHER',
  left: IdentifierNode('A'),
  right: IdentifierNode('B')
}
```

---

### UnaryExpressionNode

**Purpose**: Single operand with operator
**Fields**:
- `operator`: string - `'THE LACK OF'`, `'WHAT REMAINS AFTER'`, `'WITHOUT'`
- `operand`: ExpressionNode

**Example**:
```javascript
{
  type: 'UnaryExpression',
  operator: 'THE LACK OF',
  operand: IdentifierNode('VALUE')
}
```

---

### IdentifierNode

**Purpose**: Variable reference
**Fields**:
- `name`: string - Variable name (without framing pipes)

**Example**:
```javascript
{
  type: 'Identifier',
  name: 'WEIGHT'
}
```

---

### LiteralNode

**Purpose**: Constant value
**Fields**:
- `value`: any - The literal value
- `literalType`: string - `'number'`, `'string'`, `'boolean'`, `'null'`
- `measurement`: string | null - Unit: `'INCHES'`, `'POUNDS'`, `'DEGREES'`, etc.

**Examples**:
```javascript
// Number
{ type: 'Literal', value: 42, literalType: 'number', measurement: null }

// Number with measurement
{ type: 'Literal', value: 100, literalType: 'number', measurement: 'POUNDS' }

// String
{ type: 'Literal', value: "hello", literalType: 'string', measurement: null }

// Boolean
{ type: 'Literal', value: true, literalType: 'boolean', measurement: null }

// Null
{ type: 'Literal', value: null, literalType: 'null', measurement: null }
```

---

### ArrayLiteralNode

**Purpose**: Array constant
**Fields**:
- `elements`: Array<ExpressionNode> - Array elements

**Example**:
```javascript
{
  type: 'ArrayLiteral',
  elements: [
    LiteralNode(1),
    LiteralNode(2),
    LiteralNode(3)
  ]
}
```

---

### QuantifiedExpressionNode

**Purpose**: Expression with quantifier modifier
**Fields**:
- `quantifier`: string - `'A'`, `'ENOUGH'`, `'NOT ENOUGH'`, `'TOO MUCH'`, `'A BIT OF'`, `'MANY'`, `'SOME'`, etc.
- `expression`: ExpressionNode

**Example**:
```javascript
{
  type: 'QuantifiedExpression',
  quantifier: 'A BIT OF',
  expression: IdentifierNode('WATER')
}
```

---

## Complete AST Examples

### Example 1: Simple Assignment

**Weilang Code**:
```weilang
|SIMPLE| PLACED AS 100.
```

**AST**:
```javascript
{
  type: 'Program',
  possibilities: [
    {
      type: 'Possibility',
      statements: [
        {
          type: 'Statement',
          coreStatement: {
            type: 'Assignment',
            identifier: 'SIMPLE',
            value: {
              type: 'Literal',
              value: 100,
              literalType: 'number',
              measurement: null
            },
            materialQualities: []
          },
          temporalMarker: null,
          intentionalityModifier: null,
          punctuation: '.'
        }
      ],
      alternatives: null,
      combinator: null
    }
  ]
}
```

---

### Example 2: Assignment with Material Quality

**Weilang Code**:
```weilang
|WEIGHT| OF STONE PLACED AS 500 POUNDS!
```

**AST**:
```javascript
{
  type: 'Program',
  possibilities: [
    {
      type: 'Possibility',
      statements: [
        {
          type: 'Statement',
          coreStatement: {
            type: 'Assignment',
            identifier: 'WEIGHT',
            value: {
              type: 'Literal',
              value: 500,
              literalType: 'number',
              measurement: 'POUNDS'
            },
            materialQualities: ['OF STONE']
          },
          temporalMarker: null,
          intentionalityModifier: null,
          punctuation: '!'
        }
      ],
      alternatives: null,
      combinator: null
    }
  ]
}
```

---

### Example 3: Binary Expression

**Weilang Code**:
```weilang
|RESULT| PLACED AS |A| PUT TOGETHER |B|.
```

**AST**:
```javascript
{
  type: 'Program',
  possibilities: [
    {
      type: 'Possibility',
      statements: [
        {
          type: 'Statement',
          coreStatement: {
            type: 'Assignment',
            identifier: 'RESULT',
            value: {
              type: 'BinaryExpression',
              operator: 'PUT TOGETHER',
              left: {
                type: 'Identifier',
                name: 'A'
              },
              right: {
                type: 'Identifier',
                name: 'B'
              }
            },
            materialQualities: []
          },
          temporalMarker: null,
          intentionalityModifier: null,
          punctuation: '.'
        }
      ],
      alternatives: null,
      combinator: null
    }
  ]
}
```

---

### Example 4: Temporal + Intentionality

**Weilang Code**:
```weilang
AS IT WAS
MAY BE CONSTRUCTED AS
    |VALUE| PLACED AS 42?
```

**AST**:
```javascript
{
  type: 'Program',
  possibilities: [
    {
      type: 'Possibility',
      statements: [
        {
          type: 'Statement',
          coreStatement: {
            type: 'Assignment',
            identifier: 'VALUE',
            value: {
              type: 'Literal',
              value: 42,
              literalType: 'number',
              measurement: null
            },
            materialQualities: []
          },
          temporalMarker: 'AS IT WAS',
          intentionalityModifier: 'MAY BE CONSTRUCTED AS',
          punctuation: '?'
        }
      ],
      alternatives: null,
      combinator: null
    }
  ]
}
```

---

### Example 5: Non-Determinism

**Weilang Code**:
```weilang
|OUTCOME| PLACED AS 5
OR NOT
|OUTCOME| PLACED AS 10.
```

**AST**:
```javascript
{
  type: 'Program',
  possibilities: [
    {
      type: 'Possibility',
      statements: [
        {
          type: 'Statement',
          coreStatement: {
            type: 'Assignment',
            identifier: 'OUTCOME',
            value: { type: 'Literal', value: 5, literalType: 'number', measurement: null },
            materialQualities: []
          },
          temporalMarker: null,
          intentionalityModifier: null,
          punctuation: null
        }
      ],
      alternatives: [
        {
          type: 'Statement',
          coreStatement: {
            type: 'Assignment',
            identifier: 'OUTCOME',
            value: { type: 'Literal', value: 10, literalType: 'number', measurement: null },
            materialQualities: []
          },
          temporalMarker: null,
          intentionalityModifier: null,
          punctuation: '.'
        }
      ],
      combinator: 'OR NOT'
    }
  ]
}
```

---

### Example 6: Conditional

**Weilang Code**:
```weilang
IF AS IF |VALUE|
    |VALUE| PLACED UPON A WALL.
END AS IS
```

**AST**:
```javascript
{
  type: 'Program',
  possibilities: [
    {
      type: 'Possibility',
      statements: [
        {
          type: 'Statement',
          coreStatement: {
            type: 'Conditional',
            condition: {
              type: 'Identifier',
              name: 'VALUE'
            },
            thenStatements: [
              {
                type: 'Statement',
                coreStatement: {
                  type: 'ObserverAction',
                  actionType: 'PLACED UPON A WALL',
                  expression: {
                    type: 'Identifier',
                    name: 'VALUE'
                  },
                  target: null
                },
                temporalMarker: null,
                intentionalityModifier: null,
                punctuation: '.'
              }
            ],
            elseStatements: [],
            conditionType: 'IF AS IF'
          },
          temporalMarker: null,
          intentionalityModifier: null,
          punctuation: null
        }
      ],
      alternatives: null,
      combinator: null
    }
  ]
}
```

---

### Example 7: Loop

**Weilang Code**:
```weilang
OVER AND OVER EACH |ITEM| IN |ITEMS|
    |ITEM| PLACED UPON A WALL.
END OVER.
```

**AST**:
```javascript
{
  type: 'Program',
  possibilities: [
    {
      type: 'Possibility',
      statements: [
        {
          type: 'Statement',
          coreStatement: {
            type: 'Loop',
            body: [
              {
                type: 'Statement',
                coreStatement: {
                  type: 'ObserverAction',
                  actionType: 'PLACED UPON A WALL',
                  expression: {
                    type: 'Identifier',
                    name: 'ITEM'
                  },
                  target: null
                },
                temporalMarker: null,
                intentionalityModifier: null,
                punctuation: '.'
              }
            ],
            loopType: 'OVER AND OVER',
            condition: null,
            count: null,
            iteratorVar: 'ITEM',
            iterableExpr: {
              type: 'Identifier',
              name: 'ITEMS'
            }
          },
          temporalMarker: null,
          intentionalityModifier: null,
          punctuation: '.'
        }
      ],
      alternatives: null,
      combinator: null
    }
  ]
}
```

---

## AST Visitor Pattern

Use the `ASTVisitor` base class to traverse the AST:

```javascript
import { ASTVisitor } from './ast/nodes.js';

class MyInterpreter extends ASTVisitor {
  constructor() {
    super();
    this.environment = new Map();
  }

  visitAssignment(node) {
    const value = this.visit(node.value);
    this.environment.set(node.identifier, value);
  }

  visitIdentifier(node) {
    return this.environment.get(node.name);
  }

  visitLiteral(node) {
    return node.value;
  }

  visitBinaryExpression(node) {
    const left = this.visit(node.left);
    const right = this.visit(node.right);

    switch (node.operator) {
      case 'PUT TOGETHER':
        return left + right;
      case 'TO BE DIMINISHED BY':
        return left - right;
      // ... more operators
    }
  }
}

// Usage
const interpreter = new MyInterpreter();
interpreter.visit(ast);
```

---

## Next Steps

With the AST defined, the next steps are:

1. **Step 3: Create AST Builder** - Implement ANTLR visitor to convert parse tree → AST
2. **Step 4: Test Parser** - Validate AST generation for all 188 test artifacts
3. **Step 5: Design Runtime** - Environment, non-determinism strategy, observer system
4. **Step 6: Implement Interpreter** - Build evaluator using visitor pattern

---

## References

- Grammar: `/home/user/weilang/grammar/Weilang.g4`
- AST Nodes: `/home/user/weilang/src/ast/nodes.js`
- Implementation Order: `/home/user/weilang/docs/implementation-order.md`

---

**Document Version**: 1.0
**Last Updated**: 2025-11-10
**Status**: Complete - Ready for Step 3
