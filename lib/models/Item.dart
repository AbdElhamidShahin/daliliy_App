import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Category {
  final String name;
  final String description;
  final String imageUrl;

  Category({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}

class ItemProvider with ChangeNotifier {
  List<Category> _favorites = [];

  List<Category> get favorites => _favorites;

  ItemProvider() {
    _loadFavorites();
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
