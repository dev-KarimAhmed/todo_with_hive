import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodo_app/constants/colors.dart';
import 'package:mytodo_app/cubit/ui_state.dart';

class UiCubit extends Cubit<UiState> {
  UiCubit() : super(UiInitial());
  static UiCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeColor(index) {
    currentIndex = index;

    emit(ColorPaletteChanged());
  }

  Color taskColor(int color) {
    emit(ColorTaskChanged());
    if (color == 0) {
      return kPrimaryColor;
    } else if (color == 1) {
      return kAnotherColor;
    } else {
      return kOrangeColor;
    }
  }
}
