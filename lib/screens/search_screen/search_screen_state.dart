part of 'search_screen_cubit.dart';

@immutable
sealed class SearchScreenState {}

final class SearchScreenInitial extends SearchScreenState {}

final class LoadingSearchView extends SearchScreenState {}

final class NoSearchView extends SearchScreenState {}

final class ErrorSearchView extends SearchScreenState {
  final String msg;

  ErrorSearchView(this.msg);
}

final class ReceivedSearchView extends SearchScreenState {
  final ImageModel imageData;

  ReceivedSearchView(this.imageData);
}
