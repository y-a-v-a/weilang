All files of Weilang have the extension `.lw`
This is counter-intuitive to Weilang as one would think `w` and `l` from Weilang,
but in fact the artist is called Lawerence Weiner, hence using his initials will lead to `lw`.


# Main todo list for artifacts

## Basic Lexer Tests
- [x] Test IDENTIFIER tokens (uppercase with numbers and underscores)
- [x] Test NUMBER tokens (integers and decimals)
- [x] Test STRING tokens (double-quoted strings)
- [x] Test whitespace handling

## Punctuation Tests
- [x] Test neutral/declarative punctuation (.)
- [x] Test imperative punctuation (!)
- [x] Test uncertain punctuation (?)
- [x] Test statement without punctuation

## Temporal Marker Tests
- [x] Test 'IN THE STILL OF THE NIGHT' (past continuous)
- [x] Test 'AS IT WAS' (simple past)
- [x] Test 'AS IT WILL BE' (future)
- [x] Test 'ONCE & AGAIN' (iterative past)
- [x] Test 'NOT YET BUT SOON' (near future)
- [x] Test 'ALWAYS ALREADY' (eternal present)
- [x] Test 'WHEN PRESSURE APPLIED' (conditional temporal)
- [x] Test 'FOREVER & A DAY' (infinite duration)
- [x] Test 'AS LONG AS IT LASTS' (duration-dependent)
- [x] Test 'IN DUE COURSE' (eventually)
- [x] Test 'AT THE SAME MOMENT' (simultaneous)
- [x] Test 'IN THE COURSE OF EVENTS' (natural progression)
- [x] Test 'AFTER HERE & THERE' (post-spatial)

## Intentionality Modifier Tests
- [x] Test 'MAY BE CONSTRUCTED AS' (optional execution)
- [x] Test 'NEED NOT BE BUILT AS' (interpreter decides)
- [x] Test 'IF AND WHEN RECEIVED AS' (runtime-dependent)
- [x] Test 'AS IF TO BE' (speculative/hypothetical)
- [x] Test 'TO BE WITNESSED AS' (must be observed)
- [x] Test 'PER SE' (intrinsically)
- [x] Test 'WITH INTENT' (deliberate)
- [x] Test 'WITH MALICE AFORETHOUGHT' (pre-planned)
- [x] Test 'IN ALL INNOCENCE' (unintentional)
- [x] Test 'BE THAT AS IT MAY' (regardless)
- [x] Test 'WITH MUCH ADO' (ceremoniously)

## Assignment Tests
- [x] Test basic assignment without material qualities
- [x] Test assignment with single material quality
- [x] Test assignment with multiple material qualities
- [x] Test 'OF STONE' (immutable)
- [x] Test 'OF WATER' (volatile)
- [x] Test 'OF STEEL' (strong-typed)
- [x] Test 'OF GLASS' (transparent/debuggable)
- [x] Test 'OF ASH' (write-once)
- [x] Test 'OF PAPER' (mutable)
- [x] Test 'OF SALT' (preservative)
- [x] Test 'OF LIMESTONE' (accumulated)
- [x] Test 'OF SANDSTONE' (grainy)
- [x] Test 'OF WOOD' (natural)
- [x] Test 'OF IRON' (oxidizable)
- [x] Test 'OF GOLD' (precious)
- [x] Test 'POLISHED' (optimized)
- [x] Test 'WEATHERED' (decays over time)
- [x] Test 'SCATTERED' (distributed/parallel)
- [x] Test 'COMPRESSED' (memory-optimized)

## Removal Tests
- [x] Test 'REMOVE <ID> FROM THAT WHICH IS'
- [x] Test 'UN-PLACED AS' with expression
- [x] Test 'ABSENCE OF <ID> NOTED'
- [x] Test 'THE REMOVAL TO THE LATHING OF <ID>'

## Conditional Tests
- [x] Test basic 'IF AS IF' with 'END AS IS'
- [x] Test 'IF AS IF' with 'OTHERWISE AS IS' clause
- [x] Test nested conditionals
- [x] Test condition: expression only
- [x] Test condition: 'EXCEEDS ALL MEASURE'
- [x] Test condition: 'DIMINISHED TO NOTHING'
- [x] Test condition: 'REMAINS AS SUCH'
- [x] Test condition: 'TRANSFORMED BY PASSAGE'
- [x] Test condition: 'IN DIRECT LINE WITH'
- [x] Test condition: 'ADJACENT TO'
- [x] Test condition: 'WHEN PRESSURE APPLIED TO'
- [x] Test condition: 'BESIDE ITSELF'
- [x] Test condition: 'IN TANDEM WITH'
- [x] Test condition: 'IN PLAIN SIGHT'
- [x] Test condition: 'WITHIN A REALM OF DISTANCE'

## Loop Tests
- [x] Test 'OVER AND OVER' with condition
- [x] Test 'UNTIL OTHERWISE' with condition
- [x] Test 'ONCE & AGAIN' (for-loop style)

## Function Tests
- [x] Test function declaration without parameters
- [x] Test function declaration with single parameter
- [x] Test function declaration with multiple parameters
- [x] Test function call without arguments
- [x] Test function call with single argument
- [x] Test function call with multiple arguments
- [x] Test return statement

## Observer Action Tests
- [x] Test 'PRESENTED AS <expr> TO THE RECEIVER' (output)
- [x] Test 'HOLD IN MIND' (mark for inspection)
- [x] Test 'NOTED BUT NOT SHOWN' (silent computation)
- [x] Test 'TO SEE & BE SEEN' (mutual observation)
- [x] Test '<expr> PLACED ON VIEW' (make visible)
- [x] Test '<expr> REMOVED FROM VIEW' (make hidden)
- [x] Test '<expr> OUT OF SIGHT' (concealed)
- [x] Test 'LO & BEHOLD' (revelation)
- [x] Test 'AS FAR AS THE EYE CAN SEE' (observable scope)

