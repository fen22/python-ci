# Smoke Test — AI DevOps Bootstrap

## Test 1: Scripts existen y no tienen secretos

```bash
# Verificar que los scripts existen
ls src/bootstrap-macos.sh src/bootstrap-windows.ps1

# Verificar que no hay tokens/keys en los scripts
grep -E "(AKIA|sk-ant|ghp_|xoxb-|sk-[a-zA-Z0-9]{20,})" src/bootstrap-macos.sh src/bootstrap-windows.ps1 && echo "ERROR: Secreto encontrado" || echo "OK: Sin secretos"
```
Estado: ☐ Pendiente

---

## Test 2: Scripts son sintácticamente válidos

```bash
# macOS bash script
bash -n src/bootstrap-macos.sh && echo "Bash syntax OK"

# Windows PowerShell (requiere pwsh o PowerShell instalado)
pwsh -NoProfile -NonInteractive -File src/bootstrap-windows.ps1 -WhatIf 2>/dev/null || \
  pwsh -NoProfile -Command "
    \$null = [System.Management.Automation.Language.Parser]::ParseFile('$(pwd)/src/bootstrap-windows.ps1', [ref]\$null, [ref]\$null)
    Write-Output 'PowerShell syntax OK'
  "
```
Estado: ☐ Pendiente

---

## Test 3: Verificar permisos del script macOS

```bash
chmod +x src/bootstrap-macos.sh
ls -la src/bootstrap-macos.sh
```
Verificar que tiene permisos de ejecución (`-rwxr-xr-x`)
Estado: ☐ Pendiente

---

## Test 4: Dry-run en macOS (no instala nada)

```bash
# Responder "N" a todas las preguntas:
echo "N" | ./src/bootstrap-macos.sh || true
```
Verificar que termina limpiamente sin instalar nada.
Estado: ☐ Pendiente

---

## Test 5: Smoke test de versiones (ejecutar después de instalación real)

```bash
git --version
python3 --version
node --version
npm --version
docker --version
aws --version
claude --version
```
Todos deben devolver una versión válida.
Estado: ☐ Pendiente (requiere ejecutar bootstrap en máquina limpia)

| Test | Fecha | Por | Resultado |
|------|-------|-----|-----------|
| T1 | — | — | ☐ |
| T2 | — | — | ☐ |
| T3 | — | — | ☐ |
| T4 | — | — | ☐ |
| T5 | — | — | ☐ |
