import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:researchcore/providers/favorites_provider.dart';
import 'package:researchcore/utils/theme_util.dart';

import '../models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final bool isFavoriteScreen;

  const ArticleCard(
      {Key? key, required this.article, this.isFavoriteScreen = false})
      : super(key: key);

  Widget _infoRow(
      BuildContext context, bool isVisible, IconData iconName, String text) {
    if (isVisible) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(
              iconName,
              size: 24.0,
              color: ThemeUtil.primaryTextColor,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            )
          ],
        ),
      );
    }

    return const SizedBox(height: 0.0, width: 0.0);
  }

  Widget _iconButton(IconData iconName, void Function() onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconName,
        size: 32.0,
        color: ThemeUtil.primaryColor,
      ),
    );
  }

  Widget _ctaButtonsRow(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        isFavoriteScreen
            ? _iconButton(Icons.delete, () async {
                favoritesProvider.deleteFavoriteArticle(article);
              })
            : _iconButton(
                article.isFavorite ? Icons.favorite : Icons.favorite_border,
                () async {
                article.isFavorite
                    ? await favoritesProvider.deleteFavoriteArticle(article)
                    : await favoritesProvider.addFavoriteArticle(article);
              }),
        _iconButton(Icons.share, () {}),
        _iconButton(Icons.picture_as_pdf, () {}),
        _iconButton(Icons.file_download, () {})
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('card clicked....');
        // TODO: show article detail screen
        if (article.description?.isNotEmpty ?? false) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return new ArticleDetailScreen(
          //         article: widget.article,
          //         downloadArticle: this._downloadArticle,
          //       );
          //     },
          //   ),
          // );
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  article.title.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              // Year and Language Row
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _infoRow(
                        context,
                        article.year?.toString().isNotEmpty ?? false,
                        Icons.calendar_today,
                        '${article.year}'),
                  ),
                  Expanded(
                    flex: 1,
                    child: _infoRow(
                        context,
                        article.language?.name?.isNotEmpty ?? false,
                        Icons.language,
                        '${article.language?.name}'),
                  ),
                ],
              ),
              // Authors Row
              _infoRow(context, (article.authors ?? []).isNotEmpty,
                  Icons.people, '${article.authors?.join(', ')}'),
              _infoRow(context, article?.publisher?.isNotEmpty ?? false,
                  Icons.book, '${article.publisher}'),
              const Divider(
                color: Colors.grey,
              ),
              _ctaButtonsRow(context),
            ],
          ),
        ),
      ),
    );
  }
}
