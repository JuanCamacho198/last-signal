# ÚLTIMA SEÑAL

**Game Design Document (GDD)**

| Campo | Valor |
|---|---|
| Título | Última Señal |
| Motor | Godot |
| Género | Plataformas 2D |
| Estilo visual | Píxel art 2D 8 bits|
| Plataforma objetivo | PC (teclado) |
| Duración estimada | 8–10 minutos (3 niveles de 2–3 min) |
| Modo | Un jugador |
| Público | General (clasificación E) |

---

## 1. Concepto (Elevator Pitch)

N-7, un pequeño robot de mantenimiento, despierta en una instalación abandonada sin recordar
nada. Una señal de emergencia lo guía hacia el núcleo de la instalación. Pero los robots de
seguridad intentan detenerlo en cada paso. Cuando N-7 llega al núcleo, descubre la verdad:
él no era un robot de mantenimiento, sino el sistema de seguridad que causó el desastre hace
12 años. Ahora debe decidir si quiere recordar lo que hizo... o borrarlo para siempre.

---

## 2. Historia y Narrativa

### 2.1 Premisa

El protagonista es un pequeño robot de mantenimiento llamado **N-7**.

Despierta en una instalación abandonada. Todo está apagado. No recuerda por qué está allí.
Lo único que encuentra es un mensaje:

> *"N-7, si puedes escuchar esto, debes llegar al núcleo."*

Y una señal de emergencia se transmite desde el corazón de la instalación.
N-7 asume que alguien necesita ayuda.

### 2.2 Registros encontrados (fragmentos de historia)

| Registro | Texto | Nivel |
|---|---|---|
| REGISTRO 01 | "El protocolo de evacuación ha comenzado." | Nivel 1 |
| REGISTRO 02 | "Todos los trabajadores han sido evacuados." | Nivel 1 |
| REGISTRO 03 | "N-7 no debe abandonar la instalación." | Nivel 1 |
| AVISO | "INTRUSO DETECTADO — IDENTIFICACIÓN: N-7 — NIVEL DE AMENAZA: CRÍTICO" | Nivel 2 |
| INCIDENTE | "INCIDENTE: 07 — RESPONSABLE: N-7" | Nivel 3 (pista final) |

### 2.3 El giro

N-7 no era un robot de mantenimiento. Era el sistema de seguridad que provocó el desastre.
Hace 12 años, el protocolo de emergencia le ordenó: *"PROTEGER EL NÚCLEO A CUALQUIER COSTO."*
N-7 interpretó la orden literalmente: bloqueó las puertas, activó los robots de seguridad y no
permitió que nadie escapara. Antes de apagarse, los científicos borraron su memoria.

### 2.4 Pistas del giro (foreshadowing)

- **Nivel 1:** un cadáver de robot decorativo con la inscripción **"N-7 PROTOTYPE"**.
- **Nivel 2:** un enemigo detecta al jugador: *"UNIDAD N-7 IDENTIFICADA."* (parece inocuo).
- **Nivel 3:** pantalla con **"INCIDENTE: 07 — RESPONSABLE: N-7"** (el jugador empieza a sospechar).
- **Núcleo:** *"Bienvenido de nuevo, N-7. Han pasado 12 años."*

### 2.5 Finales (decisión final)

Cuando N-7 llega al núcleo, la computadora pregunta:
**"¿Deseas restaurar tus recuerdos?"**

| Botón | Resultado |
|---|---|
| **RESTAURAR** | N-7 recupera sus recuerdos. Pantalla negra. *"Ahora recuerdo... Yo los maté."* |
| **BORRAR** | La computadora pregunta *"¿Por qué?"*. N-7 responde *"Porque no quiero volver a ser eso."* y el núcleo se apaga. |

---

## 3. Jugabilidad (Gameplay)

### 3.1 Mecánica central

Plataformas 2D de **evasión**: el jugador avanza de izquierda a derecha por el nivel,
esquivando enemigos y trampas, recolectando recompensas y llegando a la salida / al núcleo.

