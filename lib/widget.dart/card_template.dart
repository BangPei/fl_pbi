import 'package:flutter/material.dart';

class CardTemplate extends StatelessWidget {
  final String title;
  final Widget? content;
  final VoidCallback? onPressed;
  final bool? showAddButton;
  final bool? showShimmer;
  const CardTemplate({
    required this.title,
    this.content,
    super.key,
    this.onPressed,
    this.showAddButton,
    this.showShimmer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
            )
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultCardTitle(
              title,
              showAddButton: showAddButton,
              onPressed: onPressed,
            ),
            content ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class DefaultCardTitle extends StatelessWidget {
  final String title;
  final bool? showAddButton;
  final VoidCallback? onPressed;

  const DefaultCardTitle(
    this.title, {
    super.key,
    this.showAddButton,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
