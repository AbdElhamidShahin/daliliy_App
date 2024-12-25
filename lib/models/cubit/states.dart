abstract class DalilyState {}

class DalilyInitialState extends DalilyState {}

class DalilyBottomnavBarState extends DalilyState {}
class UpdateRatingState extends DalilyState {
  final double newRating;

  UpdateRatingState(this.newRating);
}
class DalilySuccessState extends DalilyState {}
class DalilyErrorState extends DalilyState {
  final String errorMessage;

  DalilyErrorState(this.errorMessage);
}
class DalilyLoadingState extends DalilyState {}

class DalilyInitial extends DalilyState {}

class DalilyLoading extends DalilyState {}

class DalilyLoaded extends DalilyState {
  final List<Map<String,String>> data; // البيانات التي يتم تحميلها

  DalilyLoaded(this.data);
}

class DalilyError extends DalilyState {
  final String message;

  DalilyError(this.message);
}
