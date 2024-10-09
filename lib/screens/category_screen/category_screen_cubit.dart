import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_hub/repository/repository.dart';

import '../../model/api/api.dart';

part 'category_screen_state.dart';

class CategoryScreenCubit extends Cubit<CategoryScreenState> {
  final SearchRepository _searchRepository;

  CategoryScreenCubit(this._searchRepository) : super(CategoryScreenInitial());

  /// fetch wallpapers
  Future<void> getPhotos(String query) async {
    try {
      emit(LoadingCategoryView());
      final ImageModel imageData =
          await _searchRepository.getSearchedWallpapers(query);
      debugPrint(' cubit log   >>>>> $imageData');
      if (imageData.photos!.isEmpty) {
        emit(NoCategoryView());
      } else {
        emit(ReceivedCategoryView(imageData));
      }
    } catch (e) {
      emit(ErrorCategoryView("Error loading photos: ${e.toString()}"));
    }
  }
}
