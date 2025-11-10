// Fix remaining unframed identifiers that might be in special contexts
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// List of specific patterns to fix manually
const fixes = {
  // Pattern: [search, replace]
  'X PLACED AS': '|X| PLACED AS',
  'A PLACED AS': '|A| PLACED AS',
  'ANOTHER PLACED AS': '|ANOTHER| PLACED AS',
  'PUT TOGETHER ANOTHER.': 'PUT TOGETHER |ANOTHER|.',
  'PUT TOGETHER ANOTHER\n': 'PUT TOGETHER |ANOTHER|\n',
};

const artifactsDir = path.join(__dirname, '..', 'tests', 'artifacts');
const files = fs.readdirSync(artifactsDir)
  .filter(f => f.endsWith('.lw'))
  .sort();

console.log(`Fixing remaining identifiers in ${files.length} files...\n`);

let fixedCount = 0;

for (const file of files) {
  const filePath = path.join(artifactsDir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  let changed = false;

  for (const [search, replace] of Object.entries(fixes)) {
    if (content.includes(search)) {
      content = content.replaceAll(search, replace);
      changed = true;
    }
  }

  if (changed) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`✓ Fixed ${file}`);
    fixedCount++;
  }
}

console.log(`\nFixed ${fixedCount} files`);
