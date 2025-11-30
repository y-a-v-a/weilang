parser grammar WeilangParser;

options {
    tokenVocab=WeilangLexer;
}

// ============================================================================
// WEILANG PARSER: Main orchestrator - imports all grammar modules
// "The work need not be built. Each being equal and consistent with the intent."
// ============================================================================

import
    WeilangCore,
    WeilangModifiers,
    WeilangMaterial,
    WeilangLiterals,
    WeilangExpressions,
    WeilangObserver,
    WeilangStatements
    ;

// ============================================================================
// EXAMPLE PROGRAMS (as documentation)
// ============================================================================

/*

EXAMPLE 1: NON-DETERMINISTIC ASSIGNMENT
---------------------------------------
|MATTER| OF STONE PLACED AS 5 INCHES!

MAY BE CONSTRUCTED AS
    |LIGHT| OF WATER PLACED AS 10 DEGREES?

IN THE STILL OF THE NIGHT
    |MATTER| PLACED AS 3.


EXAMPLE 2: SPATIAL OPERATIONS
------------------------------
|WALL| PLACED AS 100.
|HOLE| PLACED AS A 36 x 36 REMOVAL FROM |WALL|.

|RESULT| PLACED AS |WALL| REMOVED FROM |HOLE|!


EXAMPLE 3: OBSERVER-DEPENDENT
------------------------------
|PARTICLE| OF WATER PLACED AS 50.

TO BE WITNESSED AS
    PRESENTED AS |PARTICLE| TO THE RECEIVER.

ALWAYS ALREADY
    |PARTICLE| PLACED AS |PARTICLE| PUT TOGETHER 1?


EXAMPLE 4: POSSIBILITY SPACES
------------------------------
|OUTCOME| PLACED AS 5
RATHER THAN
|OUTCOME| PLACED AS 10.

PRESENTED AS |OUTCOME| TO THE RECEIVER!


EXAMPLE 5: GESTURAL EXPRESSIONS
--------------------------------
|STONES| PLACED AS BITS & PIECES [1, 2, 3, 4, 5].

|SCATTERED| PLACED AS |STONES| SCATTERED ACROSS 10 PIECES.
|GATHERED| PLACED AS |SCATTERED| GATHERED INTO 1 PIECES.


EXAMPLE 6: PHENOMENOLOGICAL CONDITIONS
---------------------------------------
|MATTER| PLACED AS 100 POUNDS.

IF AS IF |MATTER| EXCEEDS ALL MEASURE
    PRESENTED AS "TOO MUCH" TO THE RECEIVER!
OTHERWISE AS IS
    IF AS IF |MATTER| DIMINISHED TO NOTHING
        ABSENCE OF |MATTER| NOTED.
    END AS IS
END AS IS


EXAMPLE 7: TEMPORAL AMBIGUITY
------------------------------
AS IT WILL BE
    |FUTURE VALUE| PLACED AS 999!

IN THE STILL OF THE NIGHT
    |PAST VALUE| PLACED AS 111.

ALWAYS ALREADY
    |ETERNAL VALUE| PLACED AS 42?


EXAMPLE 8: REMOVAL AND ABSENCE
-------------------------------
|PRESENCE| PLACED AS "HERE".

THE REMOVAL TO THE LATHING OF |PRESENCE|.

IF AS IF |PRESENCE| DIMINISHED TO NOTHING
    PRESENTED AS "ABSENCE ACHIEVED" TO THE RECEIVER!
END AS IS

*/
