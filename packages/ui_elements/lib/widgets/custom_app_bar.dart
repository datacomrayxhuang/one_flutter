library ui_elements;

import 'package:flutter/material.dart';

/// A customizable app bar widget for consistent styling across the application.
///
/// The `CustomAppBar` widget extends `StatelessWidget` and implements `PreferredSizeWidget`,
/// making it compatible with the `AppBar` widget in Flutter. It provides options for a title,
/// back button, and additional actions.
///
/// ### Features:
/// - **Title**: Displays a customizable title in the app bar.
/// - **Back Button**: Optionally includes a back button for navigation.
/// - **Actions**: Allows adding custom action widgets (e.g., icons, buttons).
/// - **Theming**: Adapts to the app's `ThemeData` for consistent styling.
///
/// ### Properties:
/// - `title` (String): The title text displayed in the app bar.
/// - `hasBackButton` (bool): Determines whether a back button is displayed.
/// - `actions` (List<Widget>?): A list of widgets displayed as actions in the app bar.
///
/// ### Example Usage:
/// ```dart
/// CustomAppBar(
///   title: 'Home',
///   hasBackButton: true,
///   actions: [
///     IconButton(
///       icon: const Icon(Icons.settings),
///       onPressed: () {
///         // Handle settings action
///       },
///     ),
///   ],
/// );
/// ```
///
/// ### Notes:
/// - The `leading` widget is conditionally set to a back button if `hasBackButton` is `true`.
/// - The `backgroundColor` and `title` text color are derived from the app's `ThemeData`.
///
/// ### Preferred Size:
/// - The app bar has a fixed height of `kToolbarHeight` (default Flutter app bar height).
///
/// ### Customization:
/// - Use the `actions` property to add custom widgets (e.g., icons, buttons) to the app bar.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.hasBackButton,
    this.actions,
  });

  final String title;
  final bool hasBackButton;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      actions: actions,
      leading: hasBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
