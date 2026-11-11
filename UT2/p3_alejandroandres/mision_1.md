# Misión 1 · Los sospechosos

**Contexto:** Los moderadores afirman que entre las 22:10 y las 22:20 hubo movimientos inusuales cerca del área noble. Averigua qué cuentas tuvieron actividad registrada en esa ventana temporal.

**Objetivo:** Identificar qué cuentas del servidor presentan eventos entre las 22:10:00 y las 22:20:00 y anotar sus alias.

---

### Preguntas a resolver:

1. **¿Cuántas cuentas presentan actividad en esa franja?**
   - P003, P004, P005, P007, P009, P011

2. **¿Qué jugadores quedan descartados al no tener ningún evento en ese intervalo?**
   - P001, P002, P006, P008, P010, P012

3. **¿Estar activo en esa ventana temporal implica culpabilidad? Razona la respuesta.**
   - No. Cada jugador puede estar haciendo diferentes cosas en el servidor, hacen falta pruebas como haber entrado a la cámara o manipulado la espada.

---

### Consulta PartiQL

SELECT jugadorId, nombre
FROM EscapeRoomMinecraft
WHERE fechaHora BETWEEN '2026-11-02T22:10:00' AND '2026-11-02T22:20:00';

---

### Tabla

| ID Cuenta | Alias       | Presencia temporal               |
| --------- | ----------- | -------------------------------- |
| P003      | LunaByte    | Activo en Castillo               |
| P004      | NotchFan    | Activo en Castillo/Montañas      |
| P005      | RedstonePro | Activo en Castillo/Spawn/Mina    |
| P007      | CreeperKing | Activo en Castillo/Cámara/Bosque |
| P009      | ShadowPixel | Activo en Bosque/Mina            |
| P011      | AdminSol    | Activo en Castillo               |
