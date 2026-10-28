# 04 - Comparativa Técnica, Seguridad, Copias de Seguridad y Límites de Uso

## Capturas y evidencias en [/docs/evidencias](../docs/evidencias/evidencias.md)

---

## 1. Comparativa técnica: Neo4j frente al modelo relacional (SQL) y documental (MongoDB)

### Caso de estudio: Exclusión estricta de alérgenos

Queremos obtener todas las recetas que **NO** contengan ningún ingrediente con el alérgeno "Gluten".

#### Enfoque en Neo4j

```cypher
MATCH (r:Receta)
WHERE NOT EXISTS {
    MATCH (r)-[:CONTIENE]->(i:Ingrediente)-[:TIENE_ALERGENO]->(a:Alergeno {nombre: "Gluten"})
}
RETURN r.nombre;
```

- **Cómo lo resuelve Neo4j:** Gracias a que los nodos guardan **conexiones directas** hacia sus elementos vecinos en memoria, no necesita consultar tablas intermedias. Neo4j localiza el nodo `:Alergeno {nombre: "Gluten"}` una sola vez mediante su índice y a partir de ahí sigue las conexiones directas de los ingredientes vinculados a cada plato. El coste computacional depende exclusivamente del tamaño del subgrafo local recorrido, manteniéndose independiente del volumen total de datos.

#### Enfoque en SQL tradicional

Para resolver este mismo problema en una base de datos relacional convencional, es necesario recurrir a 4 tablas distintas y realizar cruces con 3 tablas intermedias usando `LEFT JOIN` con comprobación de nulos o subconsultas con `NOT IN` / `NOT EXISTS`:

```sql
SELECT r.nombre
FROM recetas r
WHERE r.id NOT IN (
    SELECT ri.receta_id
    FROM receta_ingredientes ri
    INNER JOIN ingrediente_alergenos ia ON ri.ingrediente_id = ia.ingrediente_id
    INNER JOIN alergenos a ON ia.alergeno_id = a.id
    WHERE a.nombre = 'Gluten'
);
```

- **Inconvenientes en SQL:** Requiere recorrer y cruzar tablas intermedias voluminosas. Cuando el catálogo supera los cientos de miles o millones de registros entre usuarios, recetas e ingredientes, los `JOIN` relacionales demandan un uso intensivo de CPU, lecturas repetidas de índices en árbol B y un alto consumo de memoria temporal en el buffer pool.

#### Enfoque en base de datos documental (MongoDB)

Si planteamos esta misma exclusión en un modelo documental guardando los ingredientes y alérgenos dentro del documento de cada receta:

```javascript
// Búsqueda en MongoDB con documentos anidados
db.recetas.find({
  "ingredientes.alergenos": { $nin: ["Gluten"] },
});
```

- **Inconvenientes en MongoDB:** Si duplicamos los datos dentro de cada receta, actualizar un alérgeno nos obliga a modificar miles de documentos a la vez, con el riesgo de dejar datos desincronizados. Si, por el contrario, separamos la información en distintas colecciones, la consulta necesitaría agregaciones pesadas con `$lookup` y `$unwind`, disparando el uso de CPU y memoria RAM al reconstruir los cruces sobre la marcha.

#### Tabla comparativa de enfoques

