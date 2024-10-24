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
  int maxItems = 8000;

  List<Photos> initialList = [];
  List<Photos> newDataList = [];

  HomeScreenCubit(this._homeRepository) : super(HomeScreenInitial());

  /// fetch category

  Future<void> getCategories() async {
    Future.delayed(const Duration(microseconds: 1500));
    try {
      emit(CategoryLoading());
      // #startRegion
      // before remote config
      // String data = await rootBundle.loadString('assets/raw/category.json');
      // final jsonResult = json.decode(data);

      // List<CategoryModel> categories = (jsonResult as List)
      // .map((categoryJson) => CategoryModel.fromJson(categoryJson))
      // .toList();
      // #endRegion
      List<CategoryModel> categories = await _homeRepository.fetchCategories();
      emit(CategoryLoaded(categories)); // Emit loaded state with categories
    } catch (e) {
      emit(CategoryError("Failed to load categories: ${e.toString()}"));
    }
  }

  /// fetch wallpapers without lazy loading
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

/*
  Future<void> getPhotos({bool isInitialLoad = true}) async {
    try {
      if (isInitialLoad) {
        emit(LoadingHomeView());
      }

      final ImageModel imageData =
          await _homeRepository.fetchCuratedWallpapers(page, perPage);
      debugPrint('Cubit log >>>>> ${imageData.photos}');

      if (imageData.photos == null || imageData.photos!.isEmpty) {
        emit(NoHomeScreenView());
        return;
      }

      if (isInitialLoad) {
        initialList = imageData.photos!;
        emit(ReceivedHomeScreenView(initialList));
      } else {
        newDataList = imageData.photos!;
        initialList.addAll(newDataList);
        emit(ReceivedHomeScreenView(initialList));

        // Stop fetching if received data is less than perPage
        if (newDataList.length < perPage) {
          return;
        }
      }

      page++; // Increment page for the next load
    } catch (e) {
      emit(ErrorHomeScreenView("Error loading photos: ${e.toString()}"));
    }
  }*/

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

  void exitAppDialog(BuildContext context) {
    UtilsMethod().showConfirmationDialog(
      context: context,
      title: "Are you sure want to Exit ?",
      content: '',
      onTapCancel: () {
        Navigator.pop(context);
      },
      onTapConfirm: () {
        SystemNavigator.pop();
      },
    );
  }
}
