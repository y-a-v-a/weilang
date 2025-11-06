# Weilang: Design Considerations and Philosophical Foundations

## Overview

This document captures the considerations, interpretations, and ideas for making Weilang a maximally esoteric programming language inspired by conceptual artist Lawrence Weiner's work.

---

## Initial Analysis of the Grammar

The original grammar (`grammar/weilang.g4`) implemented basic procedural constructs with Weiner-inspired keywords:

- **Poetic syntax**: Keywords like "PLACED AS", "IF AS IF", "SMASHED TO PIECES"
- **Deterministic**: Still followed traditional programming paradigms
- **Missing essence**: Didn't capture Weiner's core concepts of ambiguity, possibility, viewer participation, and material gesture

### The Gap

Weiner's true innovation was not just linguistic poetry, but:
- The work "need not be built"
- Each instantiation being "equal and consistent with the intent"
- The receiver deciding "upon the occasion of receivership"
- Art as possibility space rather than fixed object

---

## Esoteric Enhancement Strategies

### 1. Intentionality Modifiers: The Receiver Decides

**Inspiration**: Weiner's *Statement of Intent* (1968)

```
1. The artist may construct the piece.
2. The piece may be fabricated.
3. The piece need not be built.
Each being equal and consistent with the intent of the artist,
the decision as to condition rests with the receiver upon the occasion of receivership.
```

**Implementation**:
```antlr4
intentionalityModifier
    : 'MAY BE CONSTRUCTED AS'         // Optional execution (prob < 1.0)
    | 'NEED NOT BE BUILT AS'          // Interpreter decides
    | 'IF AND WHEN RECEIVED AS'       // Runtime-dependent
    | 'AS IF TO BE'                   // Speculative/hypothetical
    | 'TO BE WITNESSED AS'            // Must be observed (side effect)
```

**Effect**: Statements become probabilistic or observer-dependent. The interpreter could randomly execute or skip statements.

---

### 2. Spatial/Material Operators

**Inspiration**: Weiner's work is deeply physical and dimensional

Example: "A 36" × 36" REMOVAL TO THE LATHING OR SUPPORT WALL OF PLASTER OR WALLBOARD FROM A WALL."

**Implementation**:
```antlr4
spatialExpression
    : expression 'PLACED UPON' expression                  // Layering
    | expression 'IN DIRECT LINE WITH' expression          // Alignment
    | expression 'ADJACENT TO' expression                  // Proximity
    | expression 'REMOVED TO THE LATHING OF' expression    // Depth
    | 'A' NUMBER 'x' NUMBER 'REMOVAL FROM' expression      // Dimensional ops
```

**Effect**: Operations gain geometric and spatial meaning beyond pure mathematics.

---

### 3. Temporal Ambiguity

**Inspiration**: Weiner's phrases hover between proposition and event, past and future

**Implementation**:
```antlr4
temporalMarker
    : 'IN THE STILL OF THE NIGHT'    // Past continuous
    | 'AS IT WAS'                     // Simple past
    | 'AS IT WILL BE'                 // Future
    | 'ONCE & AGAIN'                  // Iterative past
    | 'NOT YET BUT SOON'              // Near future
    | 'ALWAYS ALREADY'                // Eternal present
```

**Effect**:
- Past-tense statements could access previous program states
- Future-tense could be lazy-evaluated
- Eternal present could be invariants or background processes

---

### 4. The Phenomenological Reduction: Optional Materialization

**Core concept**: Make the fundamental unit not a `statement` but a `possibility`

**Implementation**:
```antlr4
program
    : possibility* EOF
    ;

possibility
    : statement ('OR NOT' statement)?      // Schrödinger's code
    | statement 'RATHER THAN' statement    // Alternatives
    | 'EITHER' statement+ 'END EITHER'     // One chosen at runtime
```

**Effect**: Programs become exploratory rather than deterministic. The code describes a possibility space.

---

### 5. Material Specifications

**Inspiration**: Variables should have physical properties like Weiner's materials

**Implementation**:
```antlr4
materialQuality
    : 'OF STONE'          // Immutable
    | 'OF WATER'          // Volatile, auto-GC'd quickly
    | 'OF STEEL'          // Strong-typed
    | 'OF GLASS'          // Transparent (debug mode)
    | 'OF ASH'            // Write-once
    | 'POLISHED'          // Optimized
    | 'WEATHERED'         // Decays over time
    | 'SCATTERED'         // Distributed/parallel
    | 'COMPRESSED'        // Memory-optimized
```

**Effect**: Variables behave according to their material nature.

