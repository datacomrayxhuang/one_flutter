library ui_elements;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_elements/styles/color_constants.dart';
import 'package:ui_elements/styles/dimension_constants.dart';

/// A customizable text field widget for consistent styling and functionality across the application.
///
/// The `CustomTextField` widget extends `StatelessWidget` and provides a flexible and reusable
/// text input component with support for validation, custom decorations, and input formatting.
///
/// ### Features:
/// - **Customizable Input Decoration**:
///   - Provides default and disabled input decorations for consistent styling.
/// - **Validation**:
///   - Displays a character counter when the remaining characters are less than 10 or exceed 300.
/// - **Read-Only Mode**:
///   - Supports a read-only state with a distinct appearance.
/// - **Input Formatting**:
///   - Allows custom input formatters for advanced input validation.
/// - **Event Handling**:
///   - Supports `onChanged`, `onTap`, and `onTapOutside` callbacks for interaction handling.
///
/// ### Properties:
/// - `controller` (TextEditingController): Manages the text being edited.
/// - `onChanged` (void Function(String text)?): Callback triggered when the text changes.
/// - `onTap` (VoidCallback?): Callback triggered when the text field is tapped.
/// - `onTapOutside` (void Function(PointerDownEvent event)?): Callback triggered when tapping outside the text field.
/// - `inputDecoration` (InputDecoration): The decoration applied to the text field.
/// - `textAlign` (TextAlign): Alignment of the text inside the text field. Defaults to `TextAlign.start`.
/// - `textCapitalization` (TextCapitalization): Configures text capitalization. Defaults to `TextCapitalization.none`.
/// - `keyboardType` (TextInputType?): The type of keyboard to use for text input.
/// - `inputFormatters` (List<TextInputFormatter>?): A list of input formatters to apply.
/// - `isComplusory` (bool): Indicates whether the field is mandatory. Defaults to `false`.
/// - `readOnly` (bool): Determines whether the text field is read-only. Defaults to `false`.
/// - `maxLines` (int?): The maximum number of lines for the text field. Defaults to `1`.
/// - `maxLength` (int?): The maximum number of characters allowed in the text field.
///
/// ### Example Usage:
/// ```dart
/// // Basic text field
/// CustomTextField(
///   controller: TextEditingController(),
///   inputDecoration: CustomTextField.defaultInputDecoration.copyWith(
///     labelText: 'Enter your name',
///   ),
///   onChanged: (text) {
///     print('Text changed: $text');
///   },
/// );
///
/// // Read-only text field
/// CustomTextField(
///   controller: TextEditingController(text: 'Read-only text'),
///   readOnly: true,
///   inputDecoration: CustomTextField.defaultDisabledInputDecoration.copyWith(
///     labelText: 'Read-Only',
///   ),
/// );
///
/// // Text field with character limit
/// CustomTextField(
///   controller: TextEditingController(),
///   maxLength: 50,
///   inputDecoration: CustomTextField.defaultInputDecoration.copyWith(
///     labelText: 'Limited Input',
///   ),
/// );
/// ```
///
/// ### Notes:
/// - The `buildCounter` property dynamically displays the remaining characters when `maxLength` is set.
/// - The `defaultInputDecoration` and `defaultDisabledInputDecoration` provide consistent styling for enabled and disabled states.
/// - The `isComplusory` property can be used for validation purposes but does not enforce validation by itself.
///
/// ### Theming:
/// - The widget uses constants like `kFieldStrokeColor`, `kErrorColor`, and `kDisabledInputBackgroundColor` for consistent styling.
/// - The border radius is defined by `kStandardBorderRadius` for a uniform rounded appearance.
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
