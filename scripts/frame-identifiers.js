// Script to update all .lw test artifacts to use framed identifiers |NAME|
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// All Weilang keywords (must not be framed)
const KEYWORDS = new Set([
  // Core keywords
  'PLACED', 'AS', 'OR', 'NOT', 'RATHER', 'THAN', 'EITHER', 'END',
  'IF', 'OTHERWISE', 'IS', 'THEN',

  // Temporal markers
  'IN', 'THE', 'STILL', 'OF', 'NIGHT', 'IT', 'WAS', 'WILL', 'BE',
  'ONCE', 'AGAIN', 'YET', 'BUT', 'SOON', 'ALWAYS', 'ALREADY',
  'WHEN', 'PRESSURE', 'APPLIED', 'FOREVER', 'DAY', 'LONG', 'LASTS',
  'DUE', 'COURSE', 'AT', 'SAME', 'MOMENT', 'EVENTS', 'AFTER', 'HERE', 'THERE',

  // Intentionality modifiers
  'MAY', 'CONSTRUCTED', 'NEED', 'BUILT', 'AND', 'RECEIVED',
  'TO', 'WITNESSED', 'PER', 'SE', 'WITH', 'INTENT', 'MALICE',
  'AFORETHOUGHT', 'ALL', 'INNOCENCE', 'THAT', 'MUCH', 'ADO',

  // Material qualities
  'MATTER', 'STONE', 'WATER', 'STEEL', 'GLASS', 'ASH',
  'WOOD', 'COPPER', 'IRON', 'BRONZE', 'CLAY', 'SAND', 'EARTH',
  'LIGHT', 'AIR', 'FIRE', 'DEGREE', 'DEGREES', 'POUND', 'POUNDS',
  'INCH', 'INCHES', 'FOOT', 'FEET', 'METER', 'METERS',
  'KILOGRAM', 'KILOGRAMS', 'GRAM', 'GRAMS', 'OUNCE', 'OUNCES',

  // Removal operations
  'REMOVE', 'FROM', 'WHICH', 'UN-PLACED', 'ABSENCE', 'NOTED',
  'REMOVAL', 'LATHING',

  // Loops
  'OVER', 'UNTIL', 'PERPETUALLY', 'REPEATED', 'TIMES',
  'FOR', 'EACH', 'IN',

  // Functions
  'SHOW', 'TELL', 'CALLED', 'RETURN',

  // Observer actions
  'UPON', 'WALL', 'FLOOR', 'CEILING', 'GROUND', 'SPOKEN', 'ALOUD',
  'WHISPERED', 'INSCRIBED', 'DESCRIBED', 'PRESENTED', 'RECEIVER',
  'HOLD', 'MIND', 'SEE', 'SEEN', 'LO', 'BEHOLD', 'FAR', 'EYE',
  'CAN', 'RELATION', 'DOCUMENTED',

  // Operators
  'SCATTERED', 'ACROSS', 'GATHERED', 'INTO', 'PUT', 'TOGETHER',
  'TAKEN', 'APART', 'PULLED', 'AWAY', 'PRESSED', 'AGAINST',
  'WRAPPED', 'AROUND', 'BOUND', 'DIVIDED', 'AMONG', 'MULTIPLIED',
  'BY', 'DIMINISHED', 'REDUCED', 'INCREASED', 'EXPANDED',
  'COMPRESSED', 'WITHIN', 'REMOVED', 'THROWN', 'ASIDE',
  'SET', 'NEXT', 'SUSPENDED', 'ABOVE', 'PLACED', 'BELOW',
  'HELD', 'BETWEEN', 'PUSHED', 'BEYOND', 'CONFINED', 'DRAWN',
  'THROUGH', 'JOINED', 'TORN', 'TWO', 'BROKEN', 'PIECES',
  'FOLDED', 'HALF', 'STACKED', 'TOP', 'ANOTHER',
  'SCATTERED', 'FOUR', 'DIRECTIONS', 'CONCENTRATED', 'ONE', 'POINT',
  'STRETCHED', 'LIMITS', 'CONTRACTED', 'CENTER', 'ROTATED', 'AXIS',
  'REFLECTED', 'INVERTED', 'WITHOUT', 'REPLACED', 'OTHER',

  // Conditionals
  'PRESENT', 'ABSENT', 'EXCEEDS', 'MEASURE', 'NOTHING',
  'MATCHES', 'FORM', 'DIFFERS', 'EQUAL', 'GREATER', 'LESSER',
  'CONTAINS', 'LACKS',

  // Quantifiers
  'A', 'ENOUGH', 'TOO', 'BIT', 'LITTLE', 'MORE', 'LESS',
  'GIVE', 'OR', 'TAKE', 'SUFFICIENT', 'MANY', 'SOME',

  // Literals
  'TRUE', 'FALSE', 'SUCH', 'BITS', 'PIECES',

  // Punctuation-related
  'X', // Used in measurements like "36 x 36"
]);

