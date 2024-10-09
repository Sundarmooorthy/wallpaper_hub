import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:wallpaper_hub/screens/image_full_screen/image_full_screen_cubit.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ImageFullScreen extends StatefulWidget {
  final List<Photos> photos;
  final String imageUrl;

  const ImageFullScreen(
      {super.key, required this.photos, required this.imageUrl});

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  late ImageFullScreenCubit _cubit;
  bool isDownloadingDone = false;

  @override
  void initState() {
    _cubit = BlocProvider.of<ImageFullScreenCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: WidgetZoom(
                heroAnimationTag: 'tag',
                zoomWidget: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.fitHeight,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
                closeFullScreenImageOnDispose: true,
              ),
            ),
            Gap(height: AppDimens.appVPadding20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.appHPadding10,
          vertical: AppDimens.appHPadding20,
        ),
        child: BlocConsumer<ImageFullScreenCubit, ImageFullScreenState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state is ImageDownloadSuccess) {
              isDownloadingDone = true;
              setState(() {});
            } else {
              isDownloadingDone = false;
            }
          },
          builder: (context, state) {
            return CommonElevatedButton(
              height: size.height * 0.055,
              bgColor: isDownloadingDone ? Colors.green : Colors.orange,
              text: isDownloadingDone ? 'Downloaded' : 'Download',
              icon: Icon(
                isDownloadingDone ? Icons.cloud_done : Icons.download_outlined,
                color: Colors.white,
              ),
              textStyle: AppTextStyle.semiBold16(color: Colors.white),
              onPressed: () {
                _cubit.saveImageLocally(widget.imageUrl);
              },
            );
          },
        ),
      ),
    );
  }
}
