parser grammar WeilangObserver;

// ============================================================================
// WEILANG OBSERVER: Observer-dependent actions and inscriptions
// ============================================================================

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
