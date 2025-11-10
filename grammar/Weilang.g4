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
    | 'FOREVER & A DAY'               // Infinite duration
    | 'AS LONG AS IT LASTS'           // Duration-dependent
    | 'IN DUE COURSE'                 // Eventually/eventually
    | 'AT THE SAME MOMENT'            // Simultaneous
    | 'IN THE COURSE OF EVENTS'       // During natural progression
    | 'AFTER HERE & THERE'            // Post-spatial
    ;

// The receiver decides: modality of execution
intentionalityModifier
    : 'MAY BE CONSTRUCTED AS'         // Optional execution (prob < 1.0)
    | 'NEED NOT BE BUILT AS'          // Interpreter decides
    | 'IF AND WHEN RECEIVED AS'       // Runtime-dependent
    | 'AS IF TO BE'                   // Speculative/hypothetical
    | 'TO BE WITNESSED AS'            // Must be observed (side effect)
    | 'PER SE'                        // Intrinsically/essentially
    | 'WITH INTENT'                   // Deliberate/purposeful
    | 'WITH MALICE AFORETHOUGHT'      // Pre-planned (legal term)
    | 'IN ALL INNOCENCE'              // Unintentional/naive
    | 'BE THAT AS IT MAY'             // Regardless/nevertheless
    | 'WITH MUCH ADO'                 // Ceremoniously/emphatically
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
    | 'OF SALT'           // Preservative/essential
    | 'OF LIMESTONE'      // Sedimentary/accumulated
    | 'OF SANDSTONE'      // Grainy/textured
    | 'OF WOOD'           // Natural/organic
    | 'OF IRON'           // Strong but oxidizable
    | 'OF GOLD'           // Precious/valuable
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
    | expression 'BESIDE ITSELF'                      // Self-contradictory/unstable
    | expression 'IN TANDEM WITH' expression          // Synchronized/paired
    | expression 'IN PLAIN SIGHT'                     // Visible/obvious
    | expression 'WITHIN A REALM OF DISTANCE'         // Spatially remote
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
    | 'TO SEE & BE SEEN' expression                   // Mutual observation
    | expression 'PLACED ON VIEW'                     // Make visible
    | expression 'REMOVED FROM VIEW'                  // Make hidden
    | expression 'OUT OF SIGHT'                       // Concealed
    | 'LO & BEHOLD' expression                        // Revelation/display
    | 'AS FAR AS THE EYE CAN SEE' expression          // Observable scope
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
    : literal                                                      // Primary
    | IDENTIFIER                                                   // Primary
    | '(' expression ')'                                           // Parenthesized
    | quantifier expression                                        // Prefix quantifier
    | 'THE LACK OF' expression                                     // Prefix negation
    | 'WHAT REMAINS AFTER' expression operator expression          // Ternary operation
    | 'A' NUMBER 'x' NUMBER 'REMOVAL FROM' expression              // Dimensional operation (prefix)
    | expression operator expression                               // Binary operators
    // Spatial/material operations (Weiner's physical dimension)
    | expression 'PLACED UPON' expression                          // Layering
    | expression 'IN DIRECT LINE WITH' expression                  // Alignment
    | expression 'ADJACENT TO' expression                          // Proximity
    | expression 'REMOVED TO THE LATHING OF' expression            // Depth/extraction
    | expression 'ON TOP OF' expression                            // Above/over
    | expression 'BENEATH' expression                              // Below/under
    | expression 'ABOVE' expression                                // Higher than
    | expression 'AROUND' expression                               // Surrounding
    | expression 'RIGHT IN THE MIDDLE OF' expression               // Centered within
    | expression 'AT THE LEVEL OF' expression                      // At same height/plane
    | expression 'WITHIN A REALM OF' expression                    // Contained conceptually
    | expression 'TWIXT' expression                                // Between (archaic)
    // Gestural/prepositional operators
    | expression 'THROWN FROM' expression 'TO' expression          // Range operation (ternary)
    | expression 'SCATTERED ACROSS' expression                     // Map/distribute
    | expression 'GATHERED INTO' expression                        // Reduce/collect
    | expression 'PRESSED AGAINST' expression                      // Concatenate
    | expression 'BROKEN AWAY FROM' expression                     // Subtract/split
    | expression 'CRUSHED BETWEEN' expression                      // Constrain/clamp
    | expression 'TOSSED FROM ONE TO ANOTHER'                      // Transfer/move (postfix)
    | expression 'STREWN ACROSS' expression                        // Distributed randomly
    | expression 'DISPERSED ACROSS' expression                     // Spread out
    | expression 'SUSPENDED FROM' expression                       // Hanging/deferred
    | expression 'BOLTED TO' expression                            // Fixed attachment
    | expression 'WELDED TO' expression                            // Fused permanently
    | expression 'FOLDED INTO' expression                          // Nested/incorporated
    | expression 'WRAPPED AROUND' expression                       // Enclosed/surrounded
    | expression 'KEPT APART FROM' expression                      // Separated/isolated
    | expression 'LEFT AS IS'                                      // Unchanged/identity (postfix)
    | expression 'SPLIT FROM' expression                           // Divided/separated
    | expression 'RENT FROM' expression                            // Torn from
    | expression 'SEVERED FROM' expression                         // Cut from
    | expression 'STACKED UPON' expression                         // Piled on
    | expression 'LAID UPON' expression                            // Placed flat on
    | expression 'KNEADED WITH' expression                         // Mixed/combined
    | expression 'FLOATED UPON' expression                         // Resting on surface
    ;

