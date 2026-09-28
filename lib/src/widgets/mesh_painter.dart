import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../mesh_point.dart';

/// High-performance custom painter that draws layered organic radial gradients for each mesh point.
class MeshPainter extends CustomPainter {
  final List<MeshPoint> points;
  final Color backgroundColor;
  final BlendMode blendMode;

  MeshPainter({
    required this.points,
    required this.backgroundColor,
    this.blendMode = BlendMode.srcOver,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    // 1. Paint background foundation
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = backgroundColor,
    );

    final double maxDimension = math.max(size.width, size.height);

    // 2. Render each floating color blob
    for (final point in points) {
      final center = Offset(
        point.position.dx * size.width,
        point.position.dy * size.height,
      );
      final radius = point.radius * maxDimension;

      if (radius <= 0) continue;

      final paint = Paint()
        ..blendMode = blendMode
        ..shader = RadialGradient(
          colors: [
            point.color,
            point.color.withAlpha((point.color.a * 255 * 0.75).round()),
            point.color.withAlpha(0),
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MeshPainter oldDelegate) => true;
}
