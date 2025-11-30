parser grammar WeilangCore;

// ============================================================================
// WEILANG CORE: Top-level program structure and non-determinism
// ============================================================================

// Parser rules
program
    : possibility* EOF
    ;

// Non-deterministic possibilities - the core unit of Weiner-code
possibility
    : statement
    | statement 'OR NOT' statement                    // Schrödinger's code
    | statement 'RATHER THAN' statement               // Alternative realities
    | 'EITHER' statement+ 'END EITHER'                // One chosen at runtime
    ;

statement
    : temporalMarker? intentionalityModifier? coreStatement punctuation?
    ;

// Punctuation affects execution semantics
punctuation
    : '.'      // Neutral/declarative
    | '!'      // Imperative/must execute
    | '?'      // Uncertain/maybe
    ;