// Quantification (Weiner's vague measurements)
quantifier
    : 'ENOUGH'
    | 'NOT ENOUGH'
    | 'TOO MUCH'
    | 'A BIT OF'
    | 'A LITTLE BIT MORE'
    | 'MORE OR LESS'
    | 'GIVE OR TAKE'
    | 'SUFFICIENT'
    | 'MANY'
    | 'SOME'
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
    | 'AND/OR'                                             // Ambiguous conjunction (XOR or inclusive OR)
    | '&'                                                  // Ampersand conjunction
    | 'TWIXT'                                              // Between (can be operator too)
    | '±'                                                  // Plus-minus (uncertainty/approximation)
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

// Framed identifiers - inspired by Lawrence Weiner's use of rectangular frames around words
// Identifiers must be enclosed in pipes: |NAME|
// Can contain any text except pipes and newlines (allows spaces, keywords, single letters, etc.)
IDENTIFIER
    : '|' IDENTIFIER_CONTENT '|'
    ;

fragment IDENTIFIER_CONTENT
    : ( ~[|\r\n] )+
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
|MATTER| OF STONE PLACED AS 5 INCHES!

MAY BE CONSTRUCTED AS
    |LIGHT| OF WATER PLACED AS 10 DEGREES?

IN THE STILL OF THE NIGHT
    |MATTER| PLACED AS 3.


EXAMPLE 2: SPATIAL OPERATIONS
------------------------------
|WALL| PLACED AS 100.
|HOLE| PLACED AS A 36 x 36 REMOVAL FROM |WALL|.

|RESULT| PLACED AS |WALL| REMOVED FROM |HOLE|!


EXAMPLE 3: OBSERVER-DEPENDENT
------------------------------
|PARTICLE| OF WATER PLACED AS 50.

TO BE WITNESSED AS
    PRESENTED AS |PARTICLE| TO THE RECEIVER.

ALWAYS ALREADY
    |PARTICLE| PLACED AS |PARTICLE| PUT TOGETHER 1?


EXAMPLE 4: POSSIBILITY SPACES
------------------------------
|OUTCOME| PLACED AS 5
RATHER THAN
|OUTCOME| PLACED AS 10.

PRESENTED AS |OUTCOME| TO THE RECEIVER!


EXAMPLE 5: GESTURAL EXPRESSIONS
--------------------------------
|STONES| PLACED AS BITS & PIECES [1, 2, 3, 4, 5].

|SCATTERED| PLACED AS |STONES| SCATTERED ACROSS 10 PIECES.
|GATHERED| PLACED AS |SCATTERED| GATHERED INTO 1 PIECES.


EXAMPLE 6: PHENOMENOLOGICAL CONDITIONS
---------------------------------------
|MATTER| PLACED AS 100 POUNDS.

IF AS IF |MATTER| EXCEEDS ALL MEASURE
    PRESENTED AS "TOO MUCH" TO THE RECEIVER!
OTHERWISE AS IS
    IF AS IF |MATTER| DIMINISHED TO NOTHING
        ABSENCE OF |MATTER| NOTED.
    END AS IS
END AS IS


EXAMPLE 7: TEMPORAL AMBIGUITY
------------------------------
AS IT WILL BE
    |FUTURE VALUE| PLACED AS 999!

IN THE STILL OF THE NIGHT
    |PAST VALUE| PLACED AS 111.

ALWAYS ALREADY
    |ETERNAL VALUE| PLACED AS 42?


EXAMPLE 8: REMOVAL AND ABSENCE
-------------------------------
|PRESENCE| PLACED AS "HERE".

THE REMOVAL TO THE LATHING OF |PRESENCE|.

IF AS IF |PRESENCE| DIMINISHED TO NOTHING
    PRESENTED AS "ABSENCE ACHIEVED" TO THE RECEIVER!
END AS IS

*/
