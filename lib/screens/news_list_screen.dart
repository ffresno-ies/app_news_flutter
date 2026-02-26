import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:app_news_flutter/providers/news_provider.dart';
import 'package:app_news_flutter/config/api_config.dart';
import 'package:app_news_flutter/screens/article_detail_screen.dart';
import 'package:app_news_flutter/widgets/common_widgets.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias en Español'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return Column(
            children: [
              // Barra de búsqueda
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar noticias...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              newsProvider.loadNewsByCategory(
                                newsProvider.selectedCategory,
                              );
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (query) {
                    setState(() {});
                    if (query.isNotEmpty) {
                      newsProvider.searchNews(query);
                    }
                  },
                ),
              ),
              // Filtro de categorías con desplegable
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButton<String>(
                  value: newsProvider.selectedCategory,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: ApiConfig.categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(_translateCategory(category)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _searchController.clear();
                      newsProvider.loadNewsByCategory(newValue);
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Listado de noticias
              Expanded(
                child: newsProvider.isLoading
                    ? const LoadingWidget(message: 'Cargando noticias...')
                    : newsProvider.errorMessage != null
                        ? AppErrorWidget(
                            message: newsProvider.errorMessage ?? 'Error desconocido',
                            onRetry: () {
                              newsProvider.loadNewsByCategory(
                                newsProvider.selectedCategory,
                              );
                            },
                          )
                        : newsProvider.articles.isEmpty
                            ? const EmptyNewsWidget()
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                itemCount: newsProvider.articles.length,
                                itemBuilder: (context, index) {
                                  final article = newsProvider.articles[index];
                                  return _buildArticleCard(context, article);
                                },
                              ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, articleData) {
    final dateFormat =
        DateFormat('dd/MM/yyyy HH:mm', 'es_ES');
    final publishDate = DateTime.parse(articleData.publishedAt);
    final formattedDate = dateFormat.format(publishDate);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ArticleDetailScreen(article: articleData),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: articleData.urlToImage.isEmpty
                    ? Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 48,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Sin imagen',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Image.network(
                        articleData.urlToImage,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.broken_image,
                                    size: 48,
                                    color: Colors.grey[500],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No se pudo cargar',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              // Contenido
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categoría
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _translateCategory(articleData.category),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Título
                    Text(
                      articleData.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    // Descripción
                    Text(
                      articleData.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 12),
                    // Fecha y fuente
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        Text(
                          articleData.source,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _translateCategory(String category) {
    final translations = {
      'general': 'General',
      'business': 'Negocios',
      'entertainment': 'Entretenimiento',
      'health': 'Salud',
      'science': 'Ciencia',
      'sports': 'Deportes',
      'technology': 'Tecnología',
      'búsqueda': 'Búsqueda',
    };
    return translations[category] ?? category;
  }
}
