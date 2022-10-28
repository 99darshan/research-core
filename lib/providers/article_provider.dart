
import 'package:flutter/material.dart';

import '../models/article.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> articles = <Article>[];
}