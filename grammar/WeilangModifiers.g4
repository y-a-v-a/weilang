parser grammar WeilangModifiers;

// ============================================================================
// WEILANG MODIFIERS: Temporal and intentionality aspects
// ============================================================================

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
