# Referencia Rápida

## Comandos Esenciales

### Instalación y Setup
```bash
flutter pub get              # Obtener dependencias
flutter clean                # Limpiar el proyecto
flutter pub outdated         # Ver dependencias desactualizadas
```

### Desarrollo
```bash
flutter run                  # Ejecutar en dispositivo/emulador
flutter run -d chrome        # Ejecutar en navegador
flutter run --release        # Ejecutar en modo release
flutter run --profile        # Ejecutar en modo profile
```

### Análisis y Formato
```bash
flutter analyze              # Analizar código
flutter format lib/          # Formatear código automáticamente
flutter test                 # Ejecutar tests
```

### Build
```bash
flutter build apk            # Crear APK debug
flutter build apk --release  # Crear APK release
flutter build ios --release  # Crear iOS release (solo macOS)
flutter build web            # Crear versión web
```

## Estructura del Proyecto

```
app_news_flutter/
├── lib/
│   ├── config/              - Configuración global (API keys, constantes)
│   ├── models/              - Modelos de datos
│   ├── providers/           - Gestión de estado (Provider)
│   ├── screens/             - Pantallas UI
│   ├── services/            - Servicios API y lógica
│   └── main.dart            - Punto de entrada
├── android/                 - Código nativo Android
├── ios/                     - Código nativo iOS
├── pubspec.yaml             - Dependencias del proyecto
├── analysis_options.yaml    - Configuración de análisis
├── README.md                - Documentación principal
├── INSTALLATION.md          - Guía de instalación
├── DEVELOPMENT.md           - Guía de desarrollo
└── .gitignore              - Archivos ignorados por git
```

## Flujo de la Aplicación

1. **main.dart** - Inicializa la app
2. **NewsListScreen** - Pantalla principal con listado
3. **NewsProvider** - Maneja estado de noticias
4. **NewsService** - Llama a la API
5. **ArticleDetailScreen** - Muestra detalle al hacer tap

## API Key y Configuración

La API key está en: `lib/config/api_config.dart`

Para cambiarla:
1. Abre `lib/config/api_config.dart`
2. Reemplaza el valor de `apiKey`
3. Guarda y ejecuta `flutter run`

## Dependencias Principales

| Paquete | Función |
|---------|---------|
| http | Llamadas HTTP |
| provider | Gestión de estado |
| intl | Formato de fechas |
| cached_network_image | Carga de imágenes |
| url_launcher | Abrir URLs |

## Pantallas y Funciones

### NewsListScreen
- Muestra listado de noticias
- Filtros por categoría
- Búsqueda de noticias
- Navega a detalle al tocar una noticia

### ArticleDetailScreen
- Muestra noticia completa
- Botón para ir a fuente original
- Volver al listado

## Categorías Disponibles

- General
- Negocios
- Entretenimiento
- Salud
- Ciencia
- Deportes
- Tecnología

## Información de Noticia

Cada noticia muestra:
- Imagen
- Título
- Categoría
- Extracto
- Fecha de publicación
- Fuente

## Solución Rápida de Problemas

| Problema | Solución |
|----------|----------|
| Build falla | `flutter clean && flutter pub get` |
| Cambios no se aplican | Recarga caliente: `r` en terminal |
| API key inválida | Verifica en `lib/config/api_config.dart` |
| Error de conexión | Verifica conexión a internet |

## Recursos

- Documentación: [DEVELOPMENT.md](DEVELOPMENT.md)
- Instalación: [INSTALLATION.md](INSTALLATION.md)
- API: https://newsapi.org/docs
- Flutter: https://flutter.dev/docs
