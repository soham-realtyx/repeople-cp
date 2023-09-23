import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final Color color;
  final double height;
  const HorizontalDivider({Key? key, required this.color,required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
    );
  }
}
