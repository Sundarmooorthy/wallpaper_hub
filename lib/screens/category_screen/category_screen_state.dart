part of 'category_screen_cubit.dart';

@immutable
sealed class CategoryScreenState {}

final class CategoryScreenInitial extends CategoryScreenState {}

final class LoadingCategoryView extends CategoryScreenState {}

final class NoCategoryView extends CategoryScreenState {}

final class ErrorCategoryView extends CategoryScreenState {
  final String msg;

  ErrorCategoryView(this.msg);
}

final class ReceivedCategoryView extends CategoryScreenState {
  final ImageModel imageData;

  ReceivedCategoryView(this.imageData);
}
