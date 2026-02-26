# Guía de Desarrollo

Esta guía te ayudará a entender la estructura del proyecto y cómo agregar nuevas funcionalidades.

## Estructura de Carpetas

```
lib/
├── config/              # Configuración global
│   └── api_config.dart          # API keys y endpoints
├── models/              # Modelos de datos
│   └── article.dart             # Modelo de Article
├── providers/           # Gestión de estado (Provider)
│   └── news_provider.dart       # Estado de noticias
├── screens/             # Pantallas de la UI
│   ├── news_list_screen.dart    # Listado principal
│   └── article_detail_screen.dart # Detalle de noticia
├── services/            # Servicios (HTTP, etc.)
│   └── news_service.dart        # Llamadas a la API
└── main.dart            # Punto de entrada
```

## Agregar una Nueva Categoría

1. Abre `lib/config/api_config.dart`
2. Agrega la categoría a la lista `categories`:

```dart
static const List<String> categories = [
  'general',
  'business',
  'entertainment',
  'health',
  'science',
  'sports',
  'technology',
  'mi_nueva_categoria',  // Agregar aquí
];
```

3. Agrega la traducción en `_translateCategory()` en ambas pantallas

## Agregar una Nueva Pantalla

1. Crea un nuevo archivo en `lib/screens/`:

```dart
import 'package:flutter/material.dart';

class MyNewScreen extends StatefulWidget {
  const MyNewScreen({Key? key}) : super(key: key);

  @override
  State<MyNewScreen> createState() => _MyNewScreenState();
}

class _MyNewScreenState extends State<MyNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Nueva Pantalla'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Contenido aquí'),
          ],
        ),
      ),
    );
  }
}
```

2. Navega a la pantalla desde otra pantalla:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const MyNewScreen()),
);
```

## Agregar Nuevos Servicios

1. Crea un nuevo archivo en `lib/services/`, por ejemplo `lib/services/my_service.dart`:

```dart
import 'package:http/http.dart' as http;

class MyService {
  Future<dynamic> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://api.example.com/data'));
      
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
```

## Usar Provider para Estado Global

1. Crea un nuevo Provider en `lib/providers/`:

```dart
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  String _data = '';
  
  String get data => _data;
  
  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }
}
```

2. Agrega el Provider a `main.dart`:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => NewsProvider()),
    ChangeNotifierProvider(create: (_) => MyProvider()),  // Agregar aquí
  ],
  child: MaterialApp(...),
)
```

3. Usa el Provider en tu pantalla:

```dart
Consumer<MyProvider>(
  builder: (context, myProvider, child) {
    return Text(myProvider.data);
  },
)
```

## Agregar Dependencias

1. Agrega la dependencia a `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  mi_nueva_dependencia: ^1.0.0
```

2. Ejecuta:

```bash
flutter pub get
```

3. En vscode, los cambios se aplican automáticamente. En otros editores, recarga el proyecto.

## Formateo de Código

Asegúrate de que tu código siga los estándares de Flutter:

```bash
# Analizar el código
flutter analyze

# Formatear el código automáticamente
flutter format lib/
```

## Testing (Opcional)

Crea archivos de test en `test/`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:app_news_flutter/models/article.dart';

void main() {
  test('Article fromJson test', () {
    final json = {
      'title': 'Test Title',
      'description': 'Test Description',
      'urlToImage': 'https://example.com/image.jpg',
      'url': 'https://example.com/article',
      'publishedAt': '2024-01-01T00:00:00Z',
      'source': {'name': 'Test Source'},
    };

    final article = Article.fromJson(json, 'test');
    expect(article.title, 'Test Title');
  });
}
```

Ejecuta los tests:

```bash
flutter test
```

## Estilo y Diseño

El proyecto usa Material Design 3. Para mantener consistencia:

1. Usa `Theme.of(context)` para colores y estilos
2. Usa constantes de padding: `const SizedBox(height: 16)`
3. Usa `BorderRadius.circular()` para bordes redondeados
4. Mantén la paleta de colores consistente

## Buenas Prácticas

1. **Evita AntiPatterns**
   - No hagas llamadas HTTP en `build()`
   - No modifiques estado sin notifyListeners()
   - No ignores los warnings del analyzer

2. **Rendimiento**
   - Usa `const` en widgets cuando sea posible
   - Usa `ListView.builder()` para listas grandes
   - Cachea datos cuando sea apropiado

3. **Seguridad**
   - No expongas API keys en código
   - Valida entrada de usuario
   - Usa HTTPS para todas las llamadas API

4. **Accesibilidad**
   - Proporciona descripciones semanticsLabel en iconos
   - Usa tamaños de fuente legibles
   - Asegúrate de que los colores contrastan bien

## Recursos Útiles

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Provider Package](https://pub.dev/packages/provider)
- [Material Design Guidelines](https://material.io/design)
