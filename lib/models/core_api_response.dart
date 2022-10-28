import './article.dart';

class CoreApiResponse {
  final int? totalHits;
  final int? limit;
  final int? offset;
  final int? scrollId;
  final List<Article>? articles;

  CoreApiResponse({this.totalHits, this.limit, this.offset, this.scrollId, this.articles});

  factory CoreApiResponse.fromJson(Map<String, dynamic> parsedJson) {
    return CoreApiResponse(
        totalHits: parsedJson['totalHits'],
        limit: parsedJson['limit'],
        offset: parsedJson['offset'],
        scrollId: parsedJson['scrollId'],
        articles: parsedJson['results']
            ?.map((i) => Article.fromJson(i))
            ?.cast<Article>()
            ?.toList()
    );
  }
}
