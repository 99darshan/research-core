import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:researchcore/components/article_card.dart';
import 'package:researchcore/models/core_api_response.dart';
import 'package:researchcore/services/http/core_api_client.dart';

import '../models/article.dart';
import '../providers/favorites_provider.dart';

class SearchResultScreen extends StatelessWidget {
  final String searchText;
  final int minYear;
  final int maxYear;

  const SearchResultScreen(
      {Key? key,
      required this.searchText,
      required this.minYear,
      required this.maxYear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: FutureBuilder<CoreApiResponse>(
        // future: CoreApiClient.fetchArticles(
        //   searchText,
        //   minYear: minYear,
        //   maxYear: maxYear,
        // ),
        future: CoreApiClient.sendMockRequest(),
        builder:
            (BuildContext context, AsyncSnapshot<CoreApiResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              // TODO: Probably a button to re-fetch??
              return const Text('Error Occured. Try Again');
            } else {
              final articles = snapshot.data?.articles ?? [];
              if (articles.isEmpty) {
                // TODO: Beautify this component, provide a button to go to home to search again
                return const Text('No Articles Found for the Search Term!');
              } else {
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    Article? article = articles[index];
                    final favoritesProvider =
                        Provider.of<FavoritesProvider>(context);

                    if (favoritesProvider.favoriteArticles?.any((item) =>
                            item ==
                            favoritesProvider.buildKey(id: article.id)) ??
                        false) {
                      article.isFavorite = true;
                    }

                    return ArticleCard(article: article);
                  },
                );
              }
            }
          }
        },
      ),
    );
  }
}
