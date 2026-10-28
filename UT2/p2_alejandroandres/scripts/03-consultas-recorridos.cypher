// OPERACIÓN BÁSICA
MERGE (i:Ingrediente {id: "ING_AJO"})
ON CREATE SET i.nombre = "Ajo", i.categoria = "Condimentos", i.creado = timestamp()
ON MATCH SET i.actualizado = timestamp()
WITH i
MATCH (r:Receta {id: "REC_01"})
MERGE (r)-[c:CONTIENE]->(i)
ON CREATE SET c.cantidad = 1, c.unidad = "diente"
RETURN r.nombre AS Receta, type(c) AS Relacion, i.nombre AS Ingrediente;


// CONSULTA 1: VECINOS INMEDIATOS (INGREDIENTES Y TIPO DE COCINA DE TORTILLA DE PATATAS)
MATCH (r:Receta {nombre: "Tortilla de Patatas"})-[:PERTENECE_A]->(tc:TipoCocina)
MATCH (r)-[c:CONTIENE]->(i:Ingrediente)
RETURN r.nombre AS Receta,
       tc.nombre AS TipoCocina,
       i.nombre AS Ingrediente,
       c.cantidad AS Cantidad,
       c.unidad AS Unidad
ORDER BY i.nombre;


// CONSULTA 2: DETECCIÓN DE ALÉRGENOS POR PLATO (2 SALTOS)
MATCH (r:Receta)-[:CONTIENE]->(i:Ingrediente)-[:TIENE_ALERGENO]->(a:Alergeno)
RETURN r.nombre AS Receta,
       collect(DISTINCT i.nombre) AS IngredientesConAlergeno,
       collect(DISTINCT a.nombre) AS AlergenosDetectados
ORDER BY r.nombre;


// CONSULTA 3: EXCLUSIÓN ESTRICTA DE ALÉRGENOS (SIN GLUTEN)
PROFILE
MATCH (r:Receta)
WHERE NOT EXISTS {
    MATCH (r)-[:CONTIENE]->(i:Ingrediente)-[:TIENE_ALERGENO]->(a:Alergeno {nombre: "Gluten"})
}
RETURN r.nombre AS RecetaSeguraSinGluten,
       r.tiempoMin AS Minutos,
       r.dificultad AS Dificultad,
       r.calorias AS Calorias
ORDER BY r.tiempoMin ASC;


// CONSULTA 4: SUGERENCIA POR DESPENSA (RECETAS QUE PUEDE HACER CARLOS CON LO QUE TIENE)
MATCH (u:Usuario {id: "USR_03"})
MATCH (r:Receta)
WITH u, r, [(r)-[:CONTIENE]->(i:Ingrediente) | i] AS ingredientesReceta
WITH r, ingredientesReceta, [(u)-[:TIENE_EN_DESPENSA]->(i:Ingrediente) | i] AS despensaUsuario
WHERE all(ing IN ingredientesReceta WHERE ing IN despensaUsuario)
RETURN r.nombre AS RecetaPosible,
       [ing IN ingredientesReceta | ing.nombre] AS IngredientesNecesarios,
       r.tiempoMin AS TiempoPreparacion;


// CONSULTA 5: RECOMENDACIÓN POR AFINIDAD (INGREDIENTES COMPARTIDOS CON TORTILLA DE PATATAS)
MATCH (r1:Receta {nombre: "Tortilla de Patatas"})-[:CONTIENE]->(i:Ingrediente)<-[:CONTIENE]-(r2:Receta)
WHERE r1 <> r2
RETURN r2.nombre AS RecetaSugerida,
       count(i) AS IngredientesCompartidos,
       collect(i.nombre) AS CualesComparten
ORDER BY IngredientesCompartidos DESC;


// CONSULTA 6: CAMINO MÁS CORTO (SHORTESTPATH ENTRE DOS RECETAS)
MATCH (r1:Receta {nombre: "Tortilla de Patatas"}),
      (r2:Receta {nombre: "Tacos de Pollo Suaves"})
MATCH p = shortestPath((r1)-[*]-(r2))
RETURN p AS CaminoMinimo,
       length(p) AS NumeroDeSaltos,
       [n IN nodes(p) | coalesce(n.nombre, labels(n)[0])] AS NodosEnElCamino;
