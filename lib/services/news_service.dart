import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_news_flutter/models/article.dart';
import 'package:app_news_flutter/config/api_config.dart';

class NewsService {
  static const String _baseUrl = ApiConfig.baseUrl;
  static const String _apiKey = ApiConfig.apiKey;
  static const String _language = ApiConfig.language;

  Future<List<Article>> getNewsByCategory(String category) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/top-headlines?country=es&category=$category&apiKey=$_apiKey',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Timeout al conectar con la API');
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final articles = json['articles'] as List;
        
        return articles
            .map((article) => Article.fromJson(article, category))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception('API key inválida');
      } else if (response.statusCode == 429) {
        throw Exception('Demasiadas solicitudes. Intenta más tarde');
      } else {
        throw Exception('Error al cargar las noticias: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Article>> searchNews(String query) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/everything?q=$query&language=$_language&sortBy=publishedAt&apiKey=$_apiKey',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Timeout al conectar con la API');
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final articles = json['articles'] as List;
        
        return articles
            .map((article) => Article.fromJson(article, 'búsqueda'))
            .toList();
      } else {
        throw Exception('Error al buscar noticias: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
