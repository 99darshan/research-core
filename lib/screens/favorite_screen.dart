import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:researchcore/components/full_screen_info.dart';

import '../components/article_card.dart';
import '../models/article.dart';
import '../providers/favorites_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favouriteKeys = favoritesProvider.favoriteArticles;

    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: (favouriteKeys?.isEmpty ?? true)
          ? const FullScreenInfo(
              iconName: Icons.favorite_border_outlined,
              title: 'Empty Favorites Folder!',
              subTitle: 'Bookmarked articles will show up here.',
            )
          : ListView.builder(
              itemCount: favouriteKeys?.length ?? 0,
              itemBuilder: (context, index) {
                final articleKey = favouriteKeys?.elementAt(index);
                if (articleKey?.isEmpty ?? true) {
                  return const SizedBox();
                }
                Article article =
                    favoritesProvider.findArticleByKey('$articleKey');
                return ArticleCard(
                  article: article,
                  isFavoriteScreen: true,
                );
              },
            ),
    );
  }
}
