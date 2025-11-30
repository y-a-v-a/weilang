lexer grammar WeilangLexer;

// ============================================================================
// WEILANG LEXER: Tokenization rules for Lawrence Weiner-inspired language
// "The work need not be built. Each being equal and consistent with the intent."
// ============================================================================

// Framed identifiers - inspired by Lawrence Weiner's use of rectangular frames around words
// Identifiers must be enclosed in pipes: |NAME|
// Can contain any text except pipes and newlines (allows spaces, keywords, single letters, etc.)
IDENTIFIER
    : '|' IDENTIFIER_CONTENT '|'
    ;

fragment IDENTIFIER_CONTENT
    : ( ~[|\r\n] )+
    ;

NUMBER
    : [0-9]+ ('.' [0-9]+)?    // Support decimals
    ;

STRING
    : '"' (~["\r\n])* '"'
    ;

WS
    : [ \t\r\n]+ -> skip
    ;
