import 'package:flutter/material.dart';

class BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..color = const Color(0xffEBEBFF)
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;
    Path path1 = Path();

    var rect = Rect.fromLTRB(
      -size.width * 0.4,
      size.height - 160,
      size.width * 0.6,
      size.height + 250,
    );
    path1.addOval(rect);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(BgPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BgPainter oldDelegate) => false;
}
