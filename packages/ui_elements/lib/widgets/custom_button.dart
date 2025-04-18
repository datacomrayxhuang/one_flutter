library ui_elements;

import 'package:flutter/material.dart';
import 'package:ui_elements/styles/color_constants.dart';
import 'package:ui_elements/styles/dimension_constants.dart';

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
