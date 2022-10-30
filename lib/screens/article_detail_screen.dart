import 'package:flutter/material.dart';
import 'package:researchcore/components/article_card.dart';

import '../models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;
  const ArticleDetailScreen({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${article.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ArticleCard(
              article: article,
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Abstract',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text('${article.abstract}',
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
