import 'package:flutter/material.dart';

class RowSpace extends StatelessWidget {
  final double? height;
  final double? width;
  const RowSpace({super.key, this.height = 8, this.width = 0});

  @override
  Widget build(Object context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
