grammar Weilang;

// ============================================================================
// WEILANG: A Lawrence Weiner-inspired esoteric programming language
// "The work need not be built. Each being equal and consistent with the intent."
// ============================================================================

// Parser rules
program
    : possibility* EOF
    ;

// Non-deterministic possibilities - the core unit of Weiner-code
possibility
    : statement
    | statement 'OR NOT' statement                    // Schrödinger's code
    | statement 'RATHER THAN' statement               // Alternative realities
    | 'EITHER' statement+ 'END EITHER'                // One chosen at runtime
    ;

statement
    : temporalMarker? intentionalityModifier? coreStatement punctuation?
    ;

// Punctuation affects execution semantics
punctuation
    : '.'      // Neutral/declarative
    | '!'      // Imperative/must execute
    | '?'      // Uncertain/maybe
    ;

// When/how the statement exists in time
temporalMarker
    : 'IN THE STILL OF THE NIGHT'    // Past continuous
    | 'AS IT WAS'                     // Simple past
    | 'AS IT WILL BE'                 // Future
    | 'ONCE & AGAIN'                  // Iterative past
    | 'NOT YET BUT SOON'              // Near future
    | 'ALWAYS ALREADY'                // Eternal present
    | 'WHEN PRESSURE APPLIED'         // Conditional temporal
    ;

// The receiver decides: modality of execution
intentionalityModifier
    : 'MAY BE CONSTRUCTED AS'         // Optional execution (prob < 1.0)
    | 'NEED NOT BE BUILT AS'          // Interpreter decides
    | 'IF AND WHEN RECEIVED AS'       // Runtime-dependent
    | 'AS IF TO BE'                   // Speculative/hypothetical
    | 'TO BE WITNESSED AS'            // Must be observed (side effect)
    ;

coreStatement
    : assignment
    | removal
    | conditional
    | loop
    | functionDecl
    | functionCall
    | returnStmt
    | observerAction
    | inscription
    ;

// Assignment with material qualities
assignment
    : IDENTIFIER materialQuality* 'PLACED AS' expression
    ;

// Variables have physical properties
materialQuality
    : 'OF STONE'          // Immutable
    | 'OF WATER'          // Volatile/ephemeral
    | 'OF STEEL'          // Strong-typed/rigid
    | 'OF GLASS'          // Transparent/debuggable
    | 'OF ASH'            // Write-once
    | 'OF PAPER'          // Mutable/fragile
    | 'POLISHED'          // Optimized
    | 'WEATHERED'         // Decays over time
    | 'SCATTERED'         // Distributed/parallel
    | 'COMPRESSED'        // Memory-optimized
    ;

// Weiner worked with removal and absence
removal
    : 'REMOVE' IDENTIFIER 'FROM THAT WHICH IS'
    | 'UN-PLACED AS' expression
    | 'ABSENCE OF' IDENTIFIER 'NOTED'
    | 'THE REMOVAL TO THE LATHING OF' IDENTIFIER
    ;

conditional
    : 'IF AS IF' condition statement+ ('OTHERWISE AS IS' statement+)? 'END AS IS'
    ;

// Phenomenological conditions
condition
    : expression                                      // Standard expression
    | expression 'EXCEEDS ALL MEASURE'                // > threshold
    | expression 'DIMINISHED TO NOTHING'              // == 0
    | expression 'REMAINS AS SUCH'                    // Truthy
    | expression 'TRANSFORMED BY PASSAGE'             // Changed since last check
    | expression 'IN DIRECT LINE WITH' expression     // Aligned/equal
    | expression 'ADJACENT TO' expression             // Close enough (fuzzy)
    | 'WHEN PRESSURE APPLIED TO' expression           // Force evaluation
    ;

loop
    : 'OVER AND OVER' condition statement+ 'END OVER'
    | 'UNTIL OTHERWISE' condition statement+ 'END OVER'
    | 'ONCE & AGAIN' expression statement+ 'END OVER'  // For-loop style
    ;

functionDecl
    : 'TO SHOW AND TO TELL' IDENTIFIER ('CALLED FOR' paramList)?
      statement+ 'END SHOW'
    ;

paramList
    : IDENTIFIER (',' IDENTIFIER)*
    ;

functionCall
    : IDENTIFIER 'CALLED FOR' (expression (',' expression)*)?
    ;

returnStmt
    : 'RETURN PLACED AS' expression
    ;

// The viewer/observer participates
observerAction
    : 'PRESENTED AS' expression 'TO THE RECEIVER'     // Output
    | 'HOLD IN MIND' IDENTIFIER                       // Mark for inspection
    | 'NOTED BUT NOT SHOWN' expression                // Silent computation
    ;

// Comments as poetic inscriptions (not ignored!)
inscription
    : 'IN RELATION TO' STRING                         // Comment
    | 'DESCRIBED AS' STRING                           // Metadata
    ;

// ============================================================================
// EXPRESSIONS
// ============================================================================

expression
    : literal
    | IDENTIFIER
    | spatialExpression
    | gesturalExpression
    | expression operator expression
    | 'WHAT REMAINS AFTER' expression operator expression  // Result of operation
    | 'THE LACK OF' expression                             // Negation/absence
    | '(' expression ')'
    ;

