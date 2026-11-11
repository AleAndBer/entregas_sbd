# Informe Pericial de Investigación Forense · Caso 07-OMEGA

- **Estudiante / Analista:** Alejandro Andres Bermejo
- **Fecha de emisión:** 10/11/2026
- **Caso:** Sustracción de la Espada Omega en ÁgoraCraft
- **Fuente de auditoría:** Tabla EscapeRoomMinecraft (Amazon DynamoDB, región us-east-1)

---

## 1. Dictamen pericial

> Resume las conclusiones de tu investigación (máximo 120 palabras), identificando quién cometió el robo, cuándo ocurrió, cómo aprovechó el fallo del servidor y cuál fue el destino final del objeto.

A las 22:14:00 hubo un tirón de lag en el castillo. Justo ahí, LunaByte se cayó por timeout (22:14:05), dejando la puerta sin nadie vigilando. CreeperKing (P007) aprovechó el momento para colarse en la Cámara del Tesoro (22:14:10), abrir el cofre y llevarse la Espada Omega a las 22:15:18. Después se fue al Bosque Oscuro y le pasó la espada a su ayudante ShadowPixel (P009) a las 22:17:40, que la llevó a la Mina Abandonada a las 22:20:10. Los dos se ayudaron para hacer el robo.

---

## 2. Cronología forense probada

Registra al menos 5 eventos clave demostrados fehacientemente con consultas a DynamoDB (incluye marcas de tiempo ISO exactas al segundo):

| Hora exacta (ISO)   | ID Cuenta | Alias       | Acción / Evento   | Zona           | Objeto y detalles clave                                                 |
| ------------------- | --------- | ----------- | ----------------- | -------------- | ----------------------------------------------------------------------- |
| 2026-11-02T22:09:00 | P011      | AdminSol    | DEPOSITAR_OBJETO  | CamaraTesoro   | Guarda la ESPADA_OMEGA en el cofre                                      |
| 2026-11-02T22:14:00 | P011      | AdminSol    | INCIDENCIA_RED    | Castillo       | El servidor registra PICO_LATENCIA_SERVIDOR y tienen lag en el castillo |
| 2026-11-02T22:15:18 | P007      | CreeperKing | RETIRAR_OBJETO    | CamaraTesoro   | Abre el cofre y se lleva la ESPADA_OMEGA                                |
| 2026-11-02T22:17:40 | P007      | CreeperKing | TRANSFERIR_OBJETO | BosqueOscuro   | Le da la ESPADA_OMEGA a P009 en el bosque                               |
| 2026-11-02T22:20:10 | P009      | ShadowPixel | OCULTAR_OBJETO    | MinaAbandonada | Esconde la ESPADA_OMEGA en la mina para que nadie la encuentre          |
| 2026-11-02T22:25:00 | P011      | AdminSol    | DENUNCIAR_ROBO    | CamaraTesoro   | Encuentra el cofre vacío de la ESPADA_OMEGA y activa la alarma general  |

---

## 3. Identificación de responsabilidades

- **Autor material del robo:** CreeperKing - P007
- **Cómplice y receptador:** ShadowPixel - P009
- **Momento exacto del robo físico:** 22:15:18
- **Momento oficial de denuncia y alarma:** 22:25:00
- **Última ubicación conocida del objeto:** MinaAbandonada

---

## 4. Distinción forense: Hechos observados vs. Inferencias

- **Hecho probado (con evidencia en registros):**  
  A las 22:15:18, P007 sacó la ESPADA_OMEGA del cofre de la Cámara del Tesoro (RETIRAR_OBJETO) y a las 22:17:40 se la dió en el Bosque Oscuro a P009, que la cogió 4 segundos después (22:17:44).

- **Inferencia lógica razonable:**  
  Aunque en el servidor solo aparecen los registros del pico de lag a las 22:14:00, se ve que P007 estaba esperando una distracción, ya que tardó solo 5 segundos en entrar a la cámara en cuanto vio que LunaByte se cayó por lag.

- **Limitación técnica del dato:**  
  Que P007 y P009 compartan la misma IP (198.51.100.77) no demuestra por sí solo que sean la misma persona. Varias personas distintas pueden salir por la misma IP pública si están conectadas a la misma Wi-Fi, usan una VPN o si su operadora usa CGNAT. La prueba de que se ayudaron es que se pasaron la espada.

---

## 5. Análisis de eficiencia y Big Data en DynamoDB

1. **Operación de tipo Scan:**
   - ¿Qué consulta de tu investigación fue un Scan?
   - _Consulta PartiQL:_

SELECT \* FROM EscapeRoomMinecraft
WHERE (zona = 'Castillo' OR zona = 'CamaraTesoro')
AND fechaHora BETWEEN '2026-11-02T22:10:00' AND '2026-11-02T22:20:00';

- ¿Por qué el motor ejecutó un Scan y qué impacto tendría este patrón en una tabla con 500 millones de registros?
  - Porque filtré por la zona en vez de por el jugadorId. Como la zona no es una clave ni tiene índice, DynamoDB no sabe dónde buscar y tiene que revisar la tabla entera de arriba a abajo. Si la tabla tuviera 500 millones de registros, esto sería muy lento: gastaría muchos recursos y mi consulta tardaría bastante en responder y no en milisegundos.

2. **Operación sobre Global Secondary Index (GSI):**
   - ¿Qué consulta utilizó el índice PorObjeto?
   - _Consulta PartiQL:_

SELECT \* FROM EscapeRoomMinecraft.PorObjeto
WHERE objeto = 'ESPADA_OMEGA';

- ¿Qué ventaja técnica aportó la proyección ALL frente a consultar la tabla base?
  - Al usar el índice PorObjeto, la base de datos va directa a los registros de la espada en milisegundos. Y gracias a ALL, el propio índice ya tiene todos los datos del evento, así que me devuelve toda la información sin tener que hacer una segunda consulta a la tabla original.
