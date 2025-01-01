import 'package:flutter/foundation.dart';
class Category {
  final String name;
  final String description;
  final String imageUrl;

  Category(
      {required this.name, required this.description, required this.imageUrl});
}

class ItemProvider with ChangeNotifier {
  List<Category> _favorites = [];

  List<Category> get favorites => _favorites;

  void addToFavorites(Category category) {
    if (!_favorites.contains(category)) {
      _favorites.add(category);
      notifyListeners();
      print(category);
    }
  }

  void removeFromFavorites(Category category) {
    _favorites.remove(category);
    notifyListeners();
  }
}
