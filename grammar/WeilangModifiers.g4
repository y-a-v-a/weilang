parser grammar WeilangModifiers;

// ============================================================================
// WEILANG MODIFIERS: Temporal and intentionality aspects
// ============================================================================

// When/how the statement exists in time
temporalMarker
    : IN_THE_STILL_OF_THE_NIGHT    // Past continuous
    | AS_IT_WAS                     // Simple past
    | AS_IT_WILL_BE                 // Future
    | ONCE_AND_AGAIN                // Iterative past
    | NOT_YET_BUT_SOON              // Near future
    | ALWAYS_ALREADY                // Eternal present
    | WHEN_PRESSURE_APPLIED         // Conditional temporal
    | FOREVER_AND_A_DAY             // Infinite duration
    | AS_LONG_AS_IT_LASTS           // Duration-dependent
    | IN_DUE_COURSE                 // Eventually/eventually
    | AT_THE_SAME_MOMENT            // Simultaneous
    | IN_THE_COURSE_OF_EVENTS       // During natural progression
    | AFTER_HERE_AND_THERE          // Post-spatial
    ;

// The receiver decides: modality of execution
intentionalityModifier
    : MAY_BE_CONSTRUCTED_AS         // Optional execution (prob < 1.0)
    | NEED_NOT_BE_BUILT_AS          // Interpreter decides
    | IF_AND_WHEN_RECEIVED_AS       // Runtime-dependent
    | AS_IF_TO_BE                   // Speculative/hypothetical
    | TO_BE_WITNESSED_AS            // Must be observed (side effect)
    | PER_SE                        // Intrinsically/essentially
    | WITH_INTENT                   // Deliberate/purposeful
    | WITH_MALICE_AFORETHOUGHT      // Pre-planned (legal term)
    | IN_ALL_INNOCENCE              // Unintentional/naive
    | BE_THAT_AS_IT_MAY             // Regardless/nevertheless
    | WITH_MUCH_ADO                 // Ceremoniously/emphatically
    ;
