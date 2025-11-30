parser grammar WeilangExpressions;

// ============================================================================
// WEILANG EXPRESSIONS: Expression syntax, operators, and quantifiers
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
