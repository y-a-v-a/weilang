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
- [ ] Test neutral/declarative punctuation (.)
- [ ] Test imperative punctuation (!)
- [ ] Test uncertain punctuation (?)
- [ ] Test statement without punctuation

## Temporal Marker Tests
- [ ] Test 'IN THE STILL OF THE NIGHT' (past continuous)
- [ ] Test 'AS IT WAS' (simple past)
- [ ] Test 'AS IT WILL BE' (future)
- [ ] Test 'ONCE & AGAIN' (iterative past)
- [ ] Test 'NOT YET BUT SOON' (near future)
- [ ] Test 'ALWAYS ALREADY' (eternal present)
- [ ] Test 'WHEN PRESSURE APPLIED' (conditional temporal)
- [ ] Test 'FOREVER & A DAY' (infinite duration)
- [ ] Test 'AS LONG AS IT LASTS' (duration-dependent)
- [ ] Test 'IN DUE COURSE' (eventually)
- [ ] Test 'AT THE SAME MOMENT' (simultaneous)
- [ ] Test 'IN THE COURSE OF EVENTS' (natural progression)
- [ ] Test 'AFTER HERE & THERE' (post-spatial)

## Intentionality Modifier Tests
- [ ] Test 'MAY BE CONSTRUCTED AS' (optional execution)
- [ ] Test 'NEED NOT BE BUILT AS' (interpreter decides)
- [ ] Test 'IF AND WHEN RECEIVED AS' (runtime-dependent)
- [ ] Test 'AS IF TO BE' (speculative/hypothetical)
- [ ] Test 'TO BE WITNESSED AS' (must be observed)
- [ ] Test 'PER SE' (intrinsically)
- [ ] Test 'WITH INTENT' (deliberate)
- [ ] Test 'WITH MALICE AFORETHOUGHT' (pre-planned)
- [ ] Test 'IN ALL INNOCENCE' (unintentional)
- [ ] Test 'BE THAT AS IT MAY' (regardless)
- [ ] Test 'WITH MUCH ADO' (ceremoniously)

## Assignment Tests
- [ ] Test basic assignment without material qualities
- [ ] Test assignment with single material quality
- [ ] Test assignment with multiple material qualities
- [ ] Test 'OF STONE' (immutable)
- [ ] Test 'OF WATER' (volatile)
- [ ] Test 'OF STEEL' (strong-typed)
- [ ] Test 'OF GLASS' (transparent/debuggable)
- [ ] Test 'OF ASH' (write-once)
- [ ] Test 'OF PAPER' (mutable)
- [ ] Test 'OF SALT' (preservative)
- [ ] Test 'OF LIMESTONE' (accumulated)
- [ ] Test 'OF SANDSTONE' (grainy)
- [ ] Test 'OF WOOD' (natural)
- [ ] Test 'OF IRON' (oxidizable)
- [ ] Test 'OF GOLD' (precious)
- [ ] Test 'POLISHED' (optimized)
- [ ] Test 'WEATHERED' (decays over time)
- [ ] Test 'SCATTERED' (distributed/parallel)
- [ ] Test 'COMPRESSED' (memory-optimized)

## Removal Tests
- [ ] Test 'REMOVE <ID> FROM THAT WHICH IS'
- [ ] Test 'UN-PLACED AS' with expression
- [ ] Test 'ABSENCE OF <ID> NOTED'
- [ ] Test 'THE REMOVAL TO THE LATHING OF <ID>'

## Conditional Tests
- [ ] Test basic 'IF AS IF' with 'END AS IS'
- [ ] Test 'IF AS IF' with 'OTHERWISE AS IS' clause
- [ ] Test nested conditionals
- [ ] Test condition: expression only
- [ ] Test condition: 'EXCEEDS ALL MEASURE'
- [ ] Test condition: 'DIMINISHED TO NOTHING'
- [ ] Test condition: 'REMAINS AS SUCH'
- [ ] Test condition: 'TRANSFORMED BY PASSAGE'
- [ ] Test condition: 'IN DIRECT LINE WITH'
- [ ] Test condition: 'ADJACENT TO'
- [ ] Test condition: 'WHEN PRESSURE APPLIED TO'
- [ ] Test condition: 'BESIDE ITSELF'
- [ ] Test condition: 'IN TANDEM WITH'
- [ ] Test condition: 'IN PLAIN SIGHT'
- [ ] Test condition: 'WITHIN A REALM OF DISTANCE'

## Loop Tests
- [ ] Test 'OVER AND OVER' with condition
- [ ] Test 'UNTIL OTHERWISE' with condition
- [ ] Test 'ONCE & AGAIN' (for-loop style)

## Function Tests
- [ ] Test function declaration without parameters
- [ ] Test function declaration with single parameter
- [ ] Test function declaration with multiple parameters
- [ ] Test function call without arguments
- [ ] Test function call with single argument
- [ ] Test function call with multiple arguments
- [ ] Test return statement

## Observer Action Tests
- [ ] Test 'PRESENTED AS <expr> TO THE RECEIVER' (output)
- [ ] Test 'HOLD IN MIND' (mark for inspection)
- [ ] Test 'NOTED BUT NOT SHOWN' (silent computation)
- [ ] Test 'TO SEE & BE SEEN' (mutual observation)
- [ ] Test '<expr> PLACED ON VIEW' (make visible)
- [ ] Test '<expr> REMOVED FROM VIEW' (make hidden)
- [ ] Test '<expr> OUT OF SIGHT' (concealed)
- [ ] Test 'LO & BEHOLD' (revelation)
- [ ] Test 'AS FAR AS THE EYE CAN SEE' (observable scope)

## Inscription Tests
- [ ] Test 'IN RELATION TO' (comment)
- [ ] Test 'DESCRIBED AS' (metadata)