// Function to check if a word is a keyword
function isKeyword(word) {
  return KEYWORDS.has(word.toUpperCase());
}

// Function to frame identifiers in a line
function frameIdentifiers(line) {
  // Don't process lines that are comments or empty
  if (line.trim().startsWith('//') || line.trim() === '') {
    return line;
  }

  // Match uppercase words (potential identifiers)
  // But preserve strings in quotes
  let result = '';
  let inString = false;
  let currentWord = '';
  let i = 0;

  while (i < line.length) {
    const char = line[i];

    // Handle strings
    if (char === '"') {
      if (currentWord) {
        result += processWord(currentWord);
        currentWord = '';
      }
      inString = !inString;
      result += char;
      i++;
      continue;
    }

    if (inString) {
      result += char;
      i++;
      continue;
    }

    // Handle pipe-framed identifiers (already framed)
    if (char === '|') {
      if (currentWord) {
        result += processWord(currentWord);
        currentWord = '';
      }
      // Copy the entire framed identifier as-is
      let framedId = '|';
      i++;
      while (i < line.length && line[i] !== '|') {
        framedId += line[i];
        i++;
      }
      if (i < line.length) {
        framedId += '|';  // Closing pipe
        i++;
      }
      result += framedId;
      continue;
    }

    // Build words from uppercase letters, digits, and underscores
    if (/[A-Z0-9_]/.test(char)) {
      currentWord += char;
      i++;
    } else {
      if (currentWord) {
        result += processWord(currentWord);
        currentWord = '';
      }
      result += char;
      i++;
    }
  }

  // Process any remaining word
  if (currentWord) {
    result += processWord(currentWord);
  }

  return result;
}

// Process a word - frame it if it's an identifier, leave it if it's a keyword
function processWord(word) {
  // Skip numbers
  if (/^\d+$/.test(word)) {
    return word;
  }

  // Skip if it's a keyword
  if (isKeyword(word)) {
    return word;
  }

  // It's an identifier - frame it
  return `|${word}|`;
}

// Main processing
const artifactsDir = path.join(__dirname, '..', 'tests', 'artifacts');
const files = fs.readdirSync(artifactsDir)
  .filter(f => f.endsWith('.lw'))
  .sort();

console.log(`Processing ${files.length} test artifacts...\n`);

let processedCount = 0;
let errorCount = 0;

for (const file of files) {
  const filePath = path.join(artifactsDir, file);

  try {
    const content = fs.readFileSync(filePath, 'utf8');
    const lines = content.split('\n');
    const updatedLines = lines.map(line => frameIdentifiers(line));
    const updatedContent = updatedLines.join('\n');

    // Only write if content changed
    if (updatedContent !== content) {
      fs.writeFileSync(filePath, updatedContent, 'utf8');
      console.log(`✓ ${file}`);
      processedCount++;
    } else {
      console.log(`- ${file} (no changes)`);
    }
  } catch (error) {
    console.error(`✗ ${file}: ${error.message}`);
    errorCount++;
  }
}

console.log(`\n${'='.repeat(60)}`);
console.log(`Processed: ${processedCount} files`);
console.log(`Errors: ${errorCount} files`);
console.log(`${'='.repeat(60)}`);

if (errorCount > 0) {
  process.exit(1);
}
