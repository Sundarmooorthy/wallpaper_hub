import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallpaper_hub/utils/utils_method.dart';

part 'image_full_screen_state.dart';

class ImageFullScreenCubit extends Cubit<ImageFullScreenState> {
  ImageFullScreenCubit() : super(ImageFullScreenInitial());
  Dio dio = Dio();

  Future<void> saveImageLocally(String imageUrl) async {
    emit(ImageDownloading());

    try {
      final directory = await getExternalStorageDirectory();

      final appFolder = Directory(path.join(directory!.path, 'Wallpaper Zone'));
      if (!await appFolder.exists()) {
        await appFolder.create(recursive: true);
      }

      final String fileName = path.basename(imageUrl).split('?').first;
      final String localPath = path.join(appFolder.path, fileName);

      final Response response = await dio.get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        final File localImageFile = File(localPath);
        await localImageFile.writeAsBytes(response.data);

        await saveImageToDevice(localImageFile.path);

        emit(ImageDownloadSuccess(localImageFile.path));
        UtilsMethod().showToast(
            "Image saved successfully at ${localImageFile.path}",
            ToastType.success);
      } else {
        throw Exception("Failed to download image");
      }
    } catch (e) {
      emit(ImageDownloadFailure(e.toString()));
      UtilsMethod().showToast("Failed to save image: $e", ToastType.error);
    }
  }

  Future<void> saveImageToDevice(String imagePath) async {
    final database = await openDatabase(
      path.join(await getDatabasesPath(), 'wallpaperZone.db'),
      onCreate: (db, version) {
        return db
            .execute('CREATE TABLE images(id INTEGER PRIMARY KEY, path TEXT)');
      },
      version: 1,
    );

    await database.insert(
      'images',
      {'path': imagePath},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
