// 1. ALÉRGENOS
MERGE (a1:Alergeno {id: "ALG_GLUTEN"})
ON CREATE SET a1.nombre = "Gluten", a1.gravedad = "Alta";

MERGE (a2:Alergeno {id: "ALG_LACTOSA"})
ON CREATE SET a2.nombre = "Lactosa", a2.gravedad = "Alta";

MERGE (a3:Alergeno {id: "ALG_HUEVO"})
ON CREATE SET a3.nombre = "Huevo", a3.gravedad = "Media";

MERGE (a4:Alergeno {id: "ALG_PESCADO"})
ON CREATE SET a4.nombre = "Pescado", a4.gravedad = "Alta";

MERGE (a5:Alergeno {id: "ALG_FRUTOS_SECOS"})
ON CREATE SET a5.nombre = "Frutos Secos", a5.gravedad = "Alta";


// 2. TIPOS DE COCINA
MERGE (tc1:TipoCocina {id: "COC_MED"})
ON CREATE SET tc1.nombre = "Mediterránea", tc1.origen = "Sur de Europa";

MERGE (tc2:TipoCocina {id: "COC_ITA"})
ON CREATE SET tc2.nombre = "Italiana", tc2.origen = "Italia";

MERGE (tc3:TipoCocina {id: "COC_MEX"})
ON CREATE SET tc3.nombre = "Mexicana", tc3.origen = "México";

MERGE (tc4:TipoCocina {id: "COC_ASI"})
ON CREATE SET tc4.nombre = "Asiática", tc4.origen = "Asia Oriental";


// 3. INGREDIENTES Y ALÉRGENOS
MERGE (i_harina:Ingrediente {id: "ING_HARINA_TRIGO"})
ON CREATE SET i_harina.nombre = "Harina de trigo", i_harina.categoria = "Cereales";

MERGE (i_espagueti:Ingrediente {id: "ING_ESPAGUETI"})
ON CREATE SET i_espagueti.nombre = "Espaguetis de trigo", i_espagueti.categoria = "Pastas";

MERGE (i_leche:Ingrediente {id: "ING_LECHE"})
ON CREATE SET i_leche.nombre = "Leche entera", i_leche.categoria = "Lácteos";

MERGE (i_queso_parm:Ingrediente {id: "ING_PARMESANO"})
ON CREATE SET i_queso_parm.nombre = "Queso Parmesano", i_queso_parm.categoria = "Lácteos";

MERGE (i_nata:Ingrediente {id: "ING_NATA"})
ON CREATE SET i_nata.nombre = "Nata para cocinar", i_nata.categoria = "Lácteos";

MERGE (i_huevo:Ingrediente {id: "ING_HUEVO"})
ON CREATE SET i_huevo.nombre = "Huevo fresco", i_huevo.categoria = "Huevos";

MERGE (i_atun:Ingrediente {id: "ING_ATUN"})
ON CREATE SET i_atun.nombre = "Atún fresco", i_atun.categoria = "Pescados";

MERGE (i_patata:Ingrediente {id: "ING_PATATA"})
ON CREATE SET i_patata.nombre = "Patata", i_patata.categoria = "Tubérculos";

MERGE (i_cebolla:Ingrediente {id: "ING_CEBOLLA"})
ON CREATE SET i_cebolla.nombre = "Cebolla", i_cebolla.categoria = "Verduras";

MERGE (i_tomate:Ingrediente {id: "ING_TOMATE"})
ON CREATE SET i_tomate.nombre = "Tomate", i_tomate.categoria = "Verduras";

MERGE (i_aceite:Ingrediente {id: "ING_ACEITE"})
ON CREATE SET i_aceite.nombre = "Aceite de oliva virgen", i_aceite.categoria = "Aceites";

MERGE (i_arroz:Ingrediente {id: "ING_ARROZ"})
ON CREATE SET i_arroz.nombre = "Arroz bomba", i_arroz.categoria = "Cereales sin gluten";

