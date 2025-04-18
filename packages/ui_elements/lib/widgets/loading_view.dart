library ui_elements;

import 'package:flutter/material.dart';

/// A simple widget that displays a loading indicator centered on the screen.
///
/// The `LoadingView` widget is a reusable component for showing a loading spinner,
/// typically used to indicate that a background process is in progress.
///
/// ### Features:
/// - **Centered Loading Indicator**:
///   - Displays a `CircularProgressIndicator` centered within the available space.
/// - **Adaptive Design**:
///   - Uses `CircularProgressIndicator.adaptive()` to adapt the loading indicator's appearance
///     based on the platform (e.g., Material Design for Android, Cupertino style for iOS).
///
/// ### Example Usage:
/// ```dart
/// // Display a loading view
/// const LoadingView();
/// ```
///
/// ### Notes:
/// - This widget is stateless and does not manage any state.
/// - It is typically used as a placeholder while waiting for asynchronous operations to complete.
///
/// ### Theming:
/// - The appearance of the loading indicator adapts to the platform's default theme.
/// - For additional customization, wrap the `LoadingView` in a widget that provides a custom theme.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
