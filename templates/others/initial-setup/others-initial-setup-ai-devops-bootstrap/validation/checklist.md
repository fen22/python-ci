# Checklist — AI DevOps Bootstrap

## Estructura
- [ ] template.yaml válido, status draft
- [ ] src/bootstrap-macos.sh existe y es ejecutable
- [ ] src/bootstrap-windows.ps1 existe
- [ ] README documenta todas las herramientas con tabla

## Seguridad
- [ ] No hay credenciales en bootstrap-macos.sh
- [ ] No hay credenciales en bootstrap-windows.ps1
- [ ] `credentials_embedded: false` en template.yaml
- [ ] Scripts piden confirmación antes de instalar

## Funcionalidad
- [ ] bash -n src/bootstrap-macos.sh no reporta errores de sintaxis
- [ ] PowerShell syntax check pasa
- [ ] Dry-run (responder N) termina limpiamente
- [ ] Smoke test (versiones) después de instalación exitosa
- [ ] Scripts instalan usando gestores oficiales (Homebrew, winget)

## UX
- [ ] Scripts imprimen mensajes claros con colores
- [ ] Incluyen instrucciones de "Próximos pasos" al final