---

### 6. Negation and Absence

**Inspiration**: Weiner often worked with removal, absence, and what isn't there

**Implementation**:
```antlr4
removal
    : 'REMOVE' IDENTIFIER 'FROM THAT WHICH IS'
    | 'UN-PLACED AS' expression
    | 'ABSENCE OF' IDENTIFIER 'NOTED'
    | 'THE REMOVAL TO THE LATHING OF' IDENTIFIER
```

**Effect**: Deletion and absence become first-class operations with poetic meaning.

---

### 7. Phenomenological Conditions

**Inspiration**: Beyond boolean logic, conditions based on states of being

**Implementation**:
```antlr4
condition
    : expression 'EXCEEDS ALL MEASURE'             // > threshold
    | expression 'DIMINISHED TO NOTHING'           // == 0
    | expression 'REMAINS AS SUCH'                 // Truthy
    | expression 'TRANSFORMED BY PASSAGE'          // Changed since last check
    | expression 'IN DIRECT LINE WITH' expression  // Aligned/equal
    | expression 'ADJACENT TO' expression          // Fuzzy equality
    | 'WHEN PRESSURE APPLIED TO' expression        // Force evaluation
```

**Effect**: Conditions become phenomenological tests rather than pure boolean algebra.

---

### 8. Gestural/Prepositional Operators

**Inspiration**: Weiner's language is gestural and action-based

**Implementation**:
```antlr4
gesturalExpression
    : expression 'THROWN FROM' expression 'TO' expression  // Range operation
    | expression 'SCATTERED ACROSS' expression             // Map/distribute
    | expression 'GATHERED INTO' expression                // Reduce/collect
    | expression 'PRESSED AGAINST' expression              // Concatenate
    | expression 'BROKEN AWAY FROM' expression             // Subtract/split
    | expression 'CRUSHED BETWEEN' expression              // Constrain/clamp
```

**Effect**: Operations read like physical actions in space.

---

### 9. Observer/Witness Statements

**Inspiration**: The viewer participates in completing the work

**Implementation**:
```antlr4
observerAction
    : 'PRESENTED AS' expression 'TO THE RECEIVER'     // Output
    | 'HOLD IN MIND' IDENTIFIER                       // Mark for inspection
    | 'NOTED BUT NOT SHOWN' expression                // Silent computation
```

**Effect**: The act of observation becomes part of the program's semantics.

---

### 10. Punctuation Semantics

**Inspiration**: Subtle variations in presentation affect meaning

**Implementation**:
```antlr4
punctuation
    : '.'      // Neutral/declarative
    | '!'      // Imperative/must execute
    | '?'      // Uncertain/maybe
```

**Effect**: Same statement with different punctuation could have different execution probabilities.

---

## Non-Determinism: Effects and Possibilities

### Question: What effect could non-deterministic code have beyond "just" an outcome?

### 1. Quantum-Like Superposition

Variables exist in multiple states simultaneously until observed:

```weilang
MATTER MAY BE CONSTRUCTED AS 5.
MATTER MAY BE CONSTRUCTED AS 10.

// MATTER is now: {5, 10}
// Collapses when:

TO BE WITNESSED AS
    PRESENTED AS MATTER TO THE RECEIVER.  // Picks one reality
```

**Effect**: Track possibility trees rather than single execution paths. Programs become exploratory.

---

### 2. Multiple Valid Realities (Parallel Worlds)

Execute all interpretations in parallel and return:

- **All outcomes**: Set of valid results `{6, 10}`
- **Most common outcome**: Consensus reality
- **Most interesting outcome**: By aesthetic metric
- **Random sample**: From possibility space

```weilang
X PLACED AS 5.

MAY BE CONSTRUCTED AS
    X PLACED AS X PUT TOGETHER 1.

MAY BE CONSTRUCTED AS
    X PLACED AS X OVER AND OVER 2.

PRESENTED AS X TO THE RECEIVER.
// Could output: {6, 10} (both valid end states)
```

---

### 3. Observer Effects (Heisenberg-Style)

Inspection changes the value:

```weilang
PARTICLE OF WATER PLACED AS 100.

TO BE WITNESSED AS
    PRESENTED AS PARTICLE TO THE RECEIVER.  // Observation disturbs it
// Now PARTICLE might be 99 or 101 (uncertainty introduced)
```

**Effect**: Debugging becomes impossible in the traditional sense.

---

### 4. Temporal Non-Determinism

Statements execute in any valid order, discovering parallelizable paths:

