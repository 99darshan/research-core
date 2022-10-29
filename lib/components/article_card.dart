import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:researchcore/providers/favorites_provider.dart';
import 'package:researchcore/screens/pdf_view_screen.dart';
import 'package:researchcore/services/download_service.dart';
import 'package:researchcore/utils/theme_util.dart';

import '../models/article.dart';

class ArticleCard extends StatefulWidget {
  final Article article;
  final bool isFavoriteScreen;
  late final String _pdfUrl;

  ArticleCard({Key? key, required this.article, this.isFavoriteScreen = false})
      : super(key: key) {
    _pdfUrl = article.extractPdfUrl();
  }

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  IconData _downloadIcon = Icons.cloud_download_outlined;
  bool _isDownloading = false;

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
      isSelected: true,
    );
  }

  Widget _downloadButton() {
    if (widget._pdfUrl.isEmpty) {
      return const SizedBox();
    }

    if (_isDownloading) {
      return const SizedBox(
        height: 30.0,
        width: 30.0,
        child: CircularProgressIndicator(),
      );
    } else {
      return _iconButton(_downloadIcon, () {
        _showSnackBar(
            '🎬 ⏳ Download Started! \n \n It may take some time depending on the file size. ⏳');

        setState(() {
          _isDownloading = true;
        });

        DownloadService.download(
          widget._pdfUrl,
          widget.article.title!,
          onComplete: (val) {
            setState(() {
              _isDownloading = false;
              _downloadIcon = Icons.cloud_done_outlined;
            });

            _showSnackBar(
                '🎉 File Downloaded Successfully 🎉 \n \n View File on Downloads Tab.');
          },
          onError: (err) {
            setState(() {
              _isDownloading = false;
            });

            _showSnackBar('😭 Error Downloading File. 😭 Please Try Again!');
          },
        );
      });
    }
  }

  _showSnackBar(String title) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
      duration: const Duration(seconds: 2),
    ));
  }

  Widget _ctaButtonsRow(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        widget.isFavoriteScreen
            ? _iconButton(Icons.delete, () async {
                favoritesProvider.deleteFavoriteArticle(widget.article);
              })
            : _iconButton(
                widget.article.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border, () async {
                widget.article.isFavorite
                    ? await favoritesProvider
                        .deleteFavoriteArticle(widget.article)
                    : await favoritesProvider
                        .addFavoriteArticle(widget.article);
              }),
        _iconButton(Icons.share, () {}),
        widget._pdfUrl.isNotEmpty
            ? _iconButton(Icons.picture_as_pdf, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PdfViewScreen(
                        pdfUrl: widget._pdfUrl,
                      );
                    },
                  ),
                );
              })
            : const SizedBox(),
        _downloadButton()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('card clicked....');
        // TODO: show article detail screen
        if (widget.article.description?.isNotEmpty ?? false) {
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
                  widget.article.title.toString(),
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
                        widget.article.year?.toString().isNotEmpty ?? false,
                        Icons.calendar_today,
                        '${widget.article.year}'),
                  ),
                  Expanded(
                    flex: 1,
                    child: _infoRow(
                        context,
                        widget.article.language?.name?.isNotEmpty ?? false,
                        Icons.language,
                        '${widget.article.language?.name}'),
                  ),
                ],
              ),
              // Authors Row
              _infoRow(context, (widget.article.authors ?? []).isNotEmpty,
                  Icons.people, '${widget.article.authors?.join(', ')}'),
              _infoRow(context, widget.article.publisher?.isNotEmpty ?? false,
                  Icons.book, '${widget.article.publisher}'),
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
