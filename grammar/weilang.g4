grammar Weilang;

// Parser rules
program
    : statement* EOF
    ;

statement
    : assignment
    | conditional
    | loop
    | functionDecl
    | functionCall
    | returnStmt
    ;

assignment
    : IDENTIFIER 'PLACED AS' expression '.'
    ;

conditional
    : 'IF AS IF' expression statement+ ('OTHERWISE AS IS' statement+)? 'END AS IS'
    ;

loop
    : 'OVER AND OVER' expression statement+ 'END OVER'
    ;

functionDecl
    : 'TO SHOW AND TO TELL' IDENTIFIER ('CALLED FOR' IDENTIFIER (',' IDENTIFIER)*)?
      statement+ 'END SHOW'
    ;

functionCall
    : IDENTIFIER 'CALLED FOR' (expression (',' expression)*)? '.'
    ;

returnStmt
    : 'RETURN PLACED AS' expression '.'
    ;

expression
    : literal
    | IDENTIFIER
    | expression operator expression
    | '(' expression ')'
    ;

operator
    : 'PUT TOGETHER'
    | 'REMOVED FROM'
    | 'OVER AND OVER'
    | 'SMASHED TO PIECES'
    | 'TO BE DIMINISHED BY'
    | 'TO EXCEED'
    | 'AS IS'
    | 'OTHER THAN'
    | 'WITH & WITH'
    | 'WITH OR WITHOUT'
    | 'WITHOUT'
    | 'PUT TOGETHER TO PRESENT A SEMBLANCE OF A WHOLE'
    ;

literal
    : NUMBER
    | STRING
    | 'TRUE AS IS'
    | 'FALSE AS IS'
    | arrayLiteral
    ;

arrayLiteral
    : 'BITS & PIECES' '[' (expression (',' expression)*)? ']'
    ;

IDENTIFIER
    : [A-Z][A-Z0-9_]*
    ;

NUMBER
    : [0-9]+
    ;

STRING
    : '"' (~["\r\n])* '"'
    ;

WS
    : [ \t\r\n]+ -> skip
    ;
