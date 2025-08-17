import '../../models/Item/Item.dart';

abstract class DalilyState {}

class DalilyInitialState extends DalilyState {}

class DalilyBottomnavBarState extends DalilyState {}

class UpdateRatingState extends DalilyState {
  final double rating;
  final int ratingCount;

  UpdateRatingState(this.rating, this.ratingCount);
}

class UpdateFavoriteState extends DalilyState {
  final bool isFavorite;
  UpdateFavoriteState(this.isFavorite);
}

class DalilyLoadedState extends DalilyState {
  final List<Map<String, String>> data; // البيانات التي يتم تحميلها

  DalilyLoadedState(this.data);
}

class CategoryLoadingState extends DalilyState {}

class CategoryLoaded extends DalilyState {
  final List<Category> categories;

  CategoryLoaded(this.categories);
}

class CategoryError extends DalilyState {
  final String message;

  CategoryError(this.message);
}
class DalilyChangeIndexState extends DalilyState {}
class AppChangeTabState extends DalilyState {}