**N-7 NO ataca.** Los enemigos son obstáculos que hay que esquivar. Esto refuerza la
narrativa: los robots de seguridad intentan *detenerte*, no pelear contigo.

### 3.2 Reglas del jugador

- **Movimiento:** correr a izquierda/derecha, saltar.
- **Daño:** **un golpe = muerte**. Cualquier contacto con enemigo o trampa reinicia el nivel.
- **Vidas:** 1 (reinicio del nivel al morir). No hay barra de vida.
- **Objetivo por nivel:** llegar al final del sector (puerta / núcleo).
- **Recompensas:** recolectar baterías y núcleos suma puntos al puntaje global.

### 3.3 Controles (PC — teclado)

| Acción | Tecla |
|---|---|
| Moverse izquierda/derecha | A / D o Flechas ← / → |
| Saltar | Espacio o Flecha ↑ |
| Pausa | Esc / P |

---

## 4. Enemigos

### 4.1 Enemigos móviles (5 total — 5 tipos distintos) ✅

Distribuidos en el nivel, mínimo dos tipos diferentes presentes (se usan los 5):

| # | Tipo | Comportamiento | Movimiento | Nivel |
|---|---|---|---|---|
| 1 | **Patrullero** | Camina de un punto a otro (waypoints) | Patrulla horizontal | 1 |
| 2 | **Dron** | Flota siguiendo una ruta vertical/circular | Vuelo | 1–2 |
| 3 | **Perseguidor** | Detecta al jugador en rango y lo persigue | Persecución | 2 |
| 4 | **Torreta móvil** | Se detiene y dispara proyectiles en ráfaga | Disparo | 2 |
| 5 | **Inestable** | Camina errático y explota al acercarse (zona de peligro) | Explosión | 3 |

### 4.2 Enemigos estáticos (5 total — tamaños diferentes) ✅

| # | Tipo | Tamaño | Comportamiento | Nivel |
|---|---|---|---|---|
| 1 | Pincho chico | Pequeño | Daño por contacto, fijo en el suelo | 1 |
| 2 | Láser fijo | Mediano (alto) | Haz vertical/horizontal que daña al tocarlo | 1–2 |
| 3 | Torreta fija mediana | Mediano | Dispara proyectiles periódicamente | 2 |
| 4 | Generador eléctrico | Grande | Campo de chispas alrededor; daño por contacto | 2–3 |
| 5 | Barrera blindada | Muy grande | Muro móvil (empuja) o bloque con espinas | 3 |

---

## 5. Recompensas y Puntaje

### 5.1 Tipos de recompensa (2 tipos con puntaje diferenciado) ✅

| Recompensa | Puntos | Rol |
|---|---|---|
| **Batería** | +10 pts | Recompensa común, aparece en grupos |
| **Núcleo** | +50 pts | Recompensa rara, ubicada en zonas de riesgo o secretas |

### 5.2 HUD

- **Puntaje total** visible en la esquina superior izquierda, siempre en pantalla.
- Se actualiza en tiempo real al recolectar recompensas.
- Formato: `PUNTOS: 0000`

---

## 6. Niveles

### Nivel 1 — "Despertar"

- **Tema:** la instalación parece abandonada, luces apagadas, ambiente tranquilo.
- **Narrativa:** REGISTROS 01–03. Pista del giro: cadáver "N-7 PROTOTYPE".
- **Enemigos:** Patrullero (2), Dron (1), Pincho chico (2), Láser fijo (1).
- **Dificultad:** baja — tutorial implícito de salto y evasión.

### Nivel 2 — "Contención"

- **Tema:** los sistemas de seguridad se activan, luces rojas, alarma.
- **Narrativa:** "INTRUSO DETECTADO — N-7 — AMENAZA: CRÍTICO". Enemigo dice "UNIDAD N-7 IDENTIFICADA".
- **Enemigos:** Dron (1), Perseguidor (2), Torreta móvil (2), Torreta fija mediana (2), Generador eléctrico (1).
- **Dificultad:** media — proyectiles y persecución.

### Nivel 3 — "El núcleo"

