library ui_elements;

import 'package:flutter/material.dart';
import 'package:ui_elements/styles/dimension_constants.dart';

/// A widget that displays a [title] and a [description] in a card.
/// The description can be expanded or collapsed by tapping on the card.
/// The card has a border radius and elevation.
/// The widget also has a long press gesture that can be handled by the parent widget.
/// The widget is scrollable when the description is expanded.
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
