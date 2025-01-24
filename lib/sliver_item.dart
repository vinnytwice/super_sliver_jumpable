import 'package:flutter/material.dart';

class SliverItem extends StatelessWidget {
  final String itemText;
  const SliverItem({
    super.key,
    required this.itemText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Text(
        itemText,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
