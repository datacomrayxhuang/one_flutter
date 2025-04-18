library ui_elements;

import 'package:flutter/material.dart';
import 'package:ui_elements/styles/color_constants.dart';
import 'package:ui_elements/styles/dimension_constants.dart';

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
