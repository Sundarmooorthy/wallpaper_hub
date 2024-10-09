import 'package:dio/dio.dart';
import 'package:wallpaper_hub/network/services/search_services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../my_app_exports.dart';

class SearchRepository {
  late Dio _dio;
  late SearchApiService _searchApiService;
  int perPage = 40;

  SearchRepository() {
    _dio = Dio();
    _searchApiService = SearchApiService(_dio);
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ),
    );
    _searchApiService =
        SearchApiService(_dio, baseUrl: ConfigManager.instance.getBaseUrl());
  }

  Future<ImageModel> getSearchedWallpapers(String query) async {
    return _searchApiService.getSearchedWallpapers(
      ConfigManager.instance.getPexelApiKey(),
      query,
      perPage,
    );
  }
}
