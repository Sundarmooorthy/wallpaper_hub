part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

/// for wallpaper data
final class LoadingHomeView extends HomeScreenState {}

final class NoHomeScreenView extends HomeScreenState {}

final class ErrorHomeScreenView extends HomeScreenState {
  final String msg;

  ErrorHomeScreenView(this.msg);
}

final class ReceivedHomeScreenView extends HomeScreenState {
  final ImageModel imageData;

  ReceivedHomeScreenView(this.imageData);
}

/// for category

class CategoryInitial extends HomeScreenState {}

class CategoryLoading extends HomeScreenState {}

class CategoryLoaded extends HomeScreenState {
  final List<CategoryModel> categories;

  CategoryLoaded(this.categories);
}

class CategoryError extends HomeScreenState {
  final String error;

  CategoryError(this.error);
}
