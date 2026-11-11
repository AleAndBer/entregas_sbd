# Misión 6 · Caso cerrado y dictamen forense

**Contexto:** El Administrador de ÁgoraCraft exige el informe pericial definitivo para presentar ante el claustro de moderadores y cerrar el caso.

**Objetivo:** Redactar el informe de conclusiones separando hechos científicamente probados de hipótesis o limitaciones del sistema.

---

### Preguntas a resolver:

1. **¿Quién es el autor material del robo y en qué segundo exacto perpetró la sustracción?**
   - P007 a las 22:15:18.

2. **¿Quién actuó como cómplice y cuál fue su papel en la conspiración?**
   - P009. Recogió la espada en el Bosque Oscuro a las 22:17:44 y fue a esconderla a la Mina Abandonada a las 22:20:10.

3. **¿Cuál es la última ubicación comprobada de la Espada Omega?**
   - MinaAbandonada ocultada por P009 a las 22:20:10.

4. **¿Qué afirmaciones del expediente inicial quedaron desmentidas por los registros?**
   - P003, P004 y P005 no robaron nada.
   - El robo pasó a las 22:15:18, no a las 22:25. A esa hora el Admin solo vió que no estaba.
   - El lag de las 22:14 fue una caída del servidor, no una excusa de los jugadores.

---

### Consulta PartiQL - Comprobación de evidencias clave

SELECT fechaHora, jugadorId, nombre, evento, zona, objeto, detalle, remitente, destinatario
FROM EscapeRoomMinecraft
WHERE (evento IN ('RETIRAR_OBJETO', 'TRANSFERIR_OBJETO', 'RECIBIR_OBJETO', 'OCULTAR_OBJETO') AND objeto = 'ESPADA_OMEGA')
OR (evento = 'INCIDENCIA_RED' AND zona = 'Castillo');
