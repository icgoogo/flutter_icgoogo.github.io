import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color bgColor;
  final Text title;
  final Function() onTap;
  final bool compact;

  const CustomButton({
    required this.bgColor,
    required this.title,
    required this.onTap,
    this.compact = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final text = title.data ?? '';
    bool isSamePage = text.contains("Projects") || text.contains("Home");

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: compact ? 6 : 80),
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        decoration: BoxDecoration(
          border: compact ? Border.all(color: Colors.white24) : null,
          boxShadow: compact
              ? null
              : const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(10, 10),
                  ),
                ],
        ),
        child: Material(
          color: bgColor,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: compact ? 10.0 : 32.0,
                horizontal: 16.0,
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    title,
                    if (!isSamePage) ...[
                      const SizedBox(width: 8),
                      Icon(
                        Icons.open_in_new,
                        size: compact ? 14 : 18,
                        color: title.style?.color ?? Colors.white,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