## Literal Tests
- [ ] Test integer literal
- [ ] Test decimal literal
- [ ] Test string literal
- [ ] Test 'TRUE AS IS'
- [ ] Test 'FALSE AS IS'
- [ ] Test 'NOTHING AS SUCH' (null)
- [ ] Test empty array literal
- [ ] Test array literal with single element
- [ ] Test array literal with multiple elements

## Measurement Unit Tests
- [ ] Test 'INCHES'
- [ ] Test 'FEET'
- [ ] Test 'SQUARE FEET'
- [ ] Test 'POUNDS'
- [ ] Test 'DEGREES'
- [ ] Test 'MOMENTS'
- [ ] Test 'PIECES'

## Quantifier Tests
- [ ] Test 'ENOUGH'
- [ ] Test 'NOT ENOUGH'
- [ ] Test 'TOO MUCH'
- [ ] Test 'A BIT OF'
- [ ] Test 'A LITTLE BIT MORE'
- [ ] Test 'MORE OR LESS'
- [ ] Test 'GIVE OR TAKE'
- [ ] Test 'SUFFICIENT'
- [ ] Test 'MANY'
- [ ] Test 'SOME'

## Operator Tests
- [ ] Test 'PUT TOGETHER' (+)
- [ ] Test 'REMOVED FROM' (-)
- [ ] Test 'OVER AND OVER' (*)
- [ ] Test 'SMASHED TO PIECES' (/)
- [ ] Test 'TO BE DIMINISHED BY' (<)
- [ ] Test 'TO EXCEED' (>)
- [ ] Test 'AS IS' (==)
- [ ] Test 'OTHER THAN' (!=)
- [ ] Test 'WITH & WITH' (AND)
- [ ] Test 'WITH OR WITHOUT' (OR)
- [ ] Test 'WITHOUT' (NOT)
- [ ] Test 'PUT TOGETHER TO PRESENT A SEMBLANCE OF A WHOLE' (string concat)
- [ ] Test 'AND/OR' (XOR or inclusive OR)
- [ ] Test '&' (ampersand conjunction)
- [ ] Test 'TWIXT' (between)
- [ ] Test '±' (plus-minus)

## Expression Tests - Basic
- [ ] Test identifier expression
- [ ] Test parenthesized expression
- [ ] Test 'THE LACK OF' (prefix negation)
- [ ] Test 'WHAT REMAINS AFTER' (ternary operation)
- [ ] Test 'A <N> x <N> REMOVAL FROM' (dimensional operation)

## Expression Tests - Spatial/Material Operations
- [ ] Test 'PLACED UPON' (layering)
- [ ] Test 'IN DIRECT LINE WITH' (alignment)
- [ ] Test 'ADJACENT TO' (proximity)
- [ ] Test 'REMOVED TO THE LATHING OF' (depth/extraction)
- [ ] Test 'ON TOP OF' (above/over)
- [ ] Test 'BENEATH' (below/under)
- [ ] Test 'ABOVE' (higher than)
- [ ] Test 'AROUND' (surrounding)
- [ ] Test 'RIGHT IN THE MIDDLE OF' (centered within)
- [ ] Test 'AT THE LEVEL OF' (same height/plane)
- [ ] Test 'WITHIN A REALM OF' (contained conceptually)
- [ ] Test 'TWIXT' in expression context (between)

## Expression Tests - Gestural/Prepositional Operations
- [ ] Test 'THROWN FROM <expr> TO <expr>' (range operation)
- [ ] Test 'SCATTERED ACROSS' (map/distribute)
- [ ] Test 'GATHERED INTO' (reduce/collect)
- [ ] Test 'PRESSED AGAINST' (concatenate)
- [ ] Test 'BROKEN AWAY FROM' (subtract/split)
- [ ] Test 'CRUSHED BETWEEN' (constrain/clamp)
- [ ] Test 'TOSSED FROM ONE TO ANOTHER' (transfer/move)
- [ ] Test 'STREWN ACROSS' (distributed randomly)
- [ ] Test 'DISPERSED ACROSS' (spread out)
- [ ] Test 'SUSPENDED FROM' (hanging/deferred)
- [ ] Test 'BOLTED TO' (fixed attachment)
- [ ] Test 'WELDED TO' (fused permanently)
- [ ] Test 'FOLDED INTO' (nested/incorporated)
- [ ] Test 'WRAPPED AROUND' (enclosed/surrounded)
- [ ] Test 'KEPT APART FROM' (separated/isolated)
- [ ] Test 'LEFT AS IS' (unchanged/identity)
- [ ] Test 'SPLIT FROM' (divided/separated)
- [ ] Test 'RENT FROM' (torn from)
- [ ] Test 'SEVERED FROM' (cut from)
- [ ] Test 'STACKED UPON' (piled on)
- [ ] Test 'LAID UPON' (placed flat on)
- [ ] Test 'KNEADED WITH' (mixed/combined)
- [ ] Test 'FLOATED UPON' (resting on surface)

## Possibility Tests
- [ ] Test single statement possibility
- [ ] Test 'OR NOT' (Schrödinger's code)
- [ ] Test 'RATHER THAN' (alternative realities)
- [ ] Test 'EITHER ... END EITHER' with single statement
- [ ] Test 'EITHER ... END EITHER' with multiple statements

## Complex Integration Tests
- [ ] Test statement with temporal marker + intentionality modifier + punctuation
- [ ] Test nested loops
- [ ] Test function with return statement
- [ ] Test complex expression precedence
- [ ] Test array operations with gestural expressions
- [ ] Test conditional inside loop
- [ ] Test loop inside function
- [ ] Test multiple possibilities in a program
- [ ] Test all example programs from grammar documentation
