// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const LoadingIndicator({
    super.key,
    this.color = Colors.blue,
    this.size = 50.0,
  });

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return CustomPaint(
              painter: _LoadingPainter(
                color: widget.color,
                angle: _controller.value * 2 * pi,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingPainter extends CustomPainter {
  final Color color;
  final double angle;

  _LoadingPainter({required this.color, required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double radius = size.width / 10;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    for (int i = 0; i < 4; i++) {
      final double dotAngle = angle + (i * pi / 2);
      final double x = centerX + cos(dotAngle) * (size.width / 3 - radius);
      final double y = centerY + sin(dotAngle) * (size.height / 3 - radius);

      canvas.drawCircle(Offset(x, y), radius * (1 - (i * 0.15)), paint);
    }
  }

  @override
  bool shouldRepaint(_LoadingPainter oldDelegate) =>
      oldDelegate.angle != angle;
}