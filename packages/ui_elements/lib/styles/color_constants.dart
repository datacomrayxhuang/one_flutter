library ui_elements;

import 'package:flutter/material.dart';

const Color kPrimaryBlueColor = Color(0xFF0061FD);
const Color kSecondaryBlueColor = Color(0xFF005AAA);
const Color kErrorColor = Color(0xFFEE303E);
const Color kSuccessColor = Color(0xFF1D9F70);
const Color kWhiteColor = Color(0xFFFFFFFF);
const Color kBlackColor = Color(0xFF1E1E1E);
const Color kDisabledInputBackgroundColor = Color(0xFFF7F9FC);
const Color kDisabledInputBorderColor = Color(0xFFDFE5F5);

final ThemeData kDefaultTheme = ThemeData(
  useMaterial3: true,
  colorScheme: kDefaultColorScheme,
);

const ColorScheme kDefaultColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: kPrimaryBlueColor,
  onPrimary: kWhiteColor,
  secondary: kSecondaryBlueColor,
  onSecondary: Colors.white,
  error: kErrorColor,
  onError: kWhiteColor,
  surface: kWhiteColor,
  onSurface: Colors.black,
);
