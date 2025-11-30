parser grammar WeilangMaterial;

// ============================================================================
// WEILANG MATERIAL: Material qualities and removal operations
// ============================================================================

// Variables have physical properties
materialQuality
    : 'OF STONE'          // Immutable
    | 'OF WATER'          // Volatile/ephemeral
    | 'OF STEEL'          // Strong-typed/rigid
    | 'OF GLASS'          // Transparent/debuggable
    | 'OF ASH'            // Write-once
    | 'OF PAPER'          // Mutable/fragile
    | 'OF SALT'           // Preservative/essential
    | 'OF LIMESTONE'      // Sedimentary/accumulated
    | 'OF SANDSTONE'      // Grainy/textured
    | 'OF WOOD'           // Natural/organic
    | 'OF IRON'           // Strong but oxidizable
    | 'OF GOLD'           // Precious/valuable
    | 'POLISHED'          // Optimized
    | 'WEATHERED'         // Decays over time
    | 'SCATTERED'         // Distributed/parallel
    | 'COMPRESSED'        // Memory-optimized
    ;

// Weiner worked with removal and absence
removal
    : 'REMOVE' IDENTIFIER 'FROM THAT WHICH IS'
    | 'UN-PLACED AS' expression
    | 'ABSENCE OF' IDENTIFIER 'NOTED'
    | 'THE REMOVAL TO THE LATHING OF' IDENTIFIER
    ;
