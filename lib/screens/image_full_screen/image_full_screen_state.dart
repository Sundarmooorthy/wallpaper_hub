part of 'image_full_screen_cubit.dart';

@immutable
sealed class ImageFullScreenState {}

final class ImageFullScreenInitial extends ImageFullScreenState {}

class ImageDownloading extends ImageFullScreenState {}

class ImageDownloadSuccess extends ImageFullScreenState {
  final String imagePath;

  ImageDownloadSuccess(this.imagePath);
}

class ImageDownloadFailure extends ImageFullScreenState {
  final String error;

  ImageDownloadFailure(this.error);
}

class ImageDownloadError extends ImageFullScreenState {
  final String msg;

  ImageDownloadError(this.msg);
}