MERGE (i_aguacate:Ingrediente {id: "ING_AGUACATE"})
ON CREATE SET i_aguacate.nombre = "Aguacate", i_aguacate.categoria = "Frutas";

MERGE (i_guacamole_mix:Ingrediente {id: "ING_LIMA"})
ON CREATE SET i_guacamole_mix.nombre = "Lima", i_guacamole_mix.categoria = "Frutas";

MERGE (i_pollo:Ingrediente {id: "ING_POLLO"})
ON CREATE SET i_pollo.nombre = "Pechuga de pollo", i_pollo.categoria = "Carnes";

MERGE (i_tortilla_maiz:Ingrediente {id: "ING_TORTILLA_MAIZ"})
ON CREATE SET i_tortilla_maiz.nombre = "Tortilla de maíz", i_tortilla_maiz.categoria = "Cereales sin gluten";

// RELACIONES INGREDIENTE -> ALÉRGENO
MERGE (i:Ingrediente {id: "ING_HARINA_TRIGO"})
MERGE (a:Alergeno {id: "ALG_GLUTEN"})
MERGE (i)-[:TIENE_ALERGENO]->(a);

MERGE (i:Ingrediente {id: "ING_ESPAGUETI"})
MERGE (a:Alergeno {id: "ALG_GLUTEN"})
MERGE (i)-[:TIENE_ALERGENO]->(a);

MERGE (i:Ingrediente {id: "ING_LECHE"})
MERGE (a:Alergeno {id: "ALG_LACTOSA"})
MERGE (i)-[:TIENE_ALERGENO]->(a);

MERGE (i:Ingrediente {id: "ING_PARMESANO"})
MERGE (a:Alergeno {id: "ALG_LACTOSA"})
MERGE (i)-[:TIENE_ALERGENO]->(a);

MERGE (i:Ingrediente {id: "ING_NATA"})
MERGE (a:Alergeno {id: "ALG_LACTOSA"})
MERGE (i)-[:TIENE_ALERGENO]->(a);

MERGE (i:Ingrediente {id: "ING_HUEVO"})
MERGE (a:Alergeno {id: "ALG_HUEVO"})
MERGE (i)-[:TIENE_ALERGENO]->(a);

MERGE (i:Ingrediente {id: "ING_ATUN"})
MERGE (a:Alergeno {id: "ALG_PESCADO"})
MERGE (i)-[:TIENE_ALERGENO]->(a);


// 4. RECETAS Y TIPO DE COCINA
// R1: TORTILLA DE PATATAS (MEDITERRÁNEA)
MERGE (r1:Receta {id: "REC_01"})
ON CREATE SET r1.nombre = "Tortilla de Patatas", r1.tiempoMin = 30, r1.dificultad = "Fácil", r1.calorias = 350;
MERGE (r:Receta {id: "REC_01"})
MERGE (tc:TipoCocina {id: "COC_MED"})
MERGE (r)-[:PERTENECE_A]->(tc);

// R2: CARBONARA (ITALIANA)
MERGE (r2:Receta {id: "REC_02"})
ON CREATE SET r2.nombre = "Espaguetis a la Carbonara", r2.tiempoMin = 25, r2.dificultad = "Media", r2.calorias = 580;
MERGE (r:Receta {id: "REC_02"})
MERGE (tc:TipoCocina {id: "COC_ITA"})
MERGE (r)-[:PERTENECE_A]->(tc);

// R3: GUACAMOLE (MEXICANA)
MERGE (r3:Receta {id: "REC_03"})
ON CREATE SET r3.nombre = "Guacamole Casero", r3.tiempoMin = 15, r3.dificultad = "Fácil", r3.calorias = 220;
MERGE (r:Receta {id: "REC_03"})
MERGE (tc:TipoCocina {id: "COC_MEX"})
MERGE (r)-[:PERTENECE_A]->(tc);

