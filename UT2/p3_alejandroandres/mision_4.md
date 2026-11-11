# Misión 4 · El rastro de la Espada Omega

**Contexto:** La espada no desapareció por arte de magia: alguien debió sacarla del castillo, transportarla y depositarla en algún lugar del mapa.

**Objetivo:** Rastrear el ciclo de vida completo de la ESPADA_OMEGA utilizando el índice secundario global PorObjeto.

---

### Preguntas a resolver:

1. **¿Cuántos eventos en total hacen referencia a ESPADA_OMEGA?**
   - 7

2. **¿Quién la depositó inicialmente en el cofre y a qué hora?**
   - P011 a las 22:09:00

3. **¿A quién se la transfirió el ladrón material y en qué zona se produjo el intercambio?**
   - P007 a P009 en el BosqueOscuro

4. **¿Dónde fue ocultada finalmente la espada y por quién?**
   - P009 en la MinaAbandonada

---

### Consulta PartiQL

SELECT fechaHora, jugadorId, nombre, evento, zona, objeto, remitente, destinatario
FROM EscapeRoomMinecraft.PorObjeto
WHERE objeto = 'ESPADA_OMEGA';

---

### Tabla

| Hora                | Jugador Responsable | Acción            | Zona           | Participante Secundario |
| ------------------- | ------------------- | ----------------- | -------------- | ----------------------- |
| 2026-11-02T22:09:00 | P011                | DEPOSITAR_OBJETO  | CamaraTesoro   | -                       |
| 2026-11-02T22:15:02 | P007                | ABRIR_COFRE       | CamaraTesoro   | -                       |
| 2026-11-02T22:15:18 | P007                | RETIRAR_OBJETO    | CamaraTesoro   | -                       |
| 2026-11-02T22:17:40 | P007                | TRANSFERIR_OBJETO | BosqueOscuro   | P009 (Destinatario)     |
| 2026-11-02T22:17:44 | P009                | RECIBIR_OBJETO    | BosqueOscuro   | P007 (Remitente)        |
| 2026-11-02T22:20:10 | P009                | OCULTAR_OBJETO    | MinaAbandonada | -                       |
| 2026-11-02T22:25:00 | P011                | DENUNCIAR_ROBO    | CamaraTesoro   | -                       |
