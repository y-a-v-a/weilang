parser grammar WeilangLiterals;

// ============================================================================
// WEILANG LITERALS: Literal values, measurements, and data structures
// ============================================================================

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
