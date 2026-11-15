# Habla Fluido – aprende inglés con un tutor de IA

Proyecto del *Manual TDD Habla Fluido* (Flutter + Node + IA + repetición espaciada).
El código de `lib/`, `test/`, `proxy/` y `pubspec.yaml` es el del manual, tal cual.

## 1. Preparar (una sola vez)

El zip NO trae las carpetas de plataforma (android/ios) ni dependencias, para que pese poco.
Dentro de la carpeta `habla_fluido`:

```
flutter create . --project-name habla_fluido
flutter pub get
```

> ⚠️ `flutter create .` agrega un archivo **test/widget_test.dart** que busca `MyApp`
> (no existe en este proyecto) y hace fallar `flutter test`. **Bórralo.**

## 2. Permisos (Paso 1.2 del manual)

`android/app/src/main/AndroidManifest.xml`, dentro de `<manifest>` (antes de `<application>`):

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.INTERNET"/>
<queries>
    <intent>
        <action android:name="android.speech.RecognitionService"/>
    </intent>
    <intent>
        <action android:name="android.intent.action.TTS_SERVICE"/>
    </intent>
</queries>
```

`ios/Runner/Info.plist`, dentro de `<dict>`:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Usamos el micrófono para comprobar tu pronunciación</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Usamos el reconocimiento de voz para comprobar tu pronunciación</string>
```

## 3. Ejecutar

```
flutter test                      # todas las pruebas
flutter run                       # con el tutor simulado (sin internet ni costo)
flutter run --dart-define=TUTOR_URL=https://tu-servidor.com/tutor
```

Proxy:

```
cd proxy
node --test                       # 12 pruebas
export ANTHROPIC_API_KEY=tu_llave # en Windows PowerShell: $env:ANTHROPIC_API_KEY="tu_llave"
node server.js
```

## 4. Rondas TDD y capturas

Ver **GUIA_RONDAS.md**: qué línea comentar en cada ronda para que la prueba falle (ROJO),
cómo regresarla a VERDE y qué capturar.
