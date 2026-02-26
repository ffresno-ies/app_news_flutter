class Article {
  final String id;
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String source;
  final String category;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.publishedAt,
    required this.source,
    required this.category,
  });

  factory Article.fromJson(Map<String, dynamic> json, String category) {
    return Article(
      id: json['url'] ?? '',
      title: json['title'] ?? 'Sin título',
      description: json['description'] ?? 'Sin descripción',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      source: json['source']['name'] ?? 'Fuente desconocida',
      category: category,
    );
  }
}