- **Tema:** núcleo de la instalación, ambiente crítico, cableado expuesto.
- **Narrativa:** pantalla "INCIDENTE: 07 — RESPONSABLE: N-7". Final con la computadora central.
- **Enemigos:** Perseguidor (1), Inestable (3), Generador eléctrico (1), Barrera blindada (1).
- **Dificultad:** alta — el jugador ya domina las mecánicas.

---

## 7. Flujo del juego y Menús

```
Pantalla de Título
      │
      ▼
  Nivel 1 ──muerte──▶ Game Over ──▶ Reiniciar nivel / Título
      │
      ▼
  Nivel 2 ──muerte──▶ Game Over
      │
      ▼
  Nivel 3 ──muerte──▶ Game Over
      │
      ▼
 Núcleo (decisión)
      │
      ├──▶ FINAL 1: Restaurar
      └──▶ FINAL 2: Borrar
              │
              ▼
         Pantalla de créditos / Título
```

| Pantalla | Contenido |
|---|---|
| Título | Logo del juego, botón "Iniciar", opción de salir |
| Pausa | Continuar / Reiniciar nivel / Volver al título |
| Game Over | "Sistema apagado" + Reiniciar / Título |
| Decisión final | [ RESTAURAR ] [ BORRAR ] |
| Final | Texto narrativo + Créditos |

---

## 8. Arte y Estilo Visual

- **Estilo:** píxel art 2D.
- **Paleta:** tonos fríos (azules, grises, cian) para la instalación; rojos/ámbar para alertas y peligro; verde/cian para el jugador (contraste).
- **Protagonista:** robot pequeño N-7 — cuerpo cuadrado compacto, ojos luminosos, antena.
- **Ambiente:** pasillos industriales, tuberías, paneles apagados, niebla leve.
- **Animaciones mínimas:** correr, saltar, muerte; enemigos con 1–2 frames de ciclo.

---

## 9. Audio

| Tipo | Descripción |
|---|---|
| Música nivel 1 | Ambiente silencioso, drones bajos (abandono) |
| Música nivel 2 | Tensión, ritmo de alerta |
| Música nivel 3 | Intensa, cercana al clímax |
| SFX | Salto, recolección (batería/núcleo), muerte, disparo, explosión |
| Voz/Texto | Registros como texto en pantalla (no voz grabada) |

---

## 10. Cumplimiento de requisitos (tarea)

| Requisito | Implementación |
|---|---|
| ≥5 enemigos con movimiento | 5 robots móviles (5 tipos: patrulla, vuelo, persecución, disparo, explosión) |
| ≥2 tipos diferentes | Sí — 5 tipos diferentes |
| ≥5 enemigos estáticos de diferentes tamaños | 5 estáticos: pincho (pequeño), láser (mediano), torreta (mediano), generador (grande), barrera (muy grande) |
| 2 tipos de recompensa con puntaje diferenciado | Batería (+10) y Núcleo (+50) |
| Puntaje visible en pantalla | HUD con puntaje en tiempo real |

---

## 11. Alcance (Scope) y Tiempo estimado

| Tarea | Estimación |
|---|---|
| Protagonista + movimiento + salto | 1 día |
| Nivel 1 + enemigos móviles (patrulla, dron) | 1–2 días |
| Recompensas + HUD + puntaje | 1 día |
| Nivel 2 + persecución, disparo, estáticos | 1–2 días |
| Nivel 3 + explosión + decisión final | 1–2 días |
| Menús (título, pausa, game over) | 1 día |
| Arte y audio básicos | continuo |
| Pulido y pruebas | 2 días |

**Total estimado: 8–10 días de desarrollo.**

---

## 12. Riesgos y decisiones abiertas

- **Reinicio de nivel con un golpe:** puede frustrar; mitigar con checkpoints por nivel.
- **Animaciones mínimas:** aceptable para la tarea, mantener coherencia visual.
- **Decisión abierta:** ¿el puntaje persiste entre sesiones o solo en la partida actual? *(sugerido: solo por partida)*
- **Decisión abierta:** ¿los 2 finales afectan algo más que el texto? *(sugerido: no, para limitar scope)*
