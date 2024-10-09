import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/repository/repository.dart';
import 'package:wallpaper_hub/screens/category_screen/category_screen_cubit.dart';
import 'package:wallpaper_hub/screens/home_screen/home_screen_cubit.dart';
import 'package:wallpaper_hub/screens/image_full_screen/image_full_screen_cubit.dart';
import 'package:wallpaper_hub/screens/search_screen/search_screen_cubit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  ScrollController _scrollController = ScrollController();
  late HomeScreenCubit _cubit;
  List<CategoryModel> categories = [];
  List<Photos> photos = [];
  ImageModel? imageModel;

  @override
  void initState() {
    _cubit = BlocProvider.of<HomeScreenCubit>(context);
    super.initState();
    _cubit.getCategories();
    _cubit.getPhotos();
  }

  @override
  void dispose() {
    _cubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: brandName(),
        elevation: 0.0,
        toolbarHeight: kToolbarHeight,
      ),
      body: BlocListener<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {
          if (state is ReceivedHomeScreenView) {
            // test = state.testModel;
            imageModel = state.imageData;
            photos = state.imageData.photos!;
            debugPrint('images length >>>> ${photos.length}');
          }
          if (state is CategoryLoaded) {
            categories = state.categories;
            setState(() {});
          }
        },
        child: LiquidPullToRefresh(
          onRefresh: () => _cubit.getPhotos(),
          key: _refreshIndicatorKey,
          backgroundColor: Colors.white,
          color: Colors.orange,
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.appHPadding10,
              vertical: AppDimens.appVPadding10,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  searchField(
                    hintText: 'Search...',
                    readOnly: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  SearchScreenCubit(SearchRepository()),
                              child: const SearchScreen(),
                            ),
                          ));
                    },
                  ),
                  Gap(height: AppDimens.appVPadding10),
                  waterMark(),
                  Gap(height: AppDimens.appVPadding10),
                  SizedBox(
                    height: _size.height * 0.06,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: _size.width * 0.020,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return categoryListItem(index);
                      },
                    ),
                  ),
                  Gap(height: AppDimens.appVPadding20),
                  BlocConsumer<HomeScreenCubit, HomeScreenState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is LoadingHomeView) {
                        print('>>>>>> Loading state reached');
                        return GridView.builder(
                            padding: const EdgeInsets.only(
                              bottom: AppDimens.appVPadding20,
                              top: 0,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 4 / 6.5,
                              crossAxisSpacing: AppDimens.appHPadding10,
                              mainAxisSpacing: AppDimens.appHPadding10,
                            ),
                            itemCount: 20,
                            itemBuilder: (BuildContext context, int index) {
                              return squareShimmer();
                            });
                      }
                      if (state is NoHomeScreenView) {
                        return Center(
                          child: Text(
                            'No Images Currently Available',
                            style: AppTextStyle.semiBold20(color: Colors.black),
                          ),
                        );
                      }
                      if (state is ErrorHomeScreenView) {
                        return Center(child: Text(state.msg));
                      }
                      if (state is ReceivedHomeScreenView) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GridView.builder(
                                padding: const EdgeInsets.only(
                                  bottom: AppDimens.appVPadding20,
                                  top: 0,
                                ),
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4 / 6.5,
                                  crossAxisSpacing: AppDimens.appHPadding10,
                                  mainAxisSpacing: AppDimens.appHPadding10,
                                ),
                                itemCount: photos.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return gridItem(index);
                                }),
                            if (categories.isNotEmpty)
                              Gap(height: AppDimens.appVPadding20),
                            if (categories.isNotEmpty) // show only when list has some data else hide
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: AppDimens.appHPadding10, vertical: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonIconButton(
                                      icon: Icons.arrow_back_ios_new_rounded,
                                      onPressed: () {
                                        _cubit.previousPage();
                                        _scrollController.jumpTo(0.0);
                                      },
                                      tooltip: 'Previous',
                                    ),
                                    CommonIconButton(
                                      icon: Icons.arrow_forward_ios_rounded,
                                      onPressed: () {
                                        _cubit.nextPage();
                                        _scrollController.jumpTo(0.0);
                                      },
                                      tooltip: 'Next',
                                    ),
                                  ],
                                ),
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

  Widget categoryListItem(int index) {
    Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CategoryScreenCubit(
                SearchRepository(),
              ),
              child: CategoryScreen(
                image: categories[index].imgUrl!,
                categoryName: categories[index].categoryName!,
              ),
            ),
          ),
        );
      },
      child: Container(
        height: _size.width * 0.05,
        width: _size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            // Image Layer
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: categories[index].imgUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color:
                        Colors.grey, // Display a grey box if there's an error
                  ),
                ),
              ),
            ),
            // Black filter with light opacity
            Positioned.fill(
              child: Container(
                height: _size.width * 0.05,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                  // black filter with opacity
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            // Text Layer
            Center(
              child: Text(
                categories[index].categoryName ?? 'N/A',
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: AppTextStyle.semiBold(
                  14,
                  color: Colors
                      .white, // set text color to white to contrast with the black filter
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridItem(int index) {
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
          imageUrl: photos[index].src?.portrait ?? '',
          progressIndicatorBuilder: (
            context,
            url,
            progress,
          ) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
                value: progress.progress != null
                    ? progress.totalSize! / progress.downloaded
                    : null,
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
