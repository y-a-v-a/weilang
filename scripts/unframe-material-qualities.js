// Fix material qualities that were incorrectly framed
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Material quality patterns to fix
const materialQualities = [
  'STONE', 'WATER', 'STEEL', 'GLASS', 'ASH', 'PAPER', 'SALT',
  'LIMESTONE', 'SANDSTONE', 'WOOD', 'IRON', 'GOLD'
];

const artifactsDir = path.join(__dirname, '..', 'tests', 'artifacts');
const files = fs.readdirSync(artifactsDir)
  .filter(f => f.endsWith('.lw'))
  .sort();

console.log(`Fixing material qualities in ${files.length} files...\n`);

let fixedCount = 0;

for (const file of files) {
  const filePath = path.join(artifactsDir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  let changed = false;

  // Fix patterns like "OF |STONE|" to "OF STONE"
  for (const material of materialQualities) {
    const framedPattern = `OF |${material}|`;
    const unframedPattern = `OF ${material}`;

    if (content.includes(framedPattern)) {
      content = content.replaceAll(framedPattern, unframedPattern);
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