// R4: ENSALADA CAMPERA (MEDITERRÁNEA)
MERGE (r4:Receta {id: "REC_04"})
ON CREATE SET r4.nombre = "Ensalada Campera", r4.tiempoMin = 20, r4.dificultad = "Fácil", r4.calorias = 290;
MERGE (r:Receta {id: "REC_04"})
MERGE (tc:TipoCocina {id: "COC_MED"})
MERGE (r)-[:PERTENECE_A]->(tc);

// R5: TACOS POLLO (MEXICANA)
MERGE (r5:Receta {id: "REC_05"})
ON CREATE SET r5.nombre = "Tacos de Pollo Suaves", r5.tiempoMin = 35, r5.dificultad = "Fácil", r5.calorias = 410;
MERGE (r:Receta {id: "REC_05"})
MERGE (tc:TipoCocina {id: "COC_MEX"})
MERGE (r)-[:PERTENECE_A]->(tc);

// R6: ARROZ CON POLLO (MEDITERRÁNEA)
MERGE (r6:Receta {id: "REC_06"})
ON CREATE SET r6.nombre = "Arroz con Pollo Mediterráneo", r6.tiempoMin = 45, r6.dificultad = "Media", r6.calorias = 480;
MERGE (r:Receta {id: "REC_06"})
MERGE (tc:TipoCocina {id: "COC_MED"})
MERGE (r)-[:PERTENECE_A]->(tc);


// 5. RECETAS -> INGREDIENTES
// R1: TORTILLA DE PATATAS
MERGE (r:Receta {id: "REC_01"})
MERGE (i:Ingrediente {id: "ING_PATATA"})
MERGE (r)-[:CONTIENE {cantidad: 4, unidad: "unidades"}]->(i);

MERGE (r:Receta {id: "REC_01"})
MERGE (i:Ingrediente {id: "ING_HUEVO"})
MERGE (r)-[:CONTIENE {cantidad: 5, unidad: "unidades"}]->(i);

MERGE (r:Receta {id: "REC_01"})
MERGE (i:Ingrediente {id: "ING_CEBOLLA"})
MERGE (r)-[:CONTIENE {cantidad: 1, unidad: "unidad"}]->(i);

MERGE (r:Receta {id: "REC_01"})
MERGE (i:Ingrediente {id: "ING_ACEITE"})
MERGE (r)-[:CONTIENE {cantidad: 50, unidad: "ml"}]->(i);

// R2: CARBONARA (ESPAGUETIS, HUEVO, PARMESANO, ACEITE)
MERGE (r:Receta {id: "REC_02"})
MERGE (i:Ingrediente {id: "ING_ESPAGUETI"})
MERGE (r)-[:CONTIENE {cantidad: 200, unidad: "gramos"}]->(i);

MERGE (r:Receta {id: "REC_02"})
MERGE (i:Ingrediente {id: "ING_HUEVO"})
MERGE (r)-[:CONTIENE {cantidad: 3, unidad: "yemas"}]->(i);

MERGE (r:Receta {id: "REC_02"})
MERGE (i:Ingrediente {id: "ING_PARMESANO"})
MERGE (r)-[:CONTIENE {cantidad: 60, unidad: "gramos"}]->(i);

MERGE (r:Receta {id: "REC_02"})
MERGE (i:Ingrediente {id: "ING_ACEITE"})
MERGE (r)-[:CONTIENE {cantidad: 20, unidad: "ml"}]->(i);

// R3: GUACAMOLE (AGUACATE, TOMATE, CEBOLLA, LIMA, ACEITE)
MERGE (r:Receta {id: "REC_03"})
MERGE (i:Ingrediente {id: "ING_AGUACATE"})
MERGE (r)-[:CONTIENE {cantidad: 2, unidad: "piezas"}]->(i);

MERGE (r:Receta {id: "REC_03"})
MERGE (i:Ingrediente {id: "ING_TOMATE"})
MERGE (r)-[:CONTIENE {cantidad: 1, unidad: "pieza"}]->(i);

