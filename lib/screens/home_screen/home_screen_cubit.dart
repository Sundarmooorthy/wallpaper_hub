import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_hub/repository/home_repository.dart';
import 'package:wallpaper_hub/utils/utils_method.dart';
import '../../my_app_exports.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final HomeRepository _homeRepository;
  int page = 1;
  int perPage = 20;

  HomeScreenCubit(this._homeRepository) : super(HomeScreenInitial());

  /// fetch category

  Future<void> getCategories() async {
    Future.delayed(const Duration(microseconds: 1500));
    try {
      emit(CategoryLoading());
      // #startRegion
      // before remote config
      String data = await rootBundle.loadString('assets/raw/category.json');
      final jsonResult = json.decode(data);

      List<CategoryModel> categories = (jsonResult as List)
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();
      // #endRegion
      // List<CategoryModel> response = ConfigManager.instance.getCategoryData();
      emit(CategoryLoaded(categories)); // Emit loaded state with categories
    } catch (e) {
      emit(CategoryError("Failed to load categories: ${e.toString()}"));
    }
  }

  /// fetch wallpapers
  Future<void> getPhotos() async {
    try {
      emit(LoadingHomeView());
      final ImageModel imageData =
          await _homeRepository.fetchCuratedWallpapers(page, perPage);
      debugPrint(' cubit log   >>>>> $imageData');
      if (imageData.photos!.isEmpty) {
        emit(NoHomeScreenView());
      } else {
        emit(ReceivedHomeScreenView(imageData));
      }
    } catch (e) {
      emit(ErrorHomeScreenView("Error loading photos: ${e.toString()}"));
    }
  }

  void nextPage() {
    page++;
    getPhotos();
  }

  void previousPage() {
    if (page > 1) {
      page--;
      getPhotos();
    } else {
      // Show SnackBar when trying to go below page 1
      UtilsMethod().showToast('Already in First Page', ToastType.warning);
    }
  }
}