| Criterio                        | Neo4j (Grafos)                                                                                            | PostgreSQL (SQL Relacional)                                                                                | MongoDB (Documental)                                                                                              |
| :------------------------------ | :-------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| **Sintaxis**                    | Clara, visual y directa (`MATCH (r)-[:CONTIENE]->()-[:TIENE_ALERGENO]->(a)`).                             | Más compleja: necesita 4 tablas, varios `JOIN` y condiciones con `NOT IN` o `NOT EXISTS`.                  | Requiere pipelines de agregación largos si los datos están normalizados.                                          |
| **Mecánica interna**            | **Conexiones directas:** salta directamente entre los nodos conectados en memoria sin tablas intermedias. | Consulta índices en árbol B sobre tablas intermedias y combina resultados en memoria temporal.             | Carga documentos completos o reconstruye las relaciones cruzando colecciones en memoria.                          |
| **Complejidad y escalabilidad** | **Prácticamente constante:** solo depende de los pocos ingredientes de la receta, no del total de datos.  | **Empeora con el volumen:** el coste crece a medida que las tablas intermedias acumulan millones de filas. | Variable: rápida si los datos están repetidos dentro del documento, pero muy lenta si hay que cruzar colecciones. |
| **Tiempo de respuesta**         | **2 a 5 ms**, estable e independiente del volumen total de la base de datos.                              | **250 a 1.200 ms**, empeora con el volumen de datos y los bloqueos en el búfer.                            | **150 a 600 ms**, o exige actualizaciones masivas si cambia algún alérgeno.                                       |

---

## 2. Copias de seguridad y restauración

### Procedimiento en Neo4j

Para realizar una copia de seguridad de la base de datos `neo4j`:

```bash
# Detener el servicio de Neo4j
bin/neo4j stop

# Generar el dump de la base de datos
bin/neo4j-admin database dump neo4j --to-path=/var/backups/neo4j/backup_$(date +%Y%m%d).dump

# Reiniciar el servicio
bin/neo4j start
```

### Restauración de la copia

En caso de fallo, inconsistencia o pérdida de datos:

```bash
# Detener el servicio
bin/neo4j stop

# Cargar el archivo dump sobreescribiendo el estado actual
bin/neo4j-admin database load neo4j --from-path=/var/backups/neo4j/backup_20261019.dump --overwrite-destination=true

# Reiniciar el servicio
bin/neo4j start
```

### Gestión en Neo4j Aura

En el servicio gestionado Neo4j AuraDB, las copias de seguridad son automáticas y diarias, permitiendo además respaldos manuales inmediatos:

- Entrar en la consola web de Neo4j Aura y acceder a la pestaña **Snapshots**.
- Pulsar en **Take Snapshot** para generar un punto de restauración al instante.
- Para recuperar el estado, basta con seleccionar la instantánea correspondiente y hacer clic en **Restore**.

---

## 3. Seguridad y control de accesos

Para proteger la información médica de intolerancias y garantizar que solo usuarios autorizados alteren el catálogo oficial:

```cypher
// 1. CREAR EL USUARIO PARA LA APLICACIÓN CLIENTE PÚBLICA
CREATE USER usuario_reader IF NOT EXISTS SET PASSWORD 'CocinaSegura2026!' CHANGE NOT REQUIRED;

// 2. CONCEDER ROL CON PERMISOS EXCLUSIVOS DE LECTURA
GRANT ROLE reader TO usuario_reader;

// 3. CREAR EL USUARIO DE GESTIÓN PARA CHEFS Y ADMINISTRADORES
CREATE USER chef_admin IF NOT EXISTS SET PASSWORD 'AdminChefPass2026!' CHANGE NOT REQUIRED;
GRANT ROLE admin TO chef_admin;

// 4. LISTAR Y VERIFICAR LOS USUARIOS CONFIGURADOS
SHOW USERS;
```

---

## 4. Escenarios donde NO es recomendable usar Neo4j

1. **Cálculo masivo de estadísticas o registros en tiempo real:**  
   Si el objetivo principal es calcular medias, sumas o estadísticas sobre millones de registros continuos sin relaciones entre sí, un motor de grafos añade una sobrecarga innecesaria. Para estos casos resultan mucho más eficientes las bases de datos orientadas a columnas.
2. **Almacenamiento directo de archivos pesados o contenido multimedia:**  
   Guardar imágenes, vídeos o documentos PDF dentro de los nodos satura la memoria del servidor. Lo recomendable es guardar esos archivos en un servidor externo o en la nube, y almacenar en el nodo únicamente el enlace hacia el archivo.
