import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_hub/my_app_exports.dart';

Future navigateTo(BuildContext context, String destination, {Object? args}) {
  return Navigator.pushNamed(context, destination, arguments: args);
}

Future<R?> navigateToWithReturnData<R>(BuildContext context, String destination,
    {Object? args}) {
  return Navigator.pushNamed<R>(context, destination, arguments: args);
}

Future replaceWith(BuildContext context, String destination, {dynamic args}) {
  return Navigator.pushReplacementNamed(context, destination, arguments: args);
}

// app bar text widget
Widget brandName({double? fontSize = 10}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'WallPaper',
        style: AppTextStyle.semiBold20(size: fontSize),
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        'Zone',
        style: AppTextStyle.semiBold20(color: Colors.orange, size: fontSize),
      ),
    ],
  );
}

// common search field
Widget searchField({
  String? hintText,
  TextEditingController? controller,
  bool readOnly = false,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function()? searchTap,
  TextInputAction? textInputAction,
  void Function(String)? onSubmitted,
  Widget? suffixIcon = const Icon(Icons.search),
}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    onTap: onTap,
    textInputAction: textInputAction,
    onSubmitted: onSubmitted,
    style: AppTextStyle.semiBold(
      14,
    ),
    readOnly: readOnly,
    autofocus: false,
    decoration: InputDecoration(
      hintText: hintText,
      // contentPadding: EdgeInsets.symmetric(horizontal: AppDimens.appHPadding10,vertical: AppDimens.appVPadding10),
      hintStyle: AppTextStyle.normal14(color: Colors.grey),
      suffixIcon: GestureDetector(
        onTap: searchTap,
        child: suffixIcon,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.3),
    ),
  );
}

// water mark widget
Widget waterMark() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Made with ❤️ by ',
        style: AppTextStyle.semiBold14(color: Colors.black.withOpacity(0.7)),
      ),
      Text(
        ConfigManager.instance.getMyName(),
        style: AppTextStyle.bold14(color: Colors.black),
      )
    ],
  );
}

Widget Gap({double? height, double? width}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

Widget squareShimmer(
    {double? width, double? height, double? borderRadius = 12}) {
  return SizedBox(
    width: width,
    height: height,
    child: Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.5),
      highlightColor: Colors.grey.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey, // Background color for the shimmer effect
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        alignment: Alignment.center,
      ),
    ),
  );
}

Widget buildShimmerGrid({int itemCount = 10, Widget? child}) {
  return GridView.builder(
      padding: const EdgeInsets.only(
        bottom: AppDimens.appVPadding20,
        top: AppDimens.appVPadding20,
        left: AppDimens.appHPadding10,
        right: AppDimens.appHPadding10,
      ),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 6.5,
        crossAxisSpacing: AppDimens.appHPadding10,
        mainAxisSpacing: AppDimens.appHPadding10,
      ),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return child;
      });
}
