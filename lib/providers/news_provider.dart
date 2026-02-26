import 'package:flutter/material.dart';
import 'package:app_news_flutter/models/article.dart';
import 'package:app_news_flutter/services/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();
  
  List<Article> _articles = [];
  String _selectedCategory = 'general';
  bool _isLoading = false;
  String? _errorMessage;

  List<Article> get articles => _articles;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  NewsProvider() {
    loadNewsByCategory('general');
  }

  Future<void> loadNewsByCategory(String category) async {
    _selectedCategory = category;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await _newsService.getNewsByCategory(category);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _articles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) {
      loadNewsByCategory(_selectedCategory);
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await _newsService.searchNews(query);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _articles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
