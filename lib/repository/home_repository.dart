import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wallpaper_hub/my_app_exports.dart';

class HomeRepository {
  late Dio _dio;
  late HomeApiService homeApiService;

  HomeRepository() {
    _dio = Dio();
    homeApiService = HomeApiService(_dio);
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ),
    );
    homeApiService = HomeApiService(_dio, baseUrl: ApiConstant.baseUrl);
  }

  Future<ImageModel> fetchCuratedWallpapers(int page, int perPage) async {
    return homeApiService.getCuratedWallpapers(
      page,
      perPage,
    );
  }

  Future<List<CategoryModel>> fetchCategories() async {
    return ConfigManager.instance.getCategoryData();
  }
}
