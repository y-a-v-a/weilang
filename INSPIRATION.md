🎨 Weilang Runtime Error Gallery
Structural / Existence

PLACED UPON NOTHING → null reference error

REMOVAL FROM WHAT IS NOT THERE → accessing missing array element / key

IN DIRECT LINE WITH NOTHING & THE NEXT → dangling reference

Arithmetic

SMASHED TO PIECES BEYOND REPAIR → divide by zero

OVER AND OVER UNTIL NOTHING REMAINS → integer overflow

PUT TOGETHER UNTIL IT CANNOT BE PUT TOGETHER → string concatenation overflow

Type errors

BITS & PIECES WITH OTHER THAN BITS & PIECES → type mismatch (list with non-list)

TO BE DIMINISHED BY THAT WHICH CANNOT BE DIMINISHED → comparing incompatible types

Function / Control flow

TO SHOW AND TO TELL WITHOUT TELLING → function declared with no return but return used

CALLED FOR WITHOUT BEING PRESENT → function not found

OVER AND OVER WITHOUT END OTHERWISE → infinite loop detection

General execution

CRUSHED BETWEEN COBBLESTONES → generic fatal error

DAUBED WITH MUCK AND MIRE → unclean runtime state

TUCKED IN AT THE CORNERS → stack overflow

ROUGHLY RIPPED APART → concurrency/race condition (if we ever add concurrency!)

🧩 Example Runtime Messages
> RUN MAIN.WEILANG

SMASHED TO PIECES BEYOND REPAIR
(Line 7: LIGHT SMASHED TO PIECES 0)

> RUN ART.WEILANG

PLACED UPON NOTHING
(Line 3: RESULT PLACED AS VALUE PUT TOGETHER NULL)

> RUN LOOP.WEILANG

OVER AND OVER WITHOUT END OTHERWISE
(Hint: infinite loop detected at Line 5)

🔧 How to Implement (conceptually)

In the interpreter backend:

Replace exception names with Weiner phrase strings.

Attach them to the line/statement, but keep the poetic phrasing primary.

Optionally suppress stack traces: only the conceptual phrase + short context is shown.



🎨 Full-Weiner Syntax Map
Assignments

PLACED AS → assignment (=)

Conditionals

IF AS IF → if

OTHERWISE AS IS → else

END AS IS → end of block

Loops

OVER AND OVER → while / loop

UNTIL OTHERWISE → loop end condition

END OVER → end of loop

Functions

TO SHOW AND TO TELL → function declaration start

END SHOW → function end

CALLED FOR → function call

Operators (from our gallery)

PUT TOGETHER → +

REMOVED FROM → -

OVER AND OVER → * (also loop keyword → context-sensitive)

SMASHED TO PIECES → /

TO BE DIMINISHED BY → <

TO EXCEED → >

AS IS → ==

OTHER THAN → !=

WITH & WITH → AND

WITH OR WITHOUT → OR

WITHOUT → NOT

Data literals

BITS & PIECES → array/list

TRUE AS IS / FALSE AS IS → booleans

Strings in quotes still allowed ("TEXT")

🧩 Example Full-Weiner Program

```
MATTER PLACED AS 5.
LIGHT PLACED AS 10.

IF AS IF MATTER TO BE DIMINISHED BY LIGHT
    RESULT PLACED AS MATTER PUT TOGETHER LIGHT.
OTHERWISE AS IS
    RESULT PLACED AS LIGHT SMASHED TO PIECES MATTER.
END AS IS

OVER AND OVER MATTER TO BE DIMINISHED BY 20
    MATTER PLACED AS MATTER PUT TOGETHER 1.
END OVER

TO SHOW AND TO TELL DOUBLE CALLED FOR X
    Y PLACED AS X PUT TOGETHER X.
    RETURN PLACED AS Y.
END SHOW

VALUE PLACED AS DOUBLE CALLED FOR 7.
```

🎨 Weilang Operator Set (Esoteric-only)
Arithmetic

PUT TOGETHER → +

REMOVED FROM → -

OVER AND OVER → *

SMASHED TO PIECES → /

Comparison

TO BE DIMINISHED BY → <

TO EXCEED → >

AS IS → ==

OTHER THAN → !=

Boolean

WITH & WITH → logical AND

WITH OR WITHOUT → logical OR

WITHOUT → logical NOT

Structural

PUT TOGETHER TO PRESENT A SEMBLANCE OF A WHOLE → string/list concatenation

BITS & PIECES → array/list literal


```
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
```