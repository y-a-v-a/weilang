# Weilang AST Completeness Analysis

**Date**: 2025-11-18
**Status**: Analysis of grammar and AST coverage

---

## Summary

The Weilang grammar and AST are quite complete! Most concerns from the previous session are already handled. The main actual gaps are **array indexing syntax** and a missing **InscriptionNode** in the AST.

---

## Already Covered ✅

These items were flagged as "needs clarification" but are actually already handled by the current grammar:

### 1. Multiple Statements Per Possibility Branch
**Status**: ✅ Already supported

The grammar uses `statement+` in:
- Conditionals (Weilang.g4:110)
- Loops (Weilang.g4:130-132)
- `EITHER` blocks (Weilang.g4:18)

Example:
```weilang
IF AS IF |X|
    |Y| PLACED AS 5.
    |Z| PLACED AS 10.
    PRESENTED AS |Y| TO THE RECEIVER.
END AS IS
```

### 2. Multiple Material Qualities
**Status**: ✅ Already supported

Grammar line 78: `IDENTIFIER materialQuality* 'PLACED AS'`

The `*` quantifier allows zero or more qualities:
```weilang
|X| OF STONE POLISHED WEATHERED PLACED AS 5.
```

### 3. Observer Action Targets
**Status**: ✅ Already correct

- Only `PRESENTED AS` requires `TO THE RECEIVER` (line 154)
- All other observer actions (lines 155-163) work without targets
- AST models this with optional `target` field

---

## Design Decisions Needed ⚠️

These require interpreter-level decisions, not grammar changes:

### 1. Temporal/Intentionality Scope
**Current behavior**: Applied per statement (Weilang.g4:21-23)

**Question**: Should temporal markers apply to entire blocks or just single statements?

**Example**:
```weilang
AS IT WAS
    |X| PLACED AS 5.
    |Y| PLACED AS 10.
```

Does `AS IT WAS` apply to both assignments, or just `|X|`?

**Recommendation**: Keep statement-level for simplicity and explicitness. Users can repeat modifiers if needed:
```weilang
AS IT WAS |X| PLACED AS 5.
AS IT WAS |Y| PLACED AS 10.
```

---

### 2. Condition Type Semantics
**Current situation**: 13 different phenomenological conditions defined (lines 114-127)

**Question**: Do these all behave identically, or do they have different semantics?

**Analysis**:

| Condition | Likely Semantic Meaning |
|-----------|-------------------------|
| `expression` | Standard truthy evaluation |
| `expression EXCEEDS ALL MEASURE` | Greater than threshold |
| `expression DIMINISHED TO NOTHING` | Equals zero/null/empty |
| `expression REMAINS AS SUCH` | Truthy/unchanged |
| `expression TRANSFORMED BY PASSAGE` | Changed since last check (stateful!) |
| `expression IN DIRECT LINE WITH expression` | Equality |
| `expression ADJACENT TO expression` | Fuzzy equality/closeness |
| `WHEN PRESSURE APPLIED TO expression` | Force evaluation (side effects?) |
| `expression BESIDE ITSELF` | Self-contradictory/unstable |
| `expression IN TANDEM WITH expression` | Synchronized/paired values |
| `expression IN PLAIN SIGHT` | Visible/defined/not hidden |
| `expression WITHIN A REALM OF DISTANCE` | Spatially/semantically remote |

**Decision needed**: Document semantic mappings for interpreter implementation

**Recommendation**: Create a condition semantics table in the interpreter specification

---

### 3. Quantifier Semantics
**Current situation**: 10 quantifiers defined (lines 224-235)

**Question**: How should quantifiers affect runtime behavior?

**Options**:

**Option A: Probabilistic Modifiers**
- `ENOUGH |X|` → execute with probability based on X's value
- `TOO MUCH |Y|` → reduce execution probability
- Fits with Weiner's conceptual ambiguity

**Option B: Value Scaling**
- `A BIT OF 100` → 100 * 0.1 = 10
- `TOO MUCH 5` → 5 * 1.5 = 7.5
- Quantifiers modify the expression result

**Option C: Validation Hints**
- Assertions that can fail at runtime
- `ENOUGH |WATER|` throws error if insufficient
- More like runtime constraints

**Recommendation**: Option A (probabilistic) aligns best with Weiner's aesthetic and language philosophy

---

### 4. Measurement Unit Flexibility
**Current grammar**: `NUMBER measurementUnit?` (line 257)

**Question**: Should computed expressions support measurements?

**Currently invalid**:
```weilang
|RESULT| PLACED AS (|A| PUT TOGETHER |B|) INCHES.
```

**Options**:
- Keep current constraint (measurements only on literals)
- Extend to allow: `expression measurementUnit?`

**Recommendation**: Document as constraint for now. Add to grammar later if needed.

---

## Actual Gaps ❌

### 1. Array Indexing (Missing Feature)
**Status**: 🔴 Critical gap

**Grammar defines arrays**: `BITS & PIECES [1, 2, 3]` (line 277)

**Missing**: Syntax to access array elements

**Need to add**:
```weilang
|ITEM| PLACED AS |ARRAY| AT POSITION 2.
|ITEM| PLACED AS |ARRAY| EXTRACTED FROM 2.
|FIRST| PLACED AS THE BEGINNING OF |ARRAY|.
|LAST| PLACED AS THE END OF |ARRAY|.
```

