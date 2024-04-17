import 'package:flutter/material.dart';
import 'package:task1/utils/dimensions.dart';

class MyNormalText extends StatelessWidget {
  final String text;
  Color color;
  double size;
  TextOverflow overflow;
   MyNormalText({super.key,
    required this.text,
    this.color = const Color(0xFF323d2b),
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,

  });

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        maxLines: 1,
        overflow: overflow,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: size == 0 ? Dimensions.font20 : size,
        )
    );
  }
}
