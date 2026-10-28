# Práctica 02: Diseño de una base de datos de grafos con Neo4j

**Alumno:** Alejandro Andrés Bermejo  
**Escenario:** Red de recetas de cocina y alérgenos (platos, ingredientes, tipos de cocina y alérgenos como gluten o lactosa; resolución de sugerencias basadas en despensa y exclusión estricta de alérgenos).  
**Entorno:** Neo4j 5.x / Neo4j Desktop / Neo4j Browser

---

## 1. Definición del problema y actores

### 1.1 Contexto

Para esta práctica he planteado el caso de una **red de recetas de cocina y gestión de alérgenos**. La meta principal es estructurar una base de datos basada en grafos para conectar recetas con sus ingredientes, identificar los alérgenos vinculados a cada alimento y asociar platos a sus estilos o tipos de cocina. Además, el modelo contempla a los usuarios, permitiendo gestionar tanto sus despensas caseras como sus intolerancias alimentarias.

### 1.2 Actores del sistema

El sistema cuenta con dos perfiles de usuario principales:

- **Usuario:** Indica qué ingredientes tiene en casa, registra sus alergias o intolerancias y consulta sugerencias de platos seguros y adaptados a su despensa.
- **Chef:** Introduce y actualiza recetas en el catálogo, detallando cantidades, tiempos de preparación, ingredientes necesarios y el tipo de gastronomía.

### 1.3 Preguntas de negocio que responde el modelo

El grafo permite resolver con rapidez 6 preguntas clave de negocio:

1. **Composición de una receta:** ¿Qué ingredientes forman un plato determinado y a qué tipo de cocina pertenece?
2. **Detección de alérgenos:** ¿Qué alérgenos están presentes en una receta a partir de sus ingredientes?
3. **Filtro estricto de seguridad:** ¿Qué platos son 100% aptos para personas con celiaquía o intolerancia a la lactosa?
4. **Aprovechamiento de despensa:** ¿Qué recetas se pueden elaborar únicamente con los ingredientes disponibles en casa?
5. **Afinidad gastronómica:** ¿Qué otros platos comparten ingredientes clave con una receta concreta?
6. **Camino más corto:** ¿Cuál es la ruta mínima que conecta dos platos distintos a través de ingredientes y categorías compartidas?

### 1.4 Análisis de lecturas y escrituras

Tras analizar el comportamiento esperado del sistema, destacan dos patrones claros:

- **Lecturas prioritarias:** Búsqueda en tiempo real de recomendaciones, cruce de recetas con el inventario del usuario y filtrado estricto de alérgenos para evitar cualquier riesgo de salud.
- **Escrituras habituales:** Publicación de nuevas recetas por parte de los chefs, actualización del stock de despensa de los usuarios y cambios en las intolerancias registradas.

### 1.5 Matriz de accesos y consultas

| Pregunta | Nodos consultados                        | Relaciones recorridas                 | Frecuencia       |
| -------- | ---------------------------------------- | ------------------------------------- | ---------------- |
| **1**    | `:Receta`, `:Ingrediente`, `:TipoCocina` | `[:CONTIENE]`, `[:PERTENECE_A]`       | Alta             |
| **2**    | `:Receta`, `:Ingrediente`, `:Alergeno`   | `[:CONTIENE]`, `[:TIENE_ALERGENO]`    | Muy alta         |
| **3**    | `:Receta`, `:Ingrediente`, `:Alergeno`   | `[:CONTIENE]`, `[:TIENE_ALERGENO]`    | Crítica / Alta   |
| **4**    | `:Usuario`, `:Ingrediente`, `:Receta`    | `[:TIENE_EN_DESPENSA]`, `[:CONTIENE]` | Muy alta         |
| **5**    | `:Receta`, `:Ingrediente`                | `[:CONTIENE]` bidireccional           | Media            |
| **6**    | `:Receta`, `:Ingrediente`, `:TipoCocina` | Cualquier relación (`-[*]-`)          | Ocasional        |

### 1.6 Seguridad, privacidad, disponibilidad y escalabilidad

- **Seguridad:** Se aplica un modelo de control de acceso por roles. La aplicación pública opera bajo un usuario de solo lectura, mientras que las tareas de gestión del catálogo requieren privilegios de administración.
- **Privacidad:** Tratándose de datos sensibles sobre salud e intolerancias, en desarrollo se usan únicamente datos ficticios y de prueba, previendo identificadores anonimizados de cara a producción.
- **Disponibilidad:** Se plantea una arquitectura en clúster con réplicas de lectura para absorber picos de tráfico en búsquedas sin penalizar tiempos de respuesta.
- **Escalabilidad:** Se han tenido en cuenta los ingredientes comodín para prevenir supernodos y se han configurado índices sobre las propiedades más consultadas.

---

## 2. Guía de ejecución y reproducción

Los scripts están organizados para ejecutarse en el siguiente orden:

1. **Restricciones de unicidad e índices:** Ejecutar [`scripts/01-restricciones-indices.cypher`](./scripts/01-restricciones-indices.cypher) para asegurar la integridad de los datos y optimizar las consultas.
2. **Carga inicial de datos:** Ejecutar [`scripts/02-carga-datos.cypher`](./scripts/02-carga-datos.cypher) para insertar los datos de prueba de forma segura sin duplicar nada gracias a `MERGE`.
3. **Consultas de negocio y algoritmos de grafos:** Ejecutar [`scripts/03-consultas-recorridos.cypher`](./scripts/03-consultas-recorridos.cypher), donde se resuelven y analizan las 6 preguntas planteadas, incluyendo perfiles de ejecución con `PROFILE`.
4. **Comparativa técnica, seguridad y copias de seguridad:** Consultar [`scripts/04-backup.md`](./scripts/04-backup.md) para revisar la comparativa frente a SQL y MongoDB, la gestión de usuarios y las políticas de respaldo.
5. **Memoria y justificación del modelo:** Revisar [`docs/modelo.md`](./docs/modelo.md) para ver la justificación conceptual y los diagramas del grafo.
6. **Evidencias:** Las capturas de pantalla de cada fase se encuentran recopiladas en [`docs/evidencias/evidencias.md`](./docs/evidencias/evidencias.md).
