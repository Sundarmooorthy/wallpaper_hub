import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:wallpaper_hub/screens/category_screen/category_screen_cubit.dart';
import '../image_full_screen/image_full_screen_cubit.dart';

class CategoryScreen extends StatefulWidget {
  final String image;
  final String categoryName;

  const CategoryScreen(
      {super.key, required this.image, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryScreenCubit _cubit;
  List<Photos> photos = [];

  @override
  void initState() {
    _cubit = BlocProvider.of<CategoryScreenCubit>(context);
    super.initState();
    _cubit.getPhotos(widget.categoryName);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<CategoryScreenCubit, CategoryScreenState>(
        listener: (context, state) {
          if (state is ReceivedCategoryView) {
            photos = state.imageData.photos!;
          }
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    // Do something
                  }),
              expandedHeight: size.height * 0.22,
              floating: false,
              // pinned: true,
              snap: false,
              elevation: 50,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  // title: Text(widget.categoryName,
                  //     style: AppTextStyle.semiBold16(color: Colors.white)),
                  background: Stack(
                    children: [
                      Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned.fill(
                        child: Container(
                          height: size.height * 0.22,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            // black filter with opacity
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.categoryName,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: AppTextStyle.semiBold(
                            32,
                            color: Colors
                                .white, // set text color to white to contrast with the black filter
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    BlocConsumer<CategoryScreenCubit, CategoryScreenState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LoadingCategoryView) {
                      return buildShimmerGrid(
                        itemCount: 20,
                        child: squareShimmer(),
                      );
                    }
                    if (state is NoCategoryView) {
                      return Center(
                        child: Text(
                          'No Images Currently Available',
                          style: AppTextStyle.semiBold20(color: Colors.black),
                        ),
                      );
                    }
                    if (state is ErrorCategoryView) {
                      return Center(child: Text(state.msg));
                    }
                    if (state is ReceivedCategoryView) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.appHPadding10,
                          vertical: AppDimens.appVPadding10,
                        ),
                        child: Column(
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
                        ),
                      );
                    }
                    return Container();
                  },
                  buildWhen: (previous, state) {
                    return state is ReceivedCategoryView ||
                        state is LoadingCategoryView ||
                        state is NoCategoryView ||
                        state is ErrorCategoryView;
                  },
                ),
              ),
            ),
          ],
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
                imageUrl: photos[index].src?.original ?? '',
              ),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: CachedNetworkImage(
          imageUrl: photos[index].src?.medium ?? '',
          progressIndicatorBuilder: (
            context,
            url,
            progress,
          ) {
            return Center(
              /*child: CircularProgressIndicator(
              color: Colors.orange,
              value: progress.progress != null
                  ? progress.totalSize! / progress.downloaded
                  : null,
            )*/
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