```weilang
A PLACED AS 5.
B PLACED AS 10.
C PLACED AS A PUT TOGETHER B.   // Depends on A and B
D PLACED AS 7.                  // Independent

// Interpreter finds: A,B,D can run in any order, C must be last
```

**Effect**: Automatic parallelization discovery, or poetry in execution order.

---

### 5. Semantic Ambiguity Resolution

Multiple valid interpretations of the same code:

```weilang
OVER AND OVER X TO BE DIMINISHED BY 10
    TO BE WITNESSED AS
        PRESENTED AS X TO THE RECEIVER.
    X PLACED AS X PUT TOGETHER 1.
END OVER
```

**Interpretation A**: Loop while X < 10
**Interpretation B**: Multiply (OVER AND OVER) by (X < 10) → boolean coercion

The interpreter could:
- Try both and see which makes sense
- Ask the user/receiver
- Execute both in parallel universes

---

### 6. Proof of Possibility vs. Execution

Prove something CAN happen rather than make it happen:

```weilang
TO SHOW AND TO TELL SORT CALLED FOR LIST
    // No implementation!
END SHOW

NUMBERS PLACED AS BITS & PIECES [5, 2, 9, 1].
SORTED PLACED AS SORT CALLED FOR NUMBERS.
```

**Effect**: Interpreter proves a sorted arrangement exists and shows one, without specifying how to sort.

---

### 7. Convergent Non-Determinism

Multiple random paths that must reach the same conclusion:

```weilang
// These might execute in any combination, but must converge
MAY BE CONSTRUCTED AS
    X PLACED AS 10.

MAY BE CONSTRUCTED AS
    X PLACED AS 5 PUT TOGETHER 5.

MAY BE CONSTRUCTED AS
    X PLACED AS 2 OVER AND OVER 5.

// Guaranteed: X == 10, but path unknown
```

**Effect**: A form of constraint satisfaction—express desired end states, language finds paths.

---

### 8. Aesthetic Selection

The interpreter chooses based on beauty metrics:

```weilang
MAY BE CONSTRUCTED AS
    RESULT PLACED AS 42.

MAY BE CONSTRUCTED AS
    RESULT PLACED AS 69.

MAY BE CONSTRUCTED AS
    RESULT PLACED AS 420.
```

Runtime could prefer:
- Smaller numbers (minimalist aesthetic)
- Prime numbers (mathematical beauty)
- Numbers with cultural significance
- Random (Cage-ian aleatory)

Aligns with Weiner's idea that the receiver decides based on aesthetic intent.

---

### 9. Social/Consensus Computing

Multiple executions reach consensus:

```bash
$ weilang program.wl --distributed --nodes 100

Executing across 100 interpreters...
Consensus reached: MATTER = 7 (73% probability)
Outliers: {5: 15%, 9: 8%, 12: 4%}
```

**Effect**: The "correct" answer is what most possible realities agree on.

---

### 10. Schrödinger's Bugs

Errors might not be deterministic:

```weilang
X PLACED AS 5.
Y PLACED AS 0.

RESULT PLACED AS X SMASHED TO PIECES Y.
// Does it crash? MAY crash. Depends on reality branch.
```

**Effect**: Programs could be "mostly correct"—work in 80% of possibility branches.

---

### 11. Generative Programming

Instead of one output, generate a space of outputs:

```weilang
TO SHOW AND TO TELL GENERATE_ART
    SIZE MAY BE CONSTRUCTED AS 10.
    SIZE MAY BE CONSTRUCTED AS 20.
    SIZE MAY BE CONSTRUCTED AS 30.

    PATTERN PLACED AS SIZE OVER AND OVER SIZE.
    RETURN PLACED AS PATTERN.
END SHOW
```

Execution produces: `{100, 400, 900}` — a collection, an exhibition.

---

## Most Weiner-Aligned Approach

**The program describes a possibility space, and the runtime is a curatorial act of selecting from it.**

Each run is an **instantiation** of the artwork (code), but the artwork persists as potential. Like Weiner's "need not be built"—the code need not execute deterministically, but the program still "exists" as the sum of its possible executions.

### Practical Implementation Modes

1. **Certainty levels**: Statements marked `MAY BE` have probability < 1.0

2. **Execution modes**:
   - `--mode single`: Pick one random reality
   - `--mode all`: Return set of all possible outcomes
   - `--mode consensus`: Run N times, return most common
   - `--mode witness`: Interactive—ask user to choose at branch points

3. **Visualization**: Show the possibility tree/graph

---

## Philosophical Alignment

