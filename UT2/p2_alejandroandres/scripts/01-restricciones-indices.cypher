// 1. RESTRICCIONES DE UNICIDAD
CREATE CONSTRAINT cst_receta_id IF NOT EXISTS FOR (r:Receta) REQUIRE r.id IS UNIQUE;
CREATE CONSTRAINT cst_ingrediente_id IF NOT EXISTS FOR (i:Ingrediente) REQUIRE i.id IS UNIQUE;
CREATE CONSTRAINT cst_alergeno_id IF NOT EXISTS FOR (a:Alergeno) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT cst_tipococina_id IF NOT EXISTS FOR (tc:TipoCocina) REQUIRE tc.id IS UNIQUE;
CREATE CONSTRAINT cst_usuario_id IF NOT EXISTS FOR (u:Usuario) REQUIRE u.id IS UNIQUE;

// 2. ÍNDICES SECUNDARIOS
CREATE INDEX idx_receta_nombre IF NOT EXISTS FOR (r:Receta) ON (r.nombre);
CREATE INDEX idx_ingrediente_nombre IF NOT EXISTS FOR (i:Ingrediente) ON (i.nombre);
CREATE INDEX idx_alergeno_nombre IF NOT EXISTS FOR (a:Alergeno) ON (a.nombre);
CREATE INDEX idx_receta_dificultad_tiempo IF NOT EXISTS FOR (r:Receta) ON (r.dificultad, r.tiempoMin);

// 3. VERIFICACIÓN
SHOW CONSTRAINTS;
SHOW INDEXES;
