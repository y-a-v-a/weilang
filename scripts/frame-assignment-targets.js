// Frame identifiers that appear before "PLACED AS" (assignment targets)
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const artifactsDir = path.join(__dirname, '..', 'tests', 'artifacts');
const files = fs.readdirSync(artifactsDir)
  .filter(f => f.endsWith('.lw'))
  .sort();

console.log(`Framing assignment targets in ${files.length} files...\n`);

let fixedCount = 0;

for (const file of files) {
  const filePath = path.join(artifactsDir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  let originalContent = content;

  // Pattern: WORD PLACED AS (where WORD is not already framed and not a keyword that should never be framed)
  // Match uppercase words followed by PLACED AS that aren't already framed
  content = content.replace(/\n([A-Z][A-Z0-9_]*) PLACED AS/g, (match, word) => {
    // Don't frame if already part of a framed identifier or certain special keywords
    return `\n|${word}| PLACED AS`;
  });

  // Also handle start of file
  content = content.replace(/^([A-Z][A-Z0-9_]*) PLACED AS/g, (match, word) => {
    return `|${word}| PLACED AS`;
  });

  if (content !== originalContent) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`✓ Fixed ${file}`);
    fixedCount++;
  }
}

console.log(`\nFixed ${fixedCount} files`);
