parser grammar WeilangMaterial;

// ============================================================================
// WEILANG MATERIAL: Material qualities and removal operations
// ============================================================================

// Variables have physical properties
materialQuality
    : OF_STONE          // Immutable
    | OF_WATER          // Volatile/ephemeral
    | OF_STEEL          // Strong-typed/rigid
    | OF_GLASS          // Transparent/debuggable
    | OF_ASH            // Write-once
    | OF_PAPER          // Mutable/fragile
    | OF_SALT           // Preservative/essential
    | OF_LIMESTONE      // Sedimentary/accumulated
    | OF_SANDSTONE      // Grainy/textured
    | OF_WOOD           // Natural/organic
    | OF_IRON           // Strong but oxidizable
    | OF_GOLD           // Precious/valuable
    | POLISHED          // Optimized
    | WEATHERED         // Decays over time
    | SCATTERED         // Distributed/parallel
    | COMPRESSED        // Memory-optimized
    ;

// Weiner worked with removal and absence
removal
    : REMOVE IDENTIFIER FROM_THAT_WHICH_IS
    | UN_PLACED_AS expression
    | ABSENCE_OF IDENTIFIER NOTED
    | THE_REMOVAL_TO_THE_LATHING_OF IDENTIFIER
    ;
