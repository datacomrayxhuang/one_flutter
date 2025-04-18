library ui_elements;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_elements/styles/color_constants.dart';
import 'package:ui_elements/styles/dimension_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.inputDecoration = defaultInputDecoration,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.inputFormatters,
    this.isComplusory = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
  });

  static const InputDecoration defaultInputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      // borderSide: BorderSide(color: kFieldStrokeColor),
      borderRadius: kStandardBorderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      // borderSide: BorderSide(color: kFieldStrokeColor),
      borderRadius: kStandardBorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kErrorColor),
      borderRadius: kStandardBorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kErrorColor),
      borderRadius: kStandardBorderRadius,
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 16,
    ),
  );

  static const InputDecoration defaultDisabledInputDecoration = InputDecoration(
    filled: true,
    fillColor: kDisabledInputBackgroundColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kDisabledInputBorderColor),
      borderRadius: kStandardBorderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kDisabledInputBorderColor),
      borderRadius: kStandardBorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kErrorColor),
      borderRadius: kStandardBorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kErrorColor),
      borderRadius: kStandardBorderRadius,
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 16,
    ),
    labelStyle: TextStyle(
      color: kBlackColor,
    ),
    hintText: '',
    hintStyle: TextStyle(
      color: kBlackColor,
    ),
  );

  final TextEditingController controller;
  final void Function(String text)? onChanged;
  final VoidCallback? onTap;
  final void Function(PointerDownEvent event)? onTapOutside;
  final InputDecoration inputDecoration;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isComplusory;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: controller,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onChanged: onChanged,
      decoration: inputDecoration,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      maxLength: maxLength,
      textAlign: textAlign,
      buildCounter: (
        context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) =>
          maxLength != null &&
                  ((maxLength - currentLength) <= 10 || maxLength >= 300)
              ? Text(
                  '${maxLength - currentLength} characters left',
                  style: const TextStyle(),
                )
              : null,
    );
  }
}
