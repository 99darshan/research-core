import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/article.dart';

class FavoritesProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  static const _keyPrefix = 'RESEARCH_CORE';

  Set<String>? _favoriteArticles;
  Set<String>? get favoriteArticles => _favoriteArticles;

  FavoritesProvider() {
    _getSharedPrefInstance();
    _initFavoritesFromSharedPref();
  }

  _getSharedPrefInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }

  _initFavoritesFromSharedPref() async {
    SharedPreferences prefs = await _getSharedPrefInstance();
    _favoriteArticles = prefs.getKeys();

    notifyListeners();
  }

  addFavoriteArticle(Article article) async {
    SharedPreferences pref = await _getSharedPrefInstance();
    String key = buildKey(id: article.id);
    if (pref.containsKey(key)) return;
    pref.setString(key, json.encode(article));

    article.isFavorite = true;
    favoriteArticles?.add(key);
    notifyListeners();
  }

  deleteFavoriteArticle(Article article) async {
    SharedPreferences pref = await _getSharedPrefInstance();
    String key = buildKey(id: article.id);
    if (pref.containsKey(key)) {
      pref.remove(key);
    }

    article.isFavorite = false;
    favoriteArticles?.remove(key);
    notifyListeners();
  }

  Article findArticleByKey(String key) {
    String articleStr = _prefs?.getString(key) ?? '';
    return Article.fromJson(json.decode(articleStr));
  }

  String buildKey({id = 0}) {
    return '${_keyPrefix}_${id.toString()}';
  }
}
