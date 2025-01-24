import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class Sliver extends StatelessWidget {
  final int headerText;
  final Widget sliver;
  const Sliver({super.key, required this.headerText, required this.sliver});

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        alignment: Alignment.centerLeft,
        height: 65,
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          '$headerText',
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      sliver: sliver,
    );
  }
}