## Inscription Tests
- [x] Test 'IN RELATION TO' (comment)
- [x] Test 'DESCRIBED AS' (metadata)

## Literal Tests
- [x] Test integer literal
- [x] Test decimal literal
- [x] Test string literal
- [x] Test 'TRUE AS IS'
- [x] Test 'FALSE AS IS'
- [x] Test 'NOTHING AS SUCH' (null)
- [x] Test empty array literal
- [x] Test array literal with single element
- [x] Test array literal with multiple elements

## Measurement Unit Tests
- [x] Test 'INCHES'
- [x] Test 'FEET'
- [x] Test 'SQUARE FEET'
- [x] Test 'POUNDS'
- [x] Test 'DEGREES'
- [x] Test 'MOMENTS'
- [x] Test 'PIECES'

## Quantifier Tests
- [x] Test 'ENOUGH'
- [x] Test 'NOT ENOUGH'
- [x] Test 'TOO MUCH'
- [x] Test 'A BIT OF'
- [x] Test 'A LITTLE BIT MORE'
- [x] Test 'MORE OR LESS'
- [x] Test 'GIVE OR TAKE'
- [x] Test 'SUFFICIENT'
- [x] Test 'MANY'
- [x] Test 'SOME'

## Operator Tests
- [x] Test 'PUT TOGETHER' (+)
- [x] Test 'REMOVED FROM' (-)
- [x] Test 'OVER AND OVER' (*)
- [x] Test 'SMASHED TO PIECES' (/)
- [x] Test 'TO BE DIMINISHED BY' (<)
- [x] Test 'TO EXCEED' (>)
- [x] Test 'AS IS' (==)
- [x] Test 'OTHER THAN' (!=)
- [x] Test 'WITH & WITH' (AND)
- [x] Test 'WITH OR WITHOUT' (OR)
- [x] Test 'WITHOUT' (NOT)
- [x] Test 'PUT TOGETHER TO PRESENT A SEMBLANCE OF A WHOLE' (string concat)
- [x] Test 'AND/OR' (XOR or inclusive OR)
- [x] Test '&' (ampersand conjunction)
- [x] Test 'TWIXT' (between)
- [x] Test '±' (plus-minus)

## Expression Tests - Basic
- [x] Test identifier expression
- [x] Test parenthesized expression
- [x] Test 'THE LACK OF' (prefix negation)
- [x] Test 'WHAT REMAINS AFTER' (ternary operation)
- [x] Test 'A <N> x <N> REMOVAL FROM' (dimensional operation)

## Expression Tests - Spatial/Material Operations
- [x] Test 'PLACED UPON' (layering)
- [x] Test 'IN DIRECT LINE WITH' (alignment)
- [x] Test 'ADJACENT TO' (proximity)
- [x] Test 'REMOVED TO THE LATHING OF' (depth/extraction)
- [x] Test 'ON TOP OF' (above/over)
- [x] Test 'BENEATH' (below/under)
- [x] Test 'ABOVE' (higher than)
- [x] Test 'AROUND' (surrounding)
- [x] Test 'RIGHT IN THE MIDDLE OF' (centered within)
- [x] Test 'AT THE LEVEL OF' (same height/plane)
- [x] Test 'WITHIN A REALM OF' (contained conceptually)
- [x] Test 'TWIXT' in expression context (between)

## Expression Tests - Gestural/Prepositional Operations
- [x] Test 'THROWN FROM <expr> TO <expr>' (range operation)
- [x] Test 'SCATTERED ACROSS' (map/distribute)
- [x] Test 'GATHERED INTO' (reduce/collect)
- [x] Test 'PRESSED AGAINST' (concatenate)
- [x] Test 'BROKEN AWAY FROM' (subtract/split)
- [x] Test 'CRUSHED BETWEEN' (constrain/clamp)
- [x] Test 'TOSSED FROM ONE TO ANOTHER' (transfer/move)
- [x] Test 'STREWN ACROSS' (distributed randomly)
- [x] Test 'DISPERSED ACROSS' (spread out)
- [x] Test 'SUSPENDED FROM' (hanging/deferred)
- [x] Test 'BOLTED TO' (fixed attachment)
- [x] Test 'WELDED TO' (fused permanently)
- [x] Test 'FOLDED INTO' (nested/incorporated)
- [x] Test 'WRAPPED AROUND' (enclosed/surrounded)
- [x] Test 'KEPT APART FROM' (separated/isolated)
- [x] Test 'LEFT AS IS' (unchanged/identity)
- [x] Test 'SPLIT FROM' (divided/separated)
- [x] Test 'RENT FROM' (torn from)
- [x] Test 'SEVERED FROM' (cut from)
- [x] Test 'STACKED UPON' (piled on)
- [x] Test 'LAID UPON' (placed flat on)
- [x] Test 'KNEADED WITH' (mixed/combined)
- [x] Test 'FLOATED UPON' (resting on surface)

## Possibility Tests
- [x] Test single statement possibility
- [x] Test 'OR NOT' (Schrödinger's code)
- [x] Test 'RATHER THAN' (alternative realities)
- [x] Test 'EITHER ... END EITHER' with single statement
- [x] Test 'EITHER ... END EITHER' with multiple statements

## Complex Integration Tests
- [x] Test statement with temporal marker + intentionality modifier + punctuation
- [x] Test nested loops
- [x] Test function with return statement
- [x] Test complex expression precedence
- [x] Test array operations with gestural expressions
- [x] Test conditional inside loop
- [x] Test loop inside function
- [x] Test multiple possibilities in a program
- [x] Test all example programs from grammar documentation
