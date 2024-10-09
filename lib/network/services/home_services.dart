import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:wallpaper_hub/model/api/api.dart';
import 'package:wallpaper_hub/network/utils/api_constants.dart';
import 'package:dio/dio.dart' hide Headers;

part 'home_services.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

  @GET('curated')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
    'Authorization': ApiConstant.pexelAPIKey,
  })
  Future<ImageModel> getCuratedWallpapers(
    @Query('page') int page,
    @Query('per_page') int perPage,
  );
}
