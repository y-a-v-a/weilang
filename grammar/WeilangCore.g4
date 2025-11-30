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
    | statement OR_NOT statement                    // Schrödinger's code
    | statement RATHER_THAN statement               // Alternative realities
    | EITHER statement+ END_EITHER                  // One chosen at runtime
    ;

statement
    : temporalMarker? intentionalityModifier? coreStatement punctuation?
    ;

// Punctuation affects execution semantics
punctuation
    : DOT      // Neutral/declarative
    | EXCLAIM  // Imperative/must execute
    | QUESTION // Uncertain/maybe
    ;
