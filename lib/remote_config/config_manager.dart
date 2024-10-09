import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:wallpaper_hub/my_app_exports.dart';

class ConfigManager {
  static var remoteConfig = FirebaseRemoteConfig.instance;

  ConfigManager._();

  static final ConfigManager instance = ConfigManager._();

  factory ConfigManager() => instance;

  static Future<void> setUpRemoteConfig() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(seconds: ConfigStrings.FETCH_TIMEOUT),
        minimumFetchInterval: Duration(seconds: ConfigStrings.FETCH_INTERVAL),
      ),
    );
    await remoteConfig.fetchAndActivate();
  }

  /// get string
  String getBaseUrl() {
    return remoteConfig.getString(ConfigStrings.KEY_BASE_URL);
  }

  String getPexelApiKey() {
    return remoteConfig.getString(ConfigStrings.KEY_PEXEL_API_KEY);
  }

  String getMyName() {
    return remoteConfig.getString(ConfigStrings.KEY_MY_NAME);
  }

  List<CategoryModel> getCategoryData() {
    var categoryDataJson =
        remoteConfig.getString(ConfigStrings.KEY_CATEGORY_DATA);
    List<dynamic> decodeData = jsonDecode(categoryDataJson);
    List<CategoryModel> data =
        decodeData.map((json) => CategoryModel.fromJson(json)).toList();
    return data;
  }

  /// get bool

// bool getAddProductCategorySvg() {
//   return remoteConfig.getBool(ConfigString.KEY_IS_PRODUCT_CATEGORY_SVG);
// }

  /// get json list
// List<OnBoardingDataModel> getOnboardingData() {
//   var onboardingDataJson =
//   remoteConfig.getString(ConfigString.KEY_APP_ONBOARDING_DATA);
//
//   List<dynamic> decodedData = jsonDecode(onboardingDataJson);
//
//   List<OnBoardingDataModel> data =
//   decodedData.map((json) => OnBoardingDataModel.fromJson(json)).toList();
//
//   return data;
// }

  /// get object model data

  ///  PremiumPlanModel getPlanData(int roleId) {
//     var planData =
//         remoteConfig.getString(ConfigString.KEY_APP_GO_CAMLE_PREMIUM_PLAN);
//     var data = jsonDecode(planData);
//
//     var plan = PremiumPlanModel.fromJson(data[roleId.toString()]);
//     //debugPrint('Plan Data >>>>> $plan');
//     return plan;
//   }
}
