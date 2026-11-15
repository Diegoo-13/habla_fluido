# Guía de rondas TDD – Habla Fluido (ROJO → VERDE + capturas)

El proyecto viene COMPLETO, por eso todo pasa en verde. Para evidenciar el ciclo TDD
en cada ronda haces esto:

1. **ROJO:** comentas (con `//`) la línea indicada → corres la prueba → FALLA. 📸 Captura.
2. **VERDE:** quitas el `//` → corres la misma prueba → PASA. 📸 Captura.

> En VS Code: pon el cursor en la línea y presiona **Ctrl + /** para comentar/descomentar.
> Corre siempre SOLO la prueba de la ronda (el comando que viene en cada una), así no se
> mezclan otras rondas.

**¿Qué debe salir en cada captura?**
- 📸 ROJO: el código con la línea comentada (pantalla dividida o dos capturas) + la terminal
  con el `✖` / `[E]`, el `Expected: ... Actual: ...` y el mensaje final **"Some tests failed."**
- 📸 VERDE: el código ya sin `//` + la terminal con **"All tests passed!"** (Flutter) o
  `# fail 0` (Node).

> ⚠️ Los números de línea son del zip tal como te lo entregué. Si moviste algo, busca el
> texto con Ctrl+F.

---

## Ronda 0 – Metodología
No tiene código ni pruebas. 📸 Opcional: captura de la tabla de decisiones del manual
o de `lib/dominio/reglas.dart` (donde están las "perillas").

## Ronda 1 – Proyecto y permisos
Sin pruebas. 📸 Captura de:
- `flutter pub get` terminado sin errores.
- `AndroidManifest.xml` con los permisos `RECORD_AUDIO` e `INTERNET` (ver README).
- La estructura de carpetas `lib/dominio`, `lib/datos`, `lib/presentacion`.

---

## Ronda 2 – Comparador

**Comando:**
```
flutter test test/comparador_test.dart
```

| Paso | Qué hacer |
|---|---|
| 🔴 ROJO | En `lib/dominio/comparador.dart`, **línea 43**, comenta: `//    .toLowerCase()` |
| 🟢 VERDE | Quita el `//` |

**Qué falla:** `minúsculas, sin puntuación...` (sale `Don't`, `HAPPY` en mayúsculas),
`idéntico = 100%` y `par mínimo ship/sheep` (la "I" ya no coincide con la "i").

---

## Ronda 3 – Repetición espaciada SM-2

**Comando:**
```
flutter test test/repaso_progreso_test.dart --plain-name "SM-2"
```

| Paso | Qué hacer |
|---|---|
| 🔴 ROJO | En `lib/dominio/repaso.dart`, **línea 31**, comenta: `//      reps = 0;` |
| 🟢 VERDE | Quita el `//` |

**Qué falla:** `secuencia 4, 5, 5, 2`. Al fallar la frase (calidad 2) las repeticiones
deberían volver a 0, pero se quedan en 3 → `Expected: (0, 1)  Actual: (3, 1)`.

---

## Ronda 4 – Progreso (EMA, racha, nivel) y plan diario

Esta ronda tiene DOS partes, haz rojo/verde de cada una.

### 4a. Progreso
```
flutter test test/repaso_progreso_test.dart --plain-name "Progreso"
```
| Paso | Qué hacer |
|---|---|
| 🔴 ROJO | En `lib/dominio/progreso.dart`, **línea 50**, comenta: `//        racha += 1;` |
| 🟢 VERDE | Quita el `//` |

**Qué falla:** `racha: mismo día, día siguiente y día perdido` → `Expected: <2>  Actual: <1>`.

### 4b. Plan diario
```
flutter test test/repaso_progreso_test.dart --plain-name "plan diario"
```
| Paso | Qué hacer |
|---|---|
| 🔴 ROJO | En `lib/dominio/plan_diario.dart`, **línea 43**, comenta: `//    minutos[i]++;` |
| 🟢 VERDE | Quita el `//` |

**Qué falla:** `suma exactamente los minutos pedidos` (da 18 en vez de 20) y
`reparto concreto con escritura débil` (ya no sale `[4, 4, 3, 5, 4]`).

📸 Al final de la ronda 4 corre el archivo completo para ver todo junto en verde:
```
flutter test test/repaso_progreso_test.dart
```

---

## Ronda 5 – Contenido y contrato del tutor (salida de la IA NO confiable)

**Comando:**
```
flutter test test/tutor_test.dart --plain-name "desdeTexto"
```

| Paso | Qué hacer |
|---|---|
| 🔴 ROJO | En `lib/dominio/tutor.dart`, **línea 48**, comenta la línea completa que empieza con `if (orig != null && corr != null ...` |
| 🟢 VERDE | Quita el `//` |

**Qué falla:** `JSON limpio` y `descarta correcciones incompletas y limita a 5`
(no se guarda ninguna corrección → `Expected: <5>  Actual: <0>`).

---

## Ronda 6 – Proxy en Node (la llave nunca va en la app)

**Comando (dentro de la carpeta `proxy`):**
```
cd proxy
node --test
```

| Paso | Qué hacer |
|---|---|
| 🔴 ROJO (1) | En `proxy/prompt.js`, **línea 28**, comenta: `//    '2. Corrige como máximo 2 errores por turno...',` |
| 🔴 ROJO (2) | En `proxy/prompt.js`, **línea 45**, comenta: `//  if (!NIVELES.includes(body.nivel)) return 'nivel inválido';` |
| 🟢 VERDE | Quita los dos `//` |

**Qué falla:** `not ok 1 - prompt: contiene las reglas pedagógicas...` y
`not ok 4 - solicitud: rechaza nivel...`. Al final: `# pass 10  # fail 2`.
En verde: `# tests 12  # pass 12  # fail 0`.

> ⚠️ No comentes líneas de `server.js` para el rojo: si una prueba del servidor falla, el
> servidor de prueba se queda abierto y la terminal se "congela" (sales con Ctrl + C).

---

## Ronda 7 – Tutor simulado y cliente HTTP

### 7a. Tutor simulado
```
flutter test test/tutor_test.dart --plain-name "TutorSimulado"
```
| Paso | Qué hacer |
|---|---|
| 🔴 ROJO | En `lib/datos/tutor_simulado.dart`, **línea 48**, comenta: `//      if (m != null) out.add(Correccion(...));` |
| 🟢 VERDE | Quita el `//` |

**Qué falla:** `corrige "I am agree"`, `he go → he goes` y `máximo 2 correcciones`
(el tutor ya no detecta errores).

### 7b. Cliente HTTP
```
flutter test test/tutor_test.dart --plain-name "TutorHttp"
```
| Paso | Qué hacer |
|---|---|
| 🔴 ROJO | En `lib/datos/tutor_http.dart`, **línea 31**, comenta: `//    if (!seguro && !local) throw ArgumentError('El tutor exige HTTPS');` |
| 🟢 VERDE | Quita el `//` |

**Qué falla:** `exige HTTPS` y `permite http solo a localhost y solo si se autoriza`
(la app aceptaría conexiones inseguras con `http://`).

📸 Final de la ronda: `flutter test test/tutor_test.dart` completo en verde.

---

## Ronda 8 – Voz (texto a voz y reconocimiento)
No tiene archivo de pruebas propio: la `VozSimulada` se prueba dentro de los ViewModels
(ronda 9). 📸 Captura de `lib/datos/voz_real.dart` y `voz_simulada.dart`, y de la app
pidiendo permiso del micrófono cuando la corras en el celular.

---

## Ronda 9 – ViewModels

Haz al menos estos 4 (uno por ejercicio importante):

### 9a. Pronunciación (doble toque)
```
flutter test test/vms_test.dart --plain-name "PronunciacionViewModel"
```
🔴 En `lib/presentacion/vm/pronunciacion_vm.dart`, **línea 29** (dentro de `escucharModelo`),
comenta: `//    if (ocupado) return;`
**Falla:** `doble toque en "Escuchar" se ignora mientras habla` (la voz se llama 2 veces).
🟢 Quita el `//`.

### 9b. Lectura (solo se responde una vez)
```
flutter test test/vms_test.dart --plain-name "LecturaViewModel"
```
🔴 En `lib/presentacion/vm/lectura_vm.dart`, **línea 33**, comenta:
`//    if (respuestas.containsKey(pregunta)) return;`
**Falla:** `puntúa cuando se responden todas, una sola vez` (deja cambiar la respuesta).
🟢 Quita el `//`.

### 9c. Conversación (el tutor falla)
```
flutter test test/vms_test.dart --plain-name "ConversacionViewModel"
```
🔴 En `lib/presentacion/vm/conversacion_vm.dart`, **línea 72**, comenta:
`//      historial.removeLast();`
**Falla:** `si el tutor falla: mensaje genérico, historial sin duplicar roles...`
(el mensaje fallido se queda y el historial queda con 2 mensajes en vez de 1).
🟢 Quita el `//`.

### 9d. Repaso ("otra vez" regresa a la cola)
```
flutter test test/vms_test.dart --plain-name "RepasoViewModel"
```
🔴 En `lib/presentacion/vm/repaso_vm.dart`, **línea 42**, comenta:
`//      if (nueva.isNotEmpty) _cola.add(nueva.first);`
**Falla:** `"otra vez" la vuelve a poner al final de la cola`.
🟢 Quita el `//`.

### (Opcional) 9e. Persistencia
```
flutter test test/vms_test.dart --plain-name "persistencia"
```
🔴 En `lib/presentacion/vm/aprendizaje_vm.dart`, **línea 45** (dentro de `registrarIntento`),
comenta: `//    await _guardar();`
**Falla:** `guarda y recupera progreso y tarjetas`. 🟢 Quita el `//`.

📸 Final: `flutter test test/vms_test.dart` completo en verde.

---

## Ronda 10 – Pantallas y raíz de composición
Sin pruebas unitarias nuevas. 📸 Capturas de la app corriendo (`flutter run`):
inicio (nivel, racha, plan con barras), pronunciación con palabras coloreadas,
dictado, lectura, escritura, conversación ("I am agree" → corrige "I agree") y repaso.

---

## Cierre – Evidencia final (lista de verificación del manual)
```
flutter test
cd proxy
node --test
```
📸 Captura de **"All tests passed!"** (todas las pruebas de Flutter) y de
`# pass 12  # fail 0` del proxy.

---

### Alternativa "rojo de verdad" (como en el manual)
En TDD estricto, el rojo es porque el código **todavía no existe**. Si tu profe lo pide así:
selecciona TODO el archivo de código de la ronda (Ctrl + A) y coméntalo (Ctrl + /),
corre la prueba → falla con errores de compilación (`Method not found`, `Undefined name`…)
→ 📸. Descoméntalo todo → verde → 📸.
Úsalo solo en las rondas 2, 5 y 7 (un archivo de código por prueba); en las rondas 3 y 4
es mejor la línea indicada, porque `repaso_progreso_test.dart` importa los tres archivos.
