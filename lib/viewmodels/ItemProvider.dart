import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Item/Item.dart';

class ItemProvider with ChangeNotifier {
  List<Category> _favorites = [];

  List<Category> get favorites => _favorites;

  ItemProvider() {
    _loadFavorites();
  }
  bool isFavorite(Category category) {
    return _favorites.contains(category);
  }

  void addToFavorites(Category category) async {
    if (!_favorites.contains(category)) {
      _favorites.add(category);
      await _saveFavorites();
      notifyListeners();
    }
  }

  void removeFromFavorites(Category category) async {
    _favorites.remove(category);
    await _saveFavorites();
    notifyListeners();
  }


  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteList =
        _favorites.map((category) => jsonEncode(category.toJson())).toList();
    prefs.setStringList('favorites', favoriteList);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteList = prefs.getStringList('favorites');

    if (favoriteList != null) {
      _favorites = favoriteList
          .map((item) => Category.fromJson(jsonDecode(item)))
          .toList();
    }
  }
}
