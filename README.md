# App Noticias Flutter

Aplicación Flutter para mostrar noticias en español utilizando la API de NewsAPI.org.

## Características

✅ **Listado de Noticias**: Visualiza las últimas noticias en español
✅ **Filtro por Categoría**: Filtra noticias por categorías (General, Negocios, Entretenimiento, Salud, Ciencia, Deportes, Tecnología)
✅ **Búsqueda**: Busca noticias por palabras clave
✅ **Vista de Detalle**: Accede a la noticia completa en el navegador
✅ **Información Clara**: Cada noticia muestra título, imagen, extracto, categoría, fecha y fuente
✅ **Interfaz Intuitiva**: Diseño moderno y fácil de usar

## Requisitos Previos

- Flutter SDK (versión 3.0.0 o superior)
- Dart SDK
- Un dispositivo o emulador Android/iOS
- Clave API de NewsAPI.org (ya incluida en el proyecto)

## Instalación

1. Clona el proyecto:
```bash
git clone <url-del-repositorio>
cd app_news_flutter
```

2. Obtén las dependencias:
```bash
flutter pub get
```

3. Ejecuta la aplicación:
```bash
flutter run
```

## Estructura del Proyecto

```
lib/
├── config/
│   └── api_config.dart          # Configuración de la API y categorías
├── models/
│   └── article.dart             # Modelo de datos para artículos
├── providers/
│   └── news_provider.dart       # Gestor de estado con Provider
├── screens/
│   ├── news_list_screen.dart    # Pantalla de listado de noticias
│   └── article_detail_screen.dart # Pantalla de detalle de noticia
├── services/
│   └── news_service.dart        # Servicio para llamadas a la API
└── main.dart                    # Punto de entrada de la aplicación
```

## Dependencias Principales

- **http**: Para realizar peticiones HTTP a la API
- **provider**: Para gestión de estado
- **intl**: Para formateo de fechas en español
- **cached_network_image**: Para cargar y cachear imágenes
- **url_launcher**: Para abrir URLs en el navegador

## Funcionalidades

### Listado de Noticias
- Visualiza las noticias organizadas en tarjetas
- Cada tarjeta muestra:
  - Imagen de la noticia
  - Título
  - Categoría
  - Extracto
  - Fecha de publicación
  - Fuente

### Filtro de Categorías
- Cambia rápidamente entre diferentes categorías
- Las noticias se cargan automáticamente al seleccionar una categoría

### Búsqueda
- Busca noticias por palabras clave
- Los resultados se actualizan en tiempo real

### Vista de Detalle
- Pulsa sobre cualquier noticia para ver los detalles completos
- Accede a la noticia original mediante un botón de enlace
- Navega fácilmente entre el listado y el detalle

## API Utilizada

Esta aplicación utiliza la **API de NewsAPI.org** para obtener noticias en español.

- Endpoint: `https://newsapi.org/v2`
- Documentación: `https://newsapi.org/docs`
- Clave API: Incluida en `lib/config/api_config.dart`

## Notas Importantes

⚠️ La clave API está incluida en el código. Para un proyecto en producción:
1. Mueve la clave a un archivo de configuración no versionado
2. Implementa un backend propio para manejar las llamadas a la API
3. Usa variables de entorno o servicios de gestión de secretos

## Desarrollo

Para realizar cambios en el proyecto:

1. Modifica los archivos en la carpeta `lib/`
2. Usa `flutter pub get` si añades nuevas dependencias
3. Ejecuta `flutter run` para probar los cambios
4. Usa `flutter build` para generar la versión de producción

## Solución de Problemas

### Error "API key inválida"
- Verifica que la clave API sea correcta en `lib/config/api_config.dart`

### Error "Demasiadas solicitudes"
- La API gratuita de NewsAPI tiene límites de solicitudes
- Espera un rato antes de intentar de nuevo

### Las imágenes no se cargan
- Verifica tu conexión a internet
- Algunos artículos pueden no tener imagen

## Autor

Creado con Flutter para mostrar noticias en español.

## Licencia

Este proyecto está disponible bajo la licencia MIT.
