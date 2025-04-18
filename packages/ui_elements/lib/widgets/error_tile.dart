library ui_elements;

import 'package:flutter/material.dart';
import 'package:ui_elements/styles/color_constants.dart';
import 'package:ui_elements/styles/dimension_constants.dart';

/// A customizable error tile widget for displaying error messages in the application.
///
/// The `ErrorTile` widget extends `StatelessWidget` and provides a reusable component
/// for showing error messages with consistent styling. It supports two predefined styles:
/// red and black, with customizable colors and layouts.
///
/// ### Features:
/// - **Error Message Display**:
///   - Displays a user-friendly error message in a styled container.
/// - **Predefined Styles**:
///   - `ErrorTile.red`: Displays the error message with a red border and background.
///   - `ErrorTile.black`: Displays the error message with a black border and white background.
/// - **Icon Support**:
///   - Includes an error icon (`Icons.error_outline`) for visual emphasis.
///
/// ### Properties:
/// - `errorMessage` (String): The error message to display.
/// - `color` (Color): The color of the border and background. Defaults to `kErrorColor` for red tiles and `kBlackColor` for black tiles.
///
/// ### Example Usage:
/// ```dart
/// // Red error tile
/// const ErrorTile.red(
///   errorMessage: 'An error occurred. Please try again.',
/// );
///
/// // Black error tile
/// const ErrorTile.black(
///   errorMessage: 'Unable to load data.',
/// );
/// ```
///
/// ### Notes:
/// - The `ErrorTile.red` style uses a semi-transparent red background with a red border.
/// - The `ErrorTile.black` style uses a white background with a black border.
/// - The error message text is styled with a bold font and a font size of 14.
///
/// ### Theming:
/// - The widget uses constants like `kErrorColor`, `kBlackColor`, and `kWhiteColor` for consistent styling.
/// - The border radius is defined by `kStandardBorderRadius` for a uniform rounded appearance.
///
/// ### Customization:
/// - The `color` property can be customized to use any color beyond the predefined red and black styles.
class ErrorTile extends StatelessWidget {
  const ErrorTile.red({
    super.key,
    required this.errorMessage,
  }) : color = kErrorColor;

  const ErrorTile.black({
    super.key,
    required this.errorMessage,
  }) : color = kBlackColor;

  final String errorMessage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
          borderRadius: kStandardBorderRadius,
          color: color == kBlackColor ? kWhiteColor : color.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.error_outline,
                  size: 24,
                  color: kErrorColor,
                ),
              ),
              Expanded(
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    color: kErrorColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