MERGE (r:Receta {id: "REC_03"})
MERGE (i:Ingrediente {id: "ING_CEBOLLA"})
MERGE (r)-[:CONTIENE {cantidad: 0.5, unidad: "pieza"}]->(i);

MERGE (r:Receta {id: "REC_03"})
MERGE (i:Ingrediente {id: "ING_LIMA"})
MERGE (r)-[:CONTIENE {cantidad: 1, unidad: "pieza"}]->(i);

MERGE (r:Receta {id: "REC_03"})
MERGE (i:Ingrediente {id: "ING_ACEITE"})
MERGE (r)-[:CONTIENE {cantidad: 15, unidad: "ml"}]->(i);

// R4: ENSALADA CAMPERA (PATATA, TOMATE, CEBOLLA, HUEVO, ATÚN, ACEITE)
MERGE (r:Receta {id: "REC_04"})
MERGE (i:Ingrediente {id: "ING_PATATA"})
MERGE (r)-[:CONTIENE {cantidad: 3, unidad: "unidades"}]->(i);

MERGE (r:Receta {id: "REC_04"})
MERGE (i:Ingrediente {id: "ING_TOMATE"})
MERGE (r)-[:CONTIENE {cantidad: 2, unidad: "unidades"}]->(i);

MERGE (r:Receta {id: "REC_04"})
MERGE (i:Ingrediente {id: "ING_CEBOLLA"})
MERGE (r)-[:CONTIENE {cantidad: 0.5, unidad: "unidad"}]->(i);

MERGE (r:Receta {id: "REC_04"})
MERGE (i:Ingrediente {id: "ING_HUEVO"})
MERGE (r)-[:CONTIENE {cantidad: 2, unidad: "unidades"}]->(i);

MERGE (r:Receta {id: "REC_04"})
MERGE (i:Ingrediente {id: "ING_ATUN"})
MERGE (r)-[:CONTIENE {cantidad: 150, unidad: "gramos"}]->(i);

MERGE (r:Receta {id: "REC_04"})
MERGE (i:Ingrediente {id: "ING_ACEITE"})
MERGE (r)-[:CONTIENE {cantidad: 30, unidad: "ml"}]->(i);

// R5: TACOS POLLO (TORTILLA MAÍZ, POLLO, CEBOLLA, TOMATE, AGUACATE)
MERGE (r:Receta {id: "REC_05"})
MERGE (i:Ingrediente {id: "ING_TORTILLA_MAIZ"})
MERGE (r)-[:CONTIENE {cantidad: 4, unidad: "unidades"}]->(i);

MERGE (r:Receta {id: "REC_05"})
MERGE (i:Ingrediente {id: "ING_POLLO"})
MERGE (r)-[:CONTIENE {cantidad: 300, unidad: "gramos"}]->(i);

MERGE (r:Receta {id: "REC_05"})
MERGE (i:Ingrediente {id: "ING_CEBOLLA"})
MERGE (r)-[:CONTIENE {cantidad: 1, unidad: "unidad"}]->(i);

MERGE (r:Receta {id: "REC_05"})
MERGE (i:Ingrediente {id: "ING_TOMATE"})
MERGE (r)-[:CONTIENE {cantidad: 1, unidad: "unidad"}]->(i);

MERGE (r:Receta {id: "REC_05"})
MERGE (i:Ingrediente {id: "ING_AGUACATE"})
MERGE (r)-[:CONTIENE {cantidad: 1, unidad: "unidad"}]->(i);

// R6: ARROZ POLLO (ARROZ, POLLO, TOMATE, CEBOLLA, ACEITE)
MERGE (r:Receta {id: "REC_06"})
MERGE (i:Ingrediente {id: "ING_ARROZ"})
MERGE (r)-[:CONTIENE {cantidad: 250, unidad: "gramos"}]->(i);

