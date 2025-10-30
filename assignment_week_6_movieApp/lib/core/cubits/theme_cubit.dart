import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themeandpagination/core/cubits/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial());

  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      emit(const ThemeChanged(ThemeMode.dark));
    } else {
      emit(const ThemeChanged(ThemeMode.light));
    }
  }
}
