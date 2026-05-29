#!/usr/bin/env python3
from pathlib import Path
import json, sys, yaml
from jsonschema import Draft202012Validator
ROOT = Path(__file__).resolve().parents[1]
SCHEMA = json.loads((ROOT / 'schemas' / 'template.schema.json').read_text())
validator = Draft202012Validator(SCHEMA)
errors = []
for metadata_path in sorted((ROOT / 'templates').glob('**/template.yaml')):
    data = yaml.safe_load(metadata_path.read_text()) or {}
    for error in validator.iter_errors(data):
        errors.append(f'{metadata_path}: {error.message}')
    template_dir = metadata_path.parent
    for required in ['README.md','src','tests/smoke.md','validation/checklist.md','validation/evidence.json']:
        if not (template_dir / required).exists():
            errors.append(f'{template_dir}: missing {required}')
if errors:
    print('
'.join(errors))
    sys.exit(1)
print('Repository validation passed')
