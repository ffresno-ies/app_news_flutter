# Guía de Instalación y Configuración

## Requisitos del Sistema

### Windows
- Windows 10 o superior
- 7.5 GB de espacio libre en disco (incluyendo Android Studio)
- Visual Studio 2019 o superior con C++ tools

### macOS
- macOS 10.13 (High Sierra) o superior
- 7.5 GB de espacio libre en disco
- Xcode 11 o superior

### Linux
- Ubuntu 18.04 o superior (Debian/Ubuntu basados)
- 7.5 GB de espacio libre en disco
- GCC, make, curl, git

## Instalación de Flutter

### 1. Descargar Flutter SDK
```bash
# En macOS/Linux
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# En Windows
# Descarga desde: https://flutter.dev/docs/get-started/install
```

### 2. Verificar instalación
```bash
flutter doctor
```

### 3. Instalar dependencias faltantes
Sigue las instrucciones de `flutter doctor` para instalar cualquier dependencia necesaria.

## Configuración del Proyecto

### 1. Clonar el repositorio
```bash
git clone https://github.com/ffresno-ies/app_news_flutter.git
cd app_news_flutter
```

### 2. Obtener dependencias
```bash
flutter pub get
```

### 3. Generar archivos de configuración (si es necesario)
```bash
flutter pub run build_runner build
```

## Ejecución de la Aplicación

### En un emulador Android
```bash
# Listar emuladores disponibles
flutter emulators

# Ejecutar en un emulador específico
flutter emulators launch <emulator-id>

# Ejecutar la app
flutter run
```

### En un dispositivo Android físico
```bash
# Verificar que el dispositivo está conectado
flutter devices

# Ejecutar la app
flutter run
```

### En el navegador (durante desarrollo)
```bash
flutter run -d chrome
```

## Configuración de la API

La clave API de NewsAPI.org está preconfigurada en:
```
lib/config/api_config.dart
```

Para cambiarla:
1. Abre `lib/config/api_config.dart`
2. Reemplaza el valor de `apiKey`
3. Guarda los cambios

## Compilación para Producción

### Android APK
```bash
# Build el APK en modo release
flutter build apk --release

# Build APK dividido por ABI
flutter build apk --release --split-per-abi
```

### Android App Bundle
```bash
# Para distribuir en Google Play Store
flutter build appbundle --release
```

### iOS (solo en macOS)
```bash
# Build para iOS
flutter build ios --release
```

## Variables de Entorno

Si deseas usar variables de entorno para la clave API:

### Opción 1: Usar flutter_dotenv
```bash
flutter pub add flutter_dotenv
```

### Opción 2: Usar platform channels
Para mayor seguridad en producción, considera pasar la API key a través de platform channels desde código nativo.

## Solución de Problemas

### "Flutter command not found"
Asegúrate de que Flutter está en tu PATH:
```bash
export PATH="$PATH:[RUTA-FLUTTER]/flutter/bin"
```

### "Cannot find SDK"
Ejecuta:
```bash
flutter doctor --android-licenses
flutter doctor
```

### Build falla en Android
```bash
flutter clean
flutter pub get
flutter pub run build_runner clean
flutter run
```

### Build falla en iOS (macOS)
```bash
cd ios
rm -rf Pods
rm Podfile.lock
cd ..
flutter clean
flutter pub get
flutter run
```

## Licencias de Dependencias

Para ver las licencias de todas las dependencias:
```bash
flutter pub licenses list
```

## Recursos Adicionales

- [Documentación oficial de Flutter](https://flutter.dev/docs)
- [API de NewsAPI.org](https://newsapi.org/docs)
- [Paquete Provider](https://pub.dev/packages/provider)
- [Material Design 3](https://m3.material.io/)
