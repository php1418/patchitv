# PatchItV - YouTube Android TV APK Patcher

Aplicación para parchear APKs de YouTube para Android TV, compatibles con el sistema de parches de FaroTV.

## Características

- **MicroG-RE support**: Hace que YouTube funcione sin Servicios de Google Play
- **Branding personalizado**: Cambia nombre, ícono y banner de la app
- **Configuración de FaroTV**: Sección de ajustes dentro de YouTube para bloquear anuncios, ocultar Shorts, SponsorBlock, etc.
- **Spoof device**: Hace pasar el TV por un Chromecast para televisores "no compatibles"
- **Clone app**: Permite instalar la misma app múltiples veces con nombres de paquete diferentes

## Requisitos

- APK de YouTube for Android TV (versión 7.32.300 o compatible)
- MicroG-RE instalado en el dispositivo (opcional, pero recomendado)
- Android 7.0+ (minSdk 24)

## Cómo usar

1. Descarga el APK original de YouTube for Android TV
2. Instala PatchItV en tu TV
3. Selecciona el APK para parchear
4. Elige las opciones de parcheo deseadas
5. Firma y instala el APK parcheado

## Estructura del proyecto

- `app/src/main/java/app/patchitv/` - Código fuente principal
- `app/src/main/res/` - Recursos de la aplicación
- `app/build.gradle.kts` - Configuración de Gradle
- `patches/` - Guías y scripts de parcheo

Para compilar, abre este proyecto en Android Studio y ejecuta `./gradlew buildAndroid`.trigger-workflow
