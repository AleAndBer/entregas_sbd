# Misión 5 · El engaño de la IP y la conspiración

**Contexto:** Una alerta de red señala que dos cuentas conectaron desde la misma IP (198.51.100.77). Alguien propone expulsar a ambas afirmando que pertenecen al mismo jugador. ¿Es una prueba concluyente?

**Objetivo:** Evaluar la relación entre P007 y P009, distinguiendo señales débiles de pruebas concluyentes de colaboración.

---

### Preguntas a resolver:

1. **¿Qué dos cuentas comparten la dirección IP 198.51.100.77?**
   - P007 y P009.

2. **Desde el punto de vista de redes, ¿por qué compartir una IP pública (ej. CGNAT, Wi-Fi compartida, VPN) no demuestra identidad única?**
   - Varios usuarios pueden compartir la misma IP si usan la misma conexión.

3. **¿Qué eventos dentro del juego prueban de forma irrefutable que ambas cuentas actuaron de forma coordinada?**
   - A las 22:17:40, P007 pasa la espada a P009 en el Bosque Oscuro (destinatario=P009).
   - A las 22:17:44, P009 la recibe (remitente=P007).
   - A las 22:20:10, P009 la esconde en la Mina Abandonada.

---

### Consulta PartiQL

SELECT fechaHora, jugadorId, nombre, evento, zona, objeto, remitente, destinatario, ip
FROM EscapeRoomMinecraft
WHERE jugadorId IN ('P007', 'P009')
AND fechaHora BETWEEN '2026-11-02T22:12:00' AND '2026-11-02T22:21:00';

---

### Tabla

| Pista                                                | Lo que sugiere                                                     | Límite técnico                                                                | Evidencia concluyente que la confirma                                                 |
| ---------------------------------------------------- | ------------------------------------------------------------------ | ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| **Misma IP pública (198.51.100.77)**                 | Que son la misma persona o multicuentas.                           | Pueden compartir Wi-Fi, estar bajo CGNAT de la operadora o usar la misma VPN. | El intercambio directo de la espada registrado en el juego.                           |
| **Inicios de sesión seguidos (22:12:02 y 22:12:45)** | Que se conectaron juntos para coordinar el golpe.                  | Entrar con 40 segundos de diferencia puede ser simple casualidad.             | Que luego se encuentran a solas en el bosque para hacer el relevo.                    |
| **Intercambio en BosqueOscuro a las 22:17**          | Que uno le pasa el botín al otro para despistar a los moderadores. | Ninguna duda: el propio juego registra la entrega y la recepción entre ambos. | Los eventos TRANSFERIR_OBJETO y RECIBIR_OBJETO con remitente y destinatario cruzados. |
| **Ocultación en MinaAbandonada (22:20:10)**          | Que esconden la espada para que nadie la localice.                 | Ninguna duda: queda registrado exactamente quién la escondió y dónde.         | El evento OCULTAR_OBJETO de P009 con la ESPADA_OMEGA.                                 |