// Spatial/material operations (Weiner's physical dimension)
spatialExpression
    : expression 'PLACED UPON' expression                  // Layering
    | expression 'IN DIRECT LINE WITH' expression          // Alignment
    | expression 'ADJACENT TO' expression                  // Proximity
    | expression 'REMOVED TO THE LATHING OF' expression    // Depth/extraction
    | 'A' NUMBER 'x' NUMBER 'REMOVAL FROM' expression      // Dimensional operation
    ;

// Gestural/prepositional operators
gesturalExpression
    : expression 'THROWN FROM' expression 'TO' expression  // Range operation
    | expression 'SCATTERED ACROSS' expression             // Map/distribute
    | expression 'GATHERED INTO' expression                // Reduce/collect
    | expression 'PRESSED AGAINST' expression              // Concatenate
    | expression 'BROKEN AWAY FROM' expression             // Subtract/split
    | expression 'CRUSHED BETWEEN' expression              // Constrain/clamp
    | expression 'TOSSED FROM ONE TO ANOTHER'              // Transfer/move
    ;

operator
    : 'PUT TOGETHER'                                       // +
    | 'REMOVED FROM'                                       // -
    | 'OVER AND OVER'                                      // * (context-sensitive!)
    | 'SMASHED TO PIECES'                                  // /
    | 'TO BE DIMINISHED BY'                                // <
    | 'TO EXCEED'                                          // >
    | 'AS IS'                                              // ==
    | 'OTHER THAN'                                         // !=
    | 'WITH & WITH'                                        // AND
    | 'WITH OR WITHOUT'                                    // OR
    | 'WITHOUT'                                            // NOT
    | 'PUT TOGETHER TO PRESENT A SEMBLANCE OF A WHOLE'     // String concat
    ;

literal
    : NUMBER measurementUnit?
    | STRING
    | 'TRUE AS IS'
    | 'FALSE AS IS'
    | 'NOTHING AS SUCH'                                    // Null
    | arrayLiteral
    ;

// Physical measurements (Weiner often specified dimensions)
measurementUnit
    : 'INCHES'
    | 'FEET'
    | 'SQUARE FEET'
    | 'POUNDS'
    | 'DEGREES'
    | 'MOMENTS'           // Time unit
    | 'PIECES'            // Count unit
    ;

arrayLiteral
    : 'BITS & PIECES' '[' (expression (',' expression)*)? ']'
    ;

// ============================================================================
// LEXER RULES
// ============================================================================

IDENTIFIER
    : [A-Z][A-Z0-9_]*
    ;

NUMBER
    : [0-9]+ ('.' [0-9]+)?    // Support decimals
    ;

STRING
    : '"' (~["\r\n])* '"'
    ;

WS
    : [ \t\r\n]+ -> skip
    ;

// ============================================================================
// EXAMPLE PROGRAMS (as documentation)
// ============================================================================

/*

EXAMPLE 1: NON-DETERMINISTIC ASSIGNMENT
---------------------------------------
MATTER OF STONE PLACED AS 5 INCHES!

MAY BE CONSTRUCTED AS
    LIGHT OF WATER PLACED AS 10 DEGREES?

IN THE STILL OF THE NIGHT
    MATTER WAS PLACED AS 3.


EXAMPLE 2: SPATIAL OPERATIONS
------------------------------
WALL PLACED AS 100.
HOLE PLACED AS A 36 x 36 REMOVAL FROM WALL.

RESULT PLACED AS WALL REMOVED FROM HOLE!


EXAMPLE 3: OBSERVER-DEPENDENT
------------------------------
PARTICLE OF WATER PLACED AS 50.

TO BE WITNESSED AS
    PRESENTED AS PARTICLE TO THE RECEIVER.

ALWAYS ALREADY
    PARTICLE PLACED AS PARTICLE PUT TOGETHER 1?


EXAMPLE 4: POSSIBILITY SPACES
------------------------------
OUTCOME PLACED AS 5
RATHER THAN
OUTCOME PLACED AS 10.

PRESENTED AS OUTCOME TO THE RECEIVER!


EXAMPLE 5: GESTURAL EXPRESSIONS
--------------------------------
STONES PLACED AS BITS & PIECES [1, 2, 3, 4, 5].

SCATTERED PLACED AS STONES SCATTERED ACROSS 10 PIECES.
GATHERED PLACED AS SCATTERED GATHERED INTO 1 PIECES.


EXAMPLE 6: PHENOMENOLOGICAL CONDITIONS
---------------------------------------
MATTER PLACED AS 100 POUNDS.

IF AS IF MATTER EXCEEDS ALL MEASURE
    PRESENTED AS "TOO MUCH" TO THE RECEIVER!
OTHERWISE AS IS
    IF AS IF MATTER DIMINISHED TO NOTHING
        ABSENCE OF MATTER NOTED.
    END AS IS
END AS IS


EXAMPLE 7: TEMPORAL AMBIGUITY
------------------------------
AS IT WILL BE
    FUTURE_VALUE PLACED AS 999!

IN THE STILL OF THE NIGHT
    PAST_VALUE PLACED AS 111.

ALWAYS ALREADY
    ETERNAL_VALUE PLACED AS 42?


EXAMPLE 8: REMOVAL AND ABSENCE
-------------------------------
PRESENCE PLACED AS "HERE".

THE REMOVAL TO THE LATHING OF PRESENCE.

IF AS IF PRESENCE DIMINISHED TO NOTHING
    PRESENTED AS "ABSENCE ACHIEVED" TO THE RECEIVER!
END AS IS

*/
