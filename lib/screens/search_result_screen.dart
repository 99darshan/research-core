import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:researchcore/components/full_screen_info.dart';
import 'package:researchcore/models/core_api_response.dart';
import 'package:researchcore/services/http/core_api_client.dart';

import '../components/article_card.dart';
import '../models/article.dart';
import '../providers/favorites_provider.dart';

class SearchResultScreen extends StatefulWidget {
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
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  int _offset = 0;

  _pagination(BuildContext context, String totalHits) {
    if (totalHits.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Text(
            'Showing ${_offset + 1} - ${_offset + CoreApiClient.limit} of $totalHits',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            width: 24.0,
          ),
          IconButton(
            iconSize: 32.0,
            onPressed: () {
              setState(() {
                _offset -= CoreApiClient.limit;
              });
            },
            icon: const Icon(Icons.arrow_circle_left_outlined),
          ),
          const SizedBox(
            width: 8.0,
          ),
          IconButton(
            iconSize: 32.0,
            onPressed: () {
              setState(() {
                _offset += CoreApiClient.limit;
              });
            },
            icon: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: FutureBuilder<CoreApiResponse>(
        future: CoreApiClient.fetchArticles(widget.searchText,
            minYear: widget.minYear, maxYear: widget.maxYear, offset: _offset),
        // future: CoreApiClient
        //     .sendMockRequest(), // NOTE: use this for local development
        builder:
            (BuildContext context, AsyncSnapshot<CoreApiResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              // TODO: Probably a button to re-fetch??
              return const FullScreenInfo(
                  iconName: Icons.error_outline_rounded,
                  title: 'Error! Please Try Again.',
                  subTitle: '');
            } else {
              final articles = snapshot.data?.articles ?? [];
              if (articles.isEmpty) {
                // TODO: provide a button to go to home to search again
                return FullScreenInfo(
                    iconName: Icons.hourglass_empty,
                    title: 'No Articles Found for ${widget.searchText}!',
                    subTitle: 'Please Try With a Different Keyword.');
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _pagination(
                        context, '${snapshot.data?.totalHits?.toString()}'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          Article? article = articles[index];
                          final favoritesProvider =
                              Provider.of<FavoritesProvider>(context);

                          final isBookmarked =
                              favoritesProvider.favoriteArticles?.any((item) =>
                                  item ==
                                  favoritesProvider.buildKey(id: article.id));

                          if (isBookmarked ?? false) {
                            article.isFavorite = true;
                          }

                          return ArticleCard(article: article);
                        },
                      ),
                    ),
                  ],
                );
              }
            }
          }
        },
      ),
    );
  }
}
