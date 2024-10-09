import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../my_app_exports.dart';

part 'search_services.g.dart';

@RestApi(baseUrl: '')
abstract class SearchApiService {
  factory SearchApiService(Dio dio, {String baseUrl}) = _SearchApiService;

  @GET('search')
  Future<ImageModel> getSearchedWallpapers(
    @Header('Authorization') String apiKey,
    @Query('query') String query,
    @Query('per_page') int perPage,
  );
}
