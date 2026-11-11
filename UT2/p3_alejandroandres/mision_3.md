# Misión 3 · Los minutos del lag

**Contexto:** El cómic y el expediente señalan que a las 22:14 hubo un fallo de conexión. ¿Existe evidencia técnica real de ese incidente o fue una coartada inventada?

**Objetivo:** Reconstruir segundo a segundo los eventos registrados entre las 22:14:00 y las 22:16:15.

---

### Preguntas a resolver:

1. **¿Qué registros técnicos confirman el fallo de conexión a las 22:14? ¿Quién sufrió una desconexión por timeout?**
   - A las 22:14:00, P011 tiene una INCIDENCIA_RED en el Castillo por un PICO_LATENCIA_SERVIDOR. 5 segundos después (22:14:05), P003 tiene una caída por TIMEOUT_CONEXION mientras vigilaba el Castillo.
   - A las 22:14:08, P005 también tiene problemas y tiene que reconectarse (RECONECTAR) desde el Spawn.

2. **¿Qué jugador aprovechó exactamente los segundos de confusión del lag para entrar en la Cámara del Tesoro?**
   - P007

3. **¿A qué segundo exacto se abrió el cofre y a qué segundo se retiró la Espada Omega?**
   - El cofre se abrió a las 22:15:02 (ABRIR_COFRE por P007).
   - La Espada Omega fue retirada a las 22:15:18 (RETIRAR_OBJETO por P007), cometiendo el robo.

---

### Consulta PartiQL

SELECT fechaHora, jugadorId, nombre, evento, zona, objeto, detalle
FROM EscapeRoomMinecraft
WHERE fechaHora BETWEEN '2026-11-02T22:14:00' AND '2026-11-02T22:16:15';

---

### Tabla

| Hora                | Jugador ID | Evento           | Zona           | Objeto                 | Qué pasó realmente                                            |
| ------------------- | ---------- | ---------------- | -------------- | ---------------------- | ------------------------------------------------------------- |
| 2026-11-02T22:14:00 | P011       | INCIDENCIA_RED   | Castillo       | PICO_LATENCIA_SERVIDOR | Empieza el lagazo general en la zona del castillo.            |
| 2026-11-02T22:14:05 | P003       | TIMEOUT_CONEXION | Castillo       | -                      | La persona que vigilaba la puerta se cae del servidor.        |
| 2026-11-02T22:14:08 | P005       | RECONECTAR       | Spawn          | -                      | Otro jugador afectado por el lag reaparece en Spawn.          |
| 2026-11-02T22:14:09 | P005       | RECOGER_OBJETO   | BosqueOscuro   | MANZANA_DORADA         | Jugador normal haciendo cosas por el mapa.                    |
| 2026-11-02T22:14:10 | P007       | ENTRAR_ZONA      | CamaraTesoro   | -                      | Se cuela a la cámara aprovechando que no hay nadie vigilando. |
| 2026-11-02T22:14:41 | P003       | FABRICAR_OBJETO  | Playa          | PICO_HIERRO            | LunaByte vuelve a entrar pero aparece lejos del castillo.     |
| 2026-11-02T22:14:51 | P004       | ABRIR_COFRE      | Castillo       | ESPADA_ACERO           | Abre un cofre normal en otra parte del castillo.              |
| 2026-11-02T22:14:59 | P005       | CHATEAR          | Montanas       | -                      | Charlando tranquilamente en montañas.                         |
| 2026-11-02T22:15:02 | P007       | ABRIR_COFRE      | CamaraTesoro   | ESPADA_OMEGA           | Abre el cofre acorazado donde estaba la espada.               |
| 2026-11-02T22:15:18 | P007       | RETIRAR_OBJETO   | CamaraTesoro   | ESPADA_OMEGA           | **Roba la Espada Omega.**                                     |
| 2026-11-02T22:15:41 | P003       | COMER            | MinaAbandonada | -                      | Actividad normal.                                             |
| 2026-11-02T22:15:43 | P005       | EXTRAER_MINERAL  | MinaAbandonada | -                      | Minando normalmente.                                          |
| 2026-11-02T22:15:46 | P004       | EXTRAER_MINERAL  | Montanas       | -                      | Minando normalmente.                                          |
| 2026-11-02T22:16:10 | P007       | SALIR_ZONA       | Castillo       | -                      | Escapa del castillo con la espada robada.                     |
