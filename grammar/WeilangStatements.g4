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
    : IDENTIFIER materialQuality* 'PLACED AS' expression
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
