#!/usr/bin/env python3
from pathlib import Path
import csv, json, yaml
ROOT = Path(__file__).resolve().parents[1]
CATALOG = ROOT / 'catalog'
CATALOG.mkdir(exist_ok=True)
items = []
for metadata_path in sorted((ROOT / 'templates').glob('**/template.yaml')):
    data = yaml.safe_load(metadata_path.read_text()) or {}
    data['path'] = str(metadata_path.parent.relative_to(ROOT))
    items.append(data)
(CATALOG / 'templates.json').write_text(json.dumps(items, indent=2, ensure_ascii=False) + '
')
with (CATALOG / 'templates.csv').open('w', newline='') as f:
    fieldnames = ['template_id','name','platform','template_type','version','status','path']
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    for item in items:
        writer.writerow({key: item.get(key, '') for key in fieldnames})
(CATALOG / 'stats.json').write_text(json.dumps({'total_templates': len(items)}, indent=2) + '
')
print(f'Catalog generated with {len(items)} templates')
