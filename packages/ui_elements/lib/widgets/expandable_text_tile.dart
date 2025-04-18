library ui_elements;

import 'package:flutter/material.dart';
import 'package:ui_elements/styles/dimension_constants.dart';

/// A widget that displays a [title] and a [description] in a card, with the ability to expand or collapse the description.
///
/// The `ExpandableTextTile` widget is a reusable component that shows a title and a description.
/// The description can be expanded or collapsed by tapping on the card. It also supports a long press gesture
/// that can be handled by the parent widget. The widget is scrollable when the description is expanded.
///
/// ### Features:
/// - **Expandable Description**:
///   - The description is collapsed by default and can be expanded to show the full content.
/// - **Customizable Styles**:
///   - Allows customization of the title and description text styles.
/// - **Gestures**:
///   - Supports tap to toggle expansion and an optional long press gesture.
/// - **Card Styling**:
///   - Includes rounded corners, elevation, and padding for a polished appearance.
///
/// ### Properties:
/// - `title` (String): The title text displayed at the top of the card.
/// - `titleTextStyle` (TextStyle): The style of the title text. Defaults to bold with a font size of 18.
/// - `description` (String): The description text displayed below the title.
/// - `descriptionTextStyle` (TextStyle): The style of the description text. Defaults to a font size of 14.
/// - `onTap` (VoidCallback?): An optional callback triggered when the card is tapped.
/// - `onLongPress` (VoidCallback?): An optional callback triggered when the card is long-pressed.
///
/// ### Example Usage:
/// ```dart
/// ExpandableTextTile(
///   title: 'Task Title',
///   description: 'This is a detailed description of the task. Tap to expand or collapse.',
///   onTap: () {
///     print('Tile tapped');
///   },
///   onLongPress: () {
///     print('Tile long-pressed');
///   },
/// );
/// ```
///
/// ### Notes:
/// - The card's height is constrained to 150 pixels when collapsed and expands up to 300 pixels when expanded.
/// - The description text uses `TextOverflow.ellipsis` when collapsed to indicate truncated content.
/// - The expand/collapse animation is smooth, with a rotation effect on the expand icon.
///
/// ### Theming:
/// - The card uses `kStandardBorderRadius` for rounded corners.
/// - The elevation is set to `2` for a subtle shadow effect.
/// - The padding and margins are consistent with Material Design guidelines.
///
/// ### Customization:
/// - The `titleTextStyle` and `descriptionTextStyle` can be customized to match the app's theme.
/// - The `onTap` and `onLongPress` callbacks allow for additional interactivity.
class ExpandableTextTile extends StatefulWidget {
  final String title;
  final TextStyle titleTextStyle;
  final String description;
  final TextStyle descriptionTextStyle;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ExpandableTextTile({
    super.key,
    required this.title,
    this.titleTextStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    required this.description,
    this.descriptionTextStyle = const TextStyle(fontSize: 14),
    this.onTap,
    this.onLongPress,
  });

  @override
  State<ExpandableTextTile> createState() => _ExpandableTextTileState();
}

class _ExpandableTextTileState extends State<ExpandableTextTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: kStandardBorderRadius,
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: kStandardBorderRadius,
        radius: 300,
        onTap: () => setState(() {
          _isExpanded = !_isExpanded;
          if (widget.onTap != null) {
            widget.onTap!();
          }
        }),
        onLongPress: widget.onLongPress,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: _isExpanded ? 300 : 150,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: widget.titleTextStyle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.description,
                          maxLines: _isExpanded ? null : 3,
                          overflow: _isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: widget.descriptionTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: _isExpanded
                      ? 0.5
                      : 0.0, // Rotate 180 degrees when expanded
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.expand_more),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
