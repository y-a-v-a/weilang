parser grammar WeilangStatements;

// ============================================================================
// WEILANG STATEMENTS: Core statements and control flow
// ============================================================================

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
    : IDENTIFIER materialQuality* PLACED_AS expression
    ;

conditional
    : IF_AS_IF condition statement+ (OTHERWISE_AS_IS statement+)? END_AS_IS
    ;

// Phenomenological conditions
condition
    : expression                                      // Standard expression
    | expression EXCEEDS_ALL_MEASURE                  // > threshold
    | expression DIMINISHED_TO_NOTHING                // == 0
    | expression REMAINS_AS_SUCH                      // Truthy
    | expression TRANSFORMED_BY_PASSAGE               // Changed since last check
    | expression IN_DIRECT_LINE_WITH expression       // Aligned/equal
    | expression ADJACENT_TO expression               // Close enough (fuzzy)
    | WHEN_PRESSURE_APPLIED_TO expression             // Force evaluation
    | expression BESIDE_ITSELF                        // Self-contradictory/unstable
    | expression IN_TANDEM_WITH expression            // Synchronized/paired
    | expression IN_PLAIN_SIGHT                       // Visible/obvious
    | expression WITHIN_A_REALM_OF_DISTANCE           // Spatially remote
    ;

loop
    : OVER_AND_OVER condition statement+ END_OVER
    | UNTIL_OTHERWISE condition statement+ END_OVER
    | ONCE_AND_AGAIN expression statement+ END_OVER  // For-loop style
    ;

functionDecl
    : TO_SHOW_AND_TO_TELL IDENTIFIER (CALLED_FOR paramList)?
      statement+ END_SHOW
    ;

paramList
    : IDENTIFIER (COMMA IDENTIFIER)*
    ;

functionCall
    : IDENTIFIER CALLED_FOR (expression (COMMA expression)*)?
    ;

returnStmt
    : RETURN_PLACED_AS expression
    ;
