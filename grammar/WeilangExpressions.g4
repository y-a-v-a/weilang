parser grammar WeilangExpressions;

// ============================================================================
// WEILANG EXPRESSIONS: Expression syntax, operators, and quantifiers
// ============================================================================

expression
    : literal                                                      // Primary
    | IDENTIFIER                                                   // Primary
    | LPAREN expression RPAREN                                     // Parenthesized
    | quantifier expression                                        // Prefix quantifier
    | THE_LACK_OF expression                                       // Prefix negation
    | WHAT_REMAINS_AFTER expression operator expression            // Ternary operation
    | A NUMBER TIMES NUMBER REMOVAL_FROM expression                // Dimensional operation (prefix)
    | expression operator expression                               // Binary operators
    // Spatial/material operations (Weiner's physical dimension)
    | expression PLACED_UPON expression                            // Layering
    | expression IN_DIRECT_LINE_WITH expression                    // Alignment
    | expression ADJACENT_TO expression                            // Proximity
    | expression REMOVED_TO_THE_LATHING_OF_EXPR expression         // Depth/extraction
    | expression ON_TOP_OF expression                              // Above/over
    | expression BENEATH expression                                // Below/under
    | expression ABOVE expression                                  // Higher than
    | expression AROUND expression                                 // Surrounding
    | expression RIGHT_IN_THE_MIDDLE_OF expression                 // Centered within
    | expression AT_THE_LEVEL_OF expression                        // At same height/plane
    | expression WITHIN_A_REALM_OF expression                      // Contained conceptually
    | expression TWIXT expression                                  // Between (archaic)
    // Gestural/prepositional operators
    | expression THROWN_FROM expression TO expression              // Range operation (ternary)
    | expression SCATTERED_ACROSS expression                       // Map/distribute
    | expression GATHERED_INTO expression                          // Reduce/collect
    | expression PRESSED_AGAINST expression                        // Concatenate
    | expression BROKEN_AWAY_FROM expression                       // Subtract/split
    | expression CRUSHED_BETWEEN expression                        // Constrain/clamp
    | expression TOSSED_FROM_ONE_TO_ANOTHER                        // Transfer/move (postfix)
    | expression STREWN_ACROSS expression                          // Distributed randomly
    | expression DISPERSED_ACROSS expression                       // Spread out
    | expression SUSPENDED_FROM expression                         // Hanging/deferred
    | expression BOLTED_TO expression                              // Fixed attachment
    | expression WELDED_TO expression                              // Fused permanently
    | expression FOLDED_INTO expression                            // Nested/incorporated
    | expression WRAPPED_AROUND expression                         // Enclosed/surrounded
    | expression KEPT_APART_FROM expression                        // Separated/isolated
    | expression LEFT_AS_IS                                        // Unchanged/identity (postfix)
    | expression SPLIT_FROM expression                             // Divided/separated
    | expression RENT_FROM expression                              // Torn from
    | expression SEVERED_FROM expression                           // Cut from
    | expression STACKED_UPON expression                           // Piled on
    | expression LAID_UPON expression                              // Placed flat on
    | expression KNEADED_WITH expression                           // Mixed/combined
    | expression FLOATED_UPON expression                           // Resting on surface
    ;

// Quantification (Weiner's vague measurements)
quantifier
    : ENOUGH
    | NOT_ENOUGH
    | TOO_MUCH
    | A_BIT_OF
    | A_LITTLE_BIT_MORE
    | MORE_OR_LESS
    | GIVE_OR_TAKE
    | SUFFICIENT
    | MANY
    | SOME
    ;

operator
    : PUT_TOGETHER                                       // +
    | REMOVAL_FROM                                       // -
    | OVER_AND_OVER                                      // * (context-sensitive!)
    | SMASHED_TO_PIECES                                  // /
    | TO_BE_DIMINISHED_BY                                // <
    | TO_EXCEED                                          // >
    | AS_IS                                              // ==
    | OTHER_THAN                                         // !=
    | WITH_AND_WITH                                      // AND
    | WITH_OR_WITHOUT                                    // OR
    | WITHOUT                                            // NOT
    | PUT_TOGETHER_TO_PRESENT_A_SEMBLANCE_OF_A_WHOLE     // String concat
    | AND_OR                                             // Ambiguous conjunction (XOR or inclusive OR)
    | AMPERSAND                                          // Ampersand conjunction
    | TWIXT                                              // Between (can be operator too)
    | PLUSMINUS                                          // Plus-minus (uncertainty/approximation)
    ;
