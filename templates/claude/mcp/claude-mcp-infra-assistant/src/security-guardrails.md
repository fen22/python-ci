# Security Guardrails — Claude MCP Infra Assistant

## Principio fundamental

**Este asistente es READ-ONLY por defecto.** Cualquier acción que modifique infraestructura requiere aprobación humana explícita antes de ejecutarse.

---

## IAM Policy mínima de solo lectura (AWS)

Usar esta policy para el usuario/rol de AWS usado por el MCP server:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "InfraReadOnly",
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "ec2:List*",
        "ec2:Get*",
        "rds:Describe*",
        "rds:List*",
        "eks:Describe*",
        "eks:List*",
        "s3:List*",
        "s3:GetBucketLocation",
        "s3:GetBucketPolicy",
        "s3:GetBucketTagging",
        "cloudwatch:Describe*",
        "cloudwatch:Get*",
        "cloudwatch:List*",
        "cloudformation:Describe*",
        "cloudformation:List*",
        "cloudformation:Get*",
        "ce:GetCostAndUsage",
        "ce:GetCostForecast",
        "ce:GetDimensionValues",
        "iam:List*",
        "iam:Get*"
      ],
      "Resource": "*"
    },
    {
      "Sid": "ExplicitDeny",
      "Effect": "Deny",
      "Action": [
        "ec2:TerminateInstances",
        "ec2:StopInstances",
        "ec2:RunInstances",
        "ec2:Authorize*",
        "ec2:Revoke*",
        "rds:DeleteDBInstance",
        "rds:DeleteDBCluster",
        "s3:DeleteBucket",
        "s3:DeleteObject",
        "iam:CreateUser",
        "iam:DeleteUser",
        "iam:AttachUserPolicy",
        "iam:CreateAccessKey",
        "secretsmanager:GetSecretValue",
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:GetParametersByPath"
      ],
      "Resource": "*"
    }
  ]
}
```

---

## Preguntas seguras (ejemplos)

Estas preguntas son safe para hacer al asistente:

```
¿Cuántas instancias EC2 tenemos corriendo en producción?
¿Cuáles son los grupos de seguridad asociados a nuestro RDS?
¿Qué PRs están abiertos en el repositorio de infraestructura?
¿Cuánto gastamos en EC2 el mes pasado según Cost Explorer?
¿Qué versión de Kubernetes usa nuestro cluster EKS?
¿Hay algún stack de CloudFormation en estado ROLLBACK_COMPLETE?
¿Qué alarmas de CloudWatch están en estado ALARM?
```

---

## Acciones prohibidas (ejemplos)

Nunca pidas al asistente que haga esto sin un proceso de aprobación formal:

```
❌ "Termina la instancia i-1234567890abcdef0"
❌ "Elimina el bucket s3://backups-prod-2023"
❌ "Agrega una regla al security group sg-abc123 para abrir el puerto 22"
❌ "Cambia el tamaño de la instancia RDS a db.r6g.xlarge"
❌ "Haz merge del PR #42"
❌ "Modifica la política IAM del rol production-deployer"
❌ "Dame el valor del secreto /prod/db/password"
```

---

## GitHub Token: scopes mínimos

El token de GitHub para el MCP server debe tener SOLO:

| Scope | Permitido | Razón |
|---|---|---|
| `read:org` | ✅ | Ver repositorios de la organización |
| `repo` (read) | ✅ | Leer PRs, issues, código |
| `repo` (write) | ❌ | No necesario |
| `delete_repo` | ❌ | Explícitamente prohibido |
| `admin:org` | ❌ | Explícitamente prohibido |

Crear el token en GitHub → Settings → Developer settings → Fine-grained tokens → seleccionar repositorios específicos.

---

## Checklist antes de usar en producción

- [ ] IAM user tiene SOLO la policy de solo lectura documentada arriba
- [ ] No hay `AWS_SECRET_ACCESS_KEY` en ningún archivo del repositorio
- [ ] GitHub token es fine-grained y limitado a repos necesarios
- [ ] Filesystem MCP usa `--readonly` flag
- [ ] El equipo sabe que cualquier cambio en infraestructura requiere proceso de aprobación separado
- [ ] Este asistente NO reemplaza los procesos de change management existentes
