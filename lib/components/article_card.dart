import 'package:flutter/material.dart';
import 'package:researchcore/utils/theme_util.dart';

import '../models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

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

  Widget _ctaButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: const Icon(
              // TODO:
              // Display the delete icon in favorites screen instead of favorite
              //   widget.screenName == "Favorite"
              //       ? Icons.delete
              //       : (widget.article.isFavorite
              //       ? Icons.favorite
              //       : Icons.favorite_border),
              Icons.favorite,
              size: 32.0,
              color: Colors.red),
          onPressed: () {
            print('favorite clicked...');
          }, // TODO: on favorite or delete pressed handlers
        ),
        IconButton(
            disabledColor: Colors.grey,
            color: Colors.red,
            icon: const Icon(
              Icons.details,
              size: 32.0,
            ),
            onPressed:
                () {} // TODO: details press handler, probably should make entire card clickable
            // onPressed: article.description != null ||
            //     article.description == ''
            //     ? () {
            //   Navigator.push(
            //     context,
            //     new MaterialPageRoute(
            //       builder: (context) {
            //         return new ArticleDetailScreen(
            //           article: widget.article,
            //           downloadArticle: this._downloadArticle,
            //         );
            //       },
            //     ),
            //   );
            // }
            //     : null,
            ),
        IconButton(
          disabledColor: Colors.grey,
          icon: const Icon(Icons.picture_as_pdf, size: 32.0, color: Colors.red),
          onPressed: () {}, // TODO: view PDF handler
          // onPressed: widget.article.downloadUrl != ''
          //     ? () {
          //   articleStore.updateAdDisplayCount();
          //   if (articleStore.adDisplayCount == 3)
          //     _interstitialAd..show();
          //   print('view pdf clicked..');
          //   //var file = await createFileOfPdfUrl(article.downloadUrl);
          //   // setState(() {
          //   //   pdfPath:
          //   //   file.path;
          //   // });
          //   //print(file.path);
          //   print(
          //       'download url: ' + widget.article.downloadUrl);
          //   return Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) =>
          //       //PdfViewScreen(pdfUrl: file.path),
          //       PdfViewScreen(
          //         article: widget.article,
          //         downloadArticle: this._downloadArticle,
          //       ),
          //     ),
          //   );
          // }
          //     : null,
        ),
        IconButton(
          icon: const Icon(Icons.file_download, size: 32.0),
          onPressed: () {}, // TODO: download handler
          // onPressed: article.downloadUrl != ''
          //     ? () {
          //   this._downloadArticle(widget.article);
          // }
          //     : null,
          color: Colors.red,
          disabledColor: Colors.grey,
        ),
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
