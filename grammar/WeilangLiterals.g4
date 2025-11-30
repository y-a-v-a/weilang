parser grammar WeilangLiterals;

// ============================================================================
// WEILANG LITERALS: Literal values, measurements, and data structures
// ============================================================================

literal
    : NUMBER measurementUnit?
    | STRING
    | TRUE_AS_IS
    | FALSE_AS_IS
    | NOTHING_AS_SUCH                                    // Null
    | arrayLiteral
    ;

// Physical measurements (Weiner often specified dimensions)
measurementUnit
    : INCHES
    | FEET
    | SQUARE_FEET
    | POUNDS
    | DEGREES
    | MOMENTS           // Time unit
    | PIECES            // Count unit
    ;

arrayLiteral
    : BITS_AND_PIECES LBRACK (expression (COMMA expression)*)? RBRACK
    ;
