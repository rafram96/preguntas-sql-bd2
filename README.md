# preguntas-sql-bd2

Material de práctica de SQL para el curso **CS2042 Base de Datos 2** (UTEC, 2026).
Contiene la base de datos de trabajo de la lista de ejercicios y el entorno Docker
para la parte de PostgreSQL distribuido. Los enunciados están en el PDF de la lista
de ejercicios, publicado en el Discord del curso.

## Contenido

| Archivo | Descripción |
|---|---|
| `tienda.sql` | Crea y llena la base `tienda` usada en los ejercicios 1–23. |
| `docker-compose.yml` | Levanta un coordinador y dos nodos PostgreSQL 16 para los ejercicios de `postgres_fdw`. |

## Requisitos

- PostgreSQL 16 (cliente `psql`)
- Docker y Docker Compose, solo para la parte distribuida

## Uso

### Base de datos `tienda` (ejercicios 1–23)

```bash
createdb tienda
psql -d tienda -f tienda.sql
```

El script empieza con `DROP TABLE IF EXISTS ... CASCADE`, así que puedes volver a
ejecutarlo para restaurar los datos después de practicar `UPDATE` y `DELETE`.

Tablas: `sede`, `empleado`, `cliente`, `categoria`, `producto`, `pedido` y
`detalle_pedido`.

### PostgreSQL distribuido (ejercicios 24–30)

```bash
docker compose up -d
```

| Servicio | Rol | Puerto local |
|---|---|---|
| `coordinador` | Coordinador (Lima) | 5433 |
| `nodo_arequipa` | Nodo remoto | 5434 |
| `nodo_trujillo` | Nodo remoto | 5435 |

Usuario y contraseña: `postgres` / `postgres`.

```bash
psql -h localhost -p 5433 -U postgres   # coordinador
```

Dentro de la red de Docker, el coordinador ve a los nodos por su nombre de servicio
(`nodo_arequipa` y `nodo_trujillo`, puerto 5432). Usa esos nombres al crear los
servidores con `CREATE SERVER ... OPTIONS (host 'nodo_arequipa', port '5432', ...)`.

Para apagar el entorno:

```bash
docker compose down
```

## Temas

- Consultas básicas y DML: `SELECT`, `WHERE`, `LIKE`, `ORDER BY`, `LIMIT`, `INSERT`, `UPDATE`, `DELETE`
- Joins: `INNER`, `LEFT`, self-join, producto cartesiano
- Agregación: `GROUP BY`, `HAVING`, top-N, `COUNT(DISTINCT)`
- Subconsultas no recursivas: `IN`/`EXISTS`, correlacionadas, `ALL`, división relacional
- PostgreSQL distribuido: particiones `LIST`/`RANGE`/`HASH`, partition pruning,
  `ATTACH`/`DETACH`, `postgres_fdw`

## Licencia

Distribuido bajo la licencia MIT. Ver [LICENSE](LICENSE).
