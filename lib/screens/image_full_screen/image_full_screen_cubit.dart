import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

part 'image_full_screen_state.dart';

class ImageFullScreenCubit extends Cubit<ImageFullScreenState> {
  ImageFullScreenCubit() : super(ImageFullScreenInitial());
  Dio dio = Dio();
  final AudioPlayer player = AudioPlayer();

  Future<void> saveImageLocally(String imageUrl, String imageName) async {
    emit(ImageDownloading());

    try {
      var response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: imageName,
      );

      if (result['isSuccess']) {
        emit(ImageDownloadSuccess("Image Downloaded Successfully"));
      } else {
        emit(ImageDownloadFailure("Image Downloaded Failed"));
        await player.play(AssetSource('bike_bell.mp3'));
      }
    } catch (e) {
      emit(ImageDownloadError('Error: $e'));
    }
  }

  Future<void> playSound() async {
    String soundPath = 'bike_bell.mp3';
    return await player.play(AssetSource(soundPath));
  }
}
