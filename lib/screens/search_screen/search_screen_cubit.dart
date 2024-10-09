import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_hub/repository/repository.dart';

import '../../model/api/api.dart';

part 'search_screen_state.dart';

class SearchScreenCubit extends Cubit<SearchScreenState> {
  final SearchRepository _searchRepository;

  SearchScreenCubit(this._searchRepository) : super(SearchScreenInitial());

  /// fetch wallpapers
  Future<void> getPhotos(String query) async {
    try {
      emit(LoadingSearchView());
      final ImageModel imageData =
          await _searchRepository.getSearchedWallpapers(query);
      debugPrint(' cubit log   >>>>> $imageData');
      if (imageData.photos!.isEmpty) {
        emit(NoSearchView());
      } else {
        emit(ReceivedSearchView(imageData));
      }
    } catch (e) {
      emit(ErrorSearchView("Error loading photos: ${e.toString()}"));
    }
  }
}
