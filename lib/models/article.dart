class Article {
  final int? id;
  final List<String>? authors;
  final String? title;
  final Language? language;
  final int? year;
  final String? doi;
  final String? downloadUrl;
  final String? description;
  final String? publisher;
  bool isFavorite;

  Article({
    this.id,
    this.authors,
    this.title,
    this.language,
    this.description,
    this.year,
    this.doi,
    this.downloadUrl,
    this.publisher,
    this.isFavorite = false,
  });

  factory Article.fromJson(Map<String, dynamic> parsedJson) {
    return Article(
      id: parsedJson['id'],
      authors: (parsedJson['authors'] as List).map((author) => author['name'] as String).toList(),
      title: parsedJson['title'],
      year: parsedJson['yearPublished'],
      doi: parsedJson['doi'],
      description: parsedJson['description'],
      downloadUrl: parsedJson['downloadUrl'],
      publisher: parsedJson['publisher'],
      language: parsedJson['language'] != null
          ? Language.fromJson(parsedJson['language'])
          : null,
      // api call won't have isFavorite key so every article on api call favorite is set to false
      // when deserializing json from favorites json file stored in local storage, use the value from the isFavorite key
      isFavorite: parsedJson['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authors': authors,
      'title': title,
      'year': year,
      'doi': doi,
      'description': description,
      'downloadUrl': downloadUrl,
      'language': language?.toJson(),
      'isFavorite': isFavorite,
      'publisher': publisher
    };
  }
}

class Language {
  final String? code;
  final String? name;

  Language({this.code, this.name});

  factory Language.fromJson(Map<String, dynamic> parsedJson) {
    return Language(code: parsedJson['code'], name: parsedJson['name']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name};
  }
}