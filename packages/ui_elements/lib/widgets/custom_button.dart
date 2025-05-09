library ui_elements;

import 'package:flutter/material.dart';
import 'package:ui_elements/styles/color_constants.dart';
import 'package:ui_elements/styles/dimension_constants.dart';

/// A customizable button widget for consistent styling and functionality across the application.
///
/// The `CustomButton` widget extends `StatelessWidget` and provides a flexible and reusable button
/// component with support for primary and secondary styles, icons, and custom configurations.
///
/// ### Features:
/// - **Primary and Secondary Styles**:
///   - `CustomButton.primary`: A button with a primary style (e.g., blue background, white text).
///   - `CustomButton.secondary`: A button with a secondary style (e.g., white background, blue text).
/// - **Icons**:
///   - Supports leading and trailing icons with customizable spacing.
/// - **Disabled State**:
///   - Automatically disables the button when `disabled` is set to `true`.
/// - **Customizable**:
///   - Allows customization of text, background color, border, margin, and overlay color.
///
/// ### Properties:
/// - `text` (Widget): The text or widget displayed inside the button.
/// - `textStyle` (TextStyle): The style of the button text.
/// - `backgroundColor` (Color): The background color of the button.
/// - `onPressed` (VoidCallback?): The callback triggered when the button is pressed.
/// - `disabled` (bool): Determines whether the button is disabled.
/// - `margin` (EdgeInsetsGeometry): The margin around the button.
/// - `overlayColor` (Color?): The color displayed when the button is pressed.
/// - `borderSide` (BorderSide): The border style of the button.
/// - `leadingIcon` (Widget?): An optional widget displayed before the text.
/// - `leadingIconSpacingWidget` (Widget): A widget to add spacing between the leading icon and text.
/// - `trailingIcon` (Widget?): An optional widget displayed after the text.
/// - `trailingIconSpacingWidget` (Widget): A widget to add spacing between the trailing icon and text.
///
/// ### Example Usage:
/// ```dart
/// // Primary button with leading icon
/// CustomButton.primary(
///   text: const Text('Submit'),
///   onPressed: () {
///     print('Primary button pressed');
///   },
///   leadingIcon: const Icon(Icons.send),
/// );
///
/// // Secondary button with trailing icon
/// CustomButton.secondary(
///   text: const Text('Cancel'),
///   onPressed: () {
///     print('Secondary button pressed');
///   },
///   trailingIcon: const Icon(Icons.close),
/// );
///
/// // Disabled button
/// CustomButton.primary(
///   text: const Text('Disabled'),
///   onPressed: null,
///   disabled: true,
/// );
/// ```
///
/// ### Notes:
/// - The button automatically adjusts its appearance when disabled (e.g., reduced opacity).
/// - The `leadingIcon` and `trailingIcon` are optional and can be omitted if not needed.
/// - The button's height is constrained to `kStandardInteractionHeight` for consistency.
///
/// ### Theming:
/// - The button's colors and styles are derived from constants like `kPrimaryBlueColor` and `kWhiteColor`.
/// - The border radius is fixed at 8.0 for a consistent rounded appearance.
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.textStyle,
    required this.backgroundColor,
    required this.onPressed,
    this.disabled = false,
    this.margin = EdgeInsets.zero,
    this.overlayColor,
    this.borderSide = BorderSide.none,
    this.leadingIcon,
    this.leadingIconSpacingWidget = const SizedBox(width: 12),
    this.trailingIcon,
    this.trailingIconSpacingWidget = const SizedBox(width: 12),
  });

  const CustomButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.margin = EdgeInsets.zero,
    this.leadingIcon,
    this.leadingIconSpacingWidget = const SizedBox(width: 12),
    this.trailingIcon,
    this.trailingIconSpacingWidget = const SizedBox(width: 12),
  })  : textStyle = const TextStyle(
          color: kWhiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        overlayColor = kSecondaryBlueColor,
        backgroundColor = kPrimaryBlueColor,
        borderSide = BorderSide.none;

  const CustomButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.margin = EdgeInsets.zero,
    this.leadingIcon,
    this.leadingIconSpacingWidget = const SizedBox(width: 12),
    this.trailingIcon,
    this.trailingIconSpacingWidget = const SizedBox(width: 12),
  })  : textStyle = const TextStyle(
          color: kPrimaryBlueColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        overlayColor = const Color.fromARGB(255, 211, 245, 255),
        backgroundColor = kWhiteColor,
        borderSide = const BorderSide(color: kPrimaryBlueColor);

  final Widget text;
  final TextStyle textStyle;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final bool disabled;
  final EdgeInsetsGeometry margin;
  final Color? overlayColor;
  final BorderSide borderSide;
  final Widget? leadingIcon;
  final Widget leadingIconSpacingWidget;
  final Widget? trailingIcon;
  final Widget trailingIconSpacingWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: kStandardInteractionHeight,
          minHeight: kStandardInteractionHeight,
          minWidth: double.infinity,
          maxWidth: double.infinity,
        ),
        child: TextButton(
          style: ButtonStyle(
            animationDuration: Duration.zero,
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry?>(
              EdgeInsets.zero,
            ),
            backgroundColor: WidgetStatePropertyAll<Color?>(
              !disabled ? backgroundColor : backgroundColor.withOpacity(0.2),
            ),
            overlayColor: WidgetStatePropertyAll<Color?>(overlayColor),
            shape: WidgetStatePropertyAll<OutlinedBorder?>(
              RoundedRectangleBorder(
                side: borderSide,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            textStyle: WidgetStatePropertyAll<TextStyle?>(
              textStyle.copyWith(
                foreground: Paint()..color = textStyle.color ?? kBlackColor,
              ),
            ),
          ),
          onPressed: !disabled ? onPressed : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null) ...[
                  leadingIcon!,
                  leadingIconSpacingWidget,
                ],
                text,
                if (trailingIcon != null) ...[
                  trailingIconSpacingWidget,
                  trailingIcon!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
