import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/article_card.dart';
import '../models/article.dart';
import '../providers/favorites_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favouriteKeys = favoritesProvider.favoriteArticles;
    // TODO: show proper message when there are no favorites
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: ListView.builder(
        itemCount: favouriteKeys?.length ?? 0,
        itemBuilder: (context, index) {
          final articleKey = favouriteKeys?.elementAt(index);
          if (articleKey?.isEmpty ?? true) {
            return const SizedBox();
          }
          // return const Text('What this shite man');
          Article article = favoritesProvider.findArticleByKey('$articleKey');
          return ArticleCard(
            article: article,
            isFavoriteScreen: true,
          );
        },
      ),
    );
  }
}
