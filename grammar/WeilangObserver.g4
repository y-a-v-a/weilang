parser grammar WeilangObserver;

// ============================================================================
// WEILANG OBSERVER: Observer-dependent actions and inscriptions
// ============================================================================

// The viewer/observer participates
observerAction
    : PRESENTED_AS expression TO_THE_RECEIVER     // Output
    | HOLD_IN_MIND IDENTIFIER                      // Mark for inspection
    | NOTED_BUT_NOT_SHOWN expression               // Silent computation
    | TO_SEE_AND_BE_SEEN expression                // Mutual observation
    | expression PLACED_ON_VIEW                    // Make visible
    | expression REMOVED_FROM_VIEW                 // Make hidden
    | expression OUT_OF_SIGHT                      // Concealed
    | LO_AND_BEHOLD expression                     // Revelation/display
    | AS_FAR_AS_THE_EYE_CAN_SEE expression         // Observable scope
    ;

// Comments as poetic inscriptions (not ignored!)
inscription
    : IN_RELATION_TO STRING                         // Comment
    | DESCRIBED_AS STRING                           // Metadata
    ;
