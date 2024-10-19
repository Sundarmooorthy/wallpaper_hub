import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../my_app_exports.dart';

part 'on_boarding_dart_state.dart';

class OnBoardingDartCubit extends Cubit<OnBoardingDartState> {
  OnBoardingDartCubit() : super(OnBoardingDartInitial());
}