MERGE (r:Receta {id: "REC_06"})
MERGE (i:Ingrediente {id: "ING_POLLO"})
MERGE (r)-[:CONTIENE {cantidad: 350, unidad: "gramos"}]->(i);

MERGE (r:Receta {id: "REC_06"})
MERGE (i:Ingrediente {id: "ING_TOMATE"})
MERGE (r)-[:CONTIENE {cantidad: 2, unidad: "piezas"}]->(i);

MERGE (r:Receta {id: "REC_06"})
MERGE (i:Ingrediente {id: "ING_CEBOLLA"})
MERGE (r)-[:CONTIENE {cantidad: 1, unidad: "pieza"}]->(i);

MERGE (r:Receta {id: "REC_06"})
MERGE (i:Ingrediente {id: "ING_ACEITE"})
MERGE (r)-[:CONTIENE {cantidad: 40, unidad: "ml"}]->(i);


// 6. USUARIOS, INTOLERANCIAS Y DESPENSA
// USUARIO 1: ALEJANDRO (GLUTEN)
MERGE (u1:Usuario {id: "USR_01"})
ON CREATE SET u1.nombre = "Alejandro Andrés", u1.email = "alejandro@example.com";
MERGE (u:Usuario {id: "USR_01"})
MERGE (a:Alergeno {id: "ALG_GLUTEN"})
MERGE (u)-[:TIENE_INTOLERANCIA {fecha_diagnostico: date("2023-01-15")}]->(a);

// USUARIO 2: BEATRIZ (LACTOSA)
MERGE (u2:Usuario {id: "USR_02"})
ON CREATE SET u2.nombre = "Beatriz Gómez", u2.email = "beatriz@example.com";
MERGE (u:Usuario {id: "USR_02"})
MERGE (a:Alergeno {id: "ALG_LACTOSA"})
MERGE (u)-[:TIENE_INTOLERANCIA {fecha_diagnostico: date("2022-06-20")}]->(a);

// USUARIO 3: CARLOS (DESPENSA)
MERGE (u3:Usuario {id: "USR_03"})
ON CREATE SET u3.nombre = "Carlos Martínez", u3.email = "carlos@example.com";

MERGE (u:Usuario {id: "USR_03"})
MERGE (i:Ingrediente {id: "ING_PATATA"})
MERGE (u)-[:TIENE_EN_DESPENSA {cantidad: 10}]->(i);

MERGE (u:Usuario {id: "USR_03"})
MERGE (i:Ingrediente {id: "ING_HUEVO"})
MERGE (u)-[:TIENE_EN_DESPENSA {cantidad: 12}]->(i);

MERGE (u:Usuario {id: "USR_03"})
MERGE (i:Ingrediente {id: "ING_CEBOLLA"})
MERGE (u)-[:TIENE_EN_DESPENSA {cantidad: 3}]->(i);

MERGE (u:Usuario {id: "USR_03"})
MERGE (i:Ingrediente {id: "ING_ACEITE"})
MERGE (u)-[:TIENE_EN_DESPENSA {cantidad: 1000}]->(i);

// HISTORIAL DE RECETAS COCINADAS
MERGE (u:Usuario {id: "USR_01"})
MERGE (r:Receta {id: "REC_03"})
MERGE (u)-[:HA_COCINADO {fecha: date("2024-02-10"), puntuacion: 5}]->(r);

MERGE (u:Usuario {id: "USR_02"})
MERGE (r:Receta {id: "REC_01"})
MERGE (u)-[:HA_COCINADO {fecha: date("2024-02-12"), puntuacion: 4}]->(r);

MERGE (u:Usuario {id: "USR_03"})
MERGE (r:Receta {id: "REC_01"})
MERGE (u)-[:HA_COCINADO {fecha: date("2024-02-14"), puntuacion: 5}]->(r);


// 7. VISUALIZAR EL GRAFO COMPLETO
MATCH (n)
OPTIONAL MATCH (n)-[r]->(m)
RETURN n, r, m
LIMIT 300;
