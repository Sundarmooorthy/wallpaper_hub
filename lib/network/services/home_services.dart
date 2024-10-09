import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:dio/dio.dart' hide Headers;

part 'home_services.g.dart';

@RestApi(baseUrl: '')
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

  @GET('curated')
  Future<ImageModel> getCuratedWallpapers(
    @Header('Content-Type') String contentType,
    @Header('Authorization') String authorization,
    @Query('page') int page,
    @Query('per_page') int perPage,
  );
}
