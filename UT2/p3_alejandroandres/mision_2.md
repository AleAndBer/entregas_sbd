# Misión 2 · El castillo y la cámara

**Contexto:** El guardia de la puerta no recuerda quién cruzó el umbral. Necesitamos verificar qué jugadores estuvieron físicamente en Castillo o en CamaraTesoro.

**Objetivo:** Localizar todos los eventos registrados en las zonas Castillo y CamaraTesoro durante la franja relevante.

---

### Preguntas a resolver:

1. **¿Quiénes estuvieron en el castillo entre las 22:10 y las 22:20?**
   - P003, P004, P005, P007, P011

2. **¿Quién fue el único jugador que registró una entrada a la CamaraTesoro?**
   - P007

3. **¿Tu consulta en PartiQL se ejecutó como Query o como Scan? Explica por qué según el diseño de claves.**
   - Como Scan. Para ser Query tendría que filtrar por el jugadorId. Como filtro por zona, que no está indexada, DynamoDB tiene que revisar toda la tabla.

---

### Consulta PartiQL

SELECT fechaHora, jugadorId, nombre, evento, zona, objeto
FROM EscapeRoomMinecraft
WHERE (zona = 'Castillo' OR zona = 'CamaraTesoro')
AND fechaHora BETWEEN '2026-11-02T22:10:00' AND '2026-11-02T22:20:00';

---

### Tabla

| Hora                | Jugador ID | Evento           | Zona         | Objeto       |
| ------------------- | ---------- | ---------------- | ------------ | ------------ |
| 2026-11-02T22:10:00 | P003       | OBSERVAR_PUERTA  | Castillo     | -            |
| 2026-11-02T22:10:45 | P005       | ABRIR_COFRE      | Castillo     | ESPADA_ACERO |
| 2026-11-02T22:10:46 | P004       | ABRIR_COFRE      | Castillo     | PICO_HIERRO  |
| 2026-11-02T22:11:10 | P005       | ABRIR_COFRE      | Castillo     | DIAMANTE     |
| 2026-11-02T22:14:00 | P011       | INCIDENCIA_RED   | Castillo     | -            |
| 2026-11-02T22:14:05 | P003       | TIMEOUT_CONEXION | Castillo     | -            |
| 2026-11-02T22:14:10 | P007       | ENTRAR_ZONA      | CamaraTesoro | -            |
| 2026-11-02T22:14:51 | P004       | ABRIR_COFRE      | Castillo     | ESPADA_ACERO |
| 2026-11-02T22:15:02 | P007       | ABRIR_COFRE      | CamaraTesoro | ESPADA_OMEGA |
| 2026-11-02T22:15:18 | P007       | RETIRAR_OBJETO   | CamaraTesoro | ESPADA_OMEGA |
| 2026-11-02T22:16:10 | P007       | SALIR_ZONA       | Castillo     | -            |
| 2026-11-02T22:18:47 | P004       | VISITAR_ZONA     | Castillo     | -            |