**Suggested grammar addition**:
```antlr
expression
    : ...
    | expression 'AT POSITION' expression              // Array access
    | expression 'EXTRACTED FROM' expression           // Alternative syntax
    | 'THE BEGINNING OF' expression                    // First element
    | 'THE END OF' expression                          // Last element
    ;
```

**Required AST node**:
```javascript
export class ArrayAccessNode extends ASTNode {
  constructor(array, index, accessType = 'AT POSITION') {
    super('ArrayAccess');
    this.array = array;           // Expression (array)
    this.index = index;           // Expression (index)
    this.accessType = accessType; // 'AT POSITION', 'EXTRACTED FROM', etc.
  }
}
```

---

### 2. InscriptionNode Missing from AST
**Status**: 🔴 Critical gap

**Grammar defines inscriptions**: Lines 166-169
```antlr
inscription
    : 'IN RELATION TO' STRING      // Comment
    | 'DESCRIBED AS' STRING         // Metadata
    ;
```

**AST lacks**: No `InscriptionNode` defined in `src/ast/nodes.js`

**Impact**: Inscriptions (comments as poetic statements) will be lost during parsing

**Required AST node**:
```javascript
export class InscriptionNode extends ASTNode {
  /**
   * @param {string} inscriptionType - 'IN RELATION TO' or 'DESCRIBED AS'
   * @param {string} text - The inscription text (without quotes)
   */
  constructor(inscriptionType, text) {
    super('Inscription');
    this.inscriptionType = inscriptionType;
    this.text = text;
  }
}
```

**Note**: Inscriptions should be treated as statements (coreStatement in StatementNode), not ignored

---

### 3. Nested Possibilities (Design Question)
**Status**: ⚠️ Possibly missing

**Current grammar**: `possibility` can only contain `statement` (line 15)

**Question**: Should you be able to nest non-determinism?

**Example**:
```weilang
IF AS IF |X|
    |Y| PLACED AS 5
    OR NOT
    |Y| PLACED AS 10.
END AS IS
```

**Analysis**: Currently `statement+` in conditionals means multiple statements, but each statement can only be deterministic

**Decision needed**:
- If you want nested non-determinism, modify grammar to allow `possibility` inside statement blocks
- If you don't want it, document as intentional constraint

**Recommendation**: Probably not needed initially. Keep non-determinism at the top level for simplicity.

---

### 4. Function Parameters with Material Qualities (Low Priority)
**Status**: ⚠️ Possibly missing

**Current grammar**: `paramList: IDENTIFIER (',' IDENTIFIER)*` (lines 140-141)

**Question**: Should function parameters support material qualities?

**Example**:
```weilang
TO SHOW AND TO TELL |ADD| CALLED FOR |A| OF STONE, |B| OF WATER
    ...
END SHOW
```

**Analysis**: Qualities are currently only assignable in assignment statements (line 78)

**Recommendation**: Probably unnecessary. Qualities can be applied at assignment time inside function body. Keep parameter list simple.

---

## Action Items

### High Priority
1. **Add array indexing syntax to grammar** - Essential if supporting arrays
2. **Add InscriptionNode to AST** - Grammar defines it but AST doesn't model it
3. **Update AST visitor** - Add `visitArrayAccess()` and `visitInscription()` methods

### Medium Priority
4. **Document condition type semantics** - Create interpretation table for each phenomenological condition
5. **Define quantifier interpretation strategy** - Choose probabilistic/scaling/validation approach
6. **Create interpreter semantics document** - Centralize all design decisions

### Low Priority
7. **Document measurement constraints** - Clarify that only literals can have measurements (unless extended)
8. **Document temporal/intentionality scope** - Explicitly state these are statement-level only
9. **Decide on nested possibilities** - Document whether intentionally excluded or to be added

---

## Recommendations Summary

### Immediate Actions (Before Step 3)
1. Add array access expressions to `Weilang.g4`
2. Add `ArrayAccessNode` to `src/ast/nodes.js`
3. Add `InscriptionNode` to `src/ast/nodes.js`
4. Update `ASTVisitor` with new visit methods

### Documentation Needed
5. Create `docs/interpreter-semantics.md` with:
   - Condition type interpretation table
   - Quantifier behavior specification
   - Temporal/intentionality scope rules
   - Measurement unit constraints

### Design Decisions
6. Choose quantifier interpretation strategy (recommend: probabilistic)
7. Decide if nested possibilities are needed (recommend: no, keep simple)
8. Decide if measurement units on expressions are needed (recommend: no, keep constraint)

---

## Conclusion

The grammar is quite complete! Most of the "needs clarification" items are either already handled or require interpreter-level design decisions rather than grammar changes.

The only **critical gaps** are:
1. Array indexing syntax (if you're supporting arrays, you need access)
2. InscriptionNode in AST (grammar defines it but AST doesn't model it)

Everything else is a matter of documenting decisions for the interpreter implementation.

---

**Next Steps**:
1. Address the two critical gaps
2. Document design decisions
3. Proceed to Step 3 (AST Builder implementation)

**References**:
- Grammar: `/home/user/weilang/grammar/Weilang.g4`
- AST Nodes: `/home/user/weilang/src/ast/nodes.js`
- AST Specification: `/home/user/weilang/docs/ast-specification.md`