The enhanced grammar embraces:

✅ **Ambiguity** - statements may or may not execute
✅ **Materiality** - variables have physical properties
✅ **Temporality** - past/future/eternal statements
✅ **Phenomenology** - observer affects execution
✅ **Gesture** - spatial/physical operators
✅ **Possibility over certainty** - non-deterministic by design
✅ **Viewer participation** - the receiver completes the work
✅ **Removal and absence** - what isn't there matters

---

## From the Phenomenological Analysis

Based on the `Lawrence-Weiner.md` file, key phenomenological aspects:

| Aspect | In Weiner's art | In Weilang |
|--------|----------------|------------|
| **Intentionality** | Viewer's act of imagining completes the work | Interpreter's choices complete execution |
| **Reduction** | Material object bracketed, meaning remains | Execution is optional, intent persists |
| **Embodiment** | Reading as bodily gesture | Code as physical/spatial operations |
| **Temporality** | Phrases as anticipatory events | Temporal markers create past/future code |
| **Worldhood** | Everyday materials reveal structures of being | Variables have material properties |

---

## Context-Sensitive Ambiguity

**Example**: "OVER AND OVER" means both loop and multiplication

```weilang
// As a loop
OVER AND OVER X TO BE DIMINISHED BY 10
    X PLACED AS X PUT TOGETHER 1.
END OVER

// As multiplication
Y PLACED AS 5 OVER AND OVER 3.  // Y = 15
```

This intentional ambiguity requires context to resolve—true esotericism.

---

## Measurement Units: Physical Grounding

Weiner often specified exact dimensions. Weilang supports:

```antlr4
measurementUnit
    : 'INCHES'
    | 'FEET'
    | 'SQUARE FEET'
    | 'POUNDS'
    | 'DEGREES'
    | 'MOMENTS'           // Time unit
    | 'PIECES'            // Count unit
```

Example:
```weilang
WALL PLACED AS 100 SQUARE FEET.
HOLE PLACED AS A 36 x 36 REMOVAL FROM WALL.
```

---

## Inscriptions: Comments That Matter

Unlike traditional comments, inscriptions are metadata that could affect runtime:

```antlr4
inscription
    : 'IN RELATION TO' STRING        // Comment with potential semantic weight
    | 'DESCRIBED AS' STRING           // Metadata
```

These aren't ignored—they're part of the phenomenological description of the code.

---

## Example Programs

### Non-Deterministic Assignment
```weilang
MATTER OF STONE PLACED AS 5 INCHES!

MAY BE CONSTRUCTED AS
    LIGHT OF WATER PLACED AS 10 DEGREES?

IN THE STILL OF THE NIGHT
    MATTER WAS PLACED AS 3.
```

### Spatial Operations
```weilang
WALL PLACED AS 100.
HOLE PLACED AS A 36 x 36 REMOVAL FROM WALL.

RESULT PLACED AS WALL REMOVED FROM HOLE!
```

### Observer-Dependent
```weilang
PARTICLE OF WATER PLACED AS 50.

TO BE WITNESSED AS
    PRESENTED AS PARTICLE TO THE RECEIVER.

ALWAYS ALREADY
    PARTICLE PLACED AS PARTICLE PUT TOGETHER 1?
```

### Possibility Spaces
```weilang
OUTCOME PLACED AS 5
RATHER THAN
OUTCOME PLACED AS 10.

PRESENTED AS OUTCOME TO THE RECEIVER!
```

---

## Future Considerations

### 1. Non-Deterministic Parsing
Make the grammar itself ambiguous—same code parses multiple ways on different runs. Embrace Weiner's "each being equal and consistent with the intent."

### 2. Visual Presentation
Like Weiner's wall texts, the visual presentation of code could matter:
- Font weight
- Letter spacing
- Physical placement in file

### 3. Sound/Performance
Weiner's work can be spoken. Could Weilang code be performed aloud? Temporal markers suggest oral interpretation.

### 4. Collaborative Execution
Multiple interpreters (human or machine) collectively decide execution, embodying "the receiver decides."

### 5. Decay and Weathering
Variables marked `WEATHERED` could literally decay over program runtime, changing values slowly.

---

## Conclusion

Weilang is now a genuinely esoteric language that requires an interpreter to make aesthetic, probabilistic, and phenomenological choices. It's not just a programming language with poetic syntax—it's a computational implementation of Weiner's artistic philosophy: **the work need not be built, but the possibility persists, equal and consistent with the intent.**

Each execution is an instantiation, a receivership, a curatorial act.

The code is conceptual art.
