import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:wallpaper_hub/screens/search_screen/search_screen_cubit.dart';

import '../image_full_screen/image_full_screen_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchScreenCubit _cubit;
  List<Photos> photos = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _cubit = BlocProvider.of<SearchScreenCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.close();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<SearchScreenCubit, SearchScreenState>(
      listener: (context, state) {
        if (state is ReceivedSearchView) {
          photos = state.imageData.photos!;
          setState(() {});
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.appHPadding10,
              vertical: AppDimens.appVPadding10,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchField(
                    controller: controller,
                    hintText: 'Search by Nature, Cars, Mountain...',
                    searchTap: () {
                      _cubit.getPhotos(controller.text);
                    },
                    textInputAction: TextInputAction.search,
                    onSubmitted: (v) {
                      _cubit.getPhotos(controller.text);
                    },
                  ),
                  Gap(height: AppDimens.appVPadding20),
                  photos.isEmpty
                      ? Center(
                          child: Image.asset(
                            alignment: Alignment.center,
                            AppImages.searchImage,
                            fit: BoxFit.cover,
                            height: size.height * 0.5,
                          ),
                        )
                      : BlocConsumer<SearchScreenCubit, SearchScreenState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is LoadingSearchView) {
                              return buildShimmerGrid(
                                itemCount: 20,
                                child: squareShimmer(),
                              );
                            }
                            if (state is NoSearchView) {
                              return Center(
                                child: Text(
                                  'No Images Currently Available',
                                  style: AppTextStyle.semiBold20(
                                      color: Colors.black),
                                ),
                              );
                            }
                            if (state is ErrorSearchView) {
                              return Center(child: Text(state.msg));
                            }
                            if (state is ReceivedSearchView) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                              MasonryGridView.count(
                              crossAxisSpacing: AppDimens.appHPadding10,
                                mainAxisSpacing: AppDimens.appVPadding10,
                                padding: const EdgeInsets.only(
                                  bottom: AppDimens.appVPadding20,
                                  top: 0,
                                ),
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: photos.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return gridItem(index);
                                },
                                crossAxisCount: 2,
                              ),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget gridItem(int index) {
    Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ImageFullScreenCubit(),
              child: ImageFullScreen(
                photos: photos,
                imageUrl: photos[index].src?.large2x ?? '',
              ),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: CachedNetworkImage(
          imageUrl: photos[index].src?.original ?? '',
          progressIndicatorBuilder: (
            context,
            url,
            progress,
          ) {
            return Center(
              // child: CircularProgressIndicator(
              //   color: Colors.orange,
              //   value: progress.progress != null
              //       ? progress.totalSize! / progress.downloaded
              //       : null,
              // )
              child: squareShimmer(
                height: _size.height * 0.32,
                width: double.infinity,
              ),
            );
          },
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      ),
    );
  }
}
