import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mesh_gradient_canvas/mesh_gradient_canvas.dart';

void main() {
  group('MeshPoint Tests', () {
    test('Initializes with provided parameters and supports copyWith', () {
      final point = MeshPoint(
        color: Colors.blue,
        position: const Offset(0.3, 0.4),
        radius: 0.5,
      );

      expect(point.color, equals(Colors.blue));
      expect(point.position, equals(const Offset(0.3, 0.4)));
      expect(point.radius, equals(0.5));

      final updated = point.copyWith(
        color: Colors.red,
        position: const Offset(0.7, 0.8),
      );

      expect(updated.color, equals(Colors.red));
      expect(updated.position, equals(const Offset(0.7, 0.8)));
      expect(updated.radius, equals(0.5));
    });

    test('MeshPalette provides non-empty curated palettes', () {
      expect(MeshPalette.stripeAurora().length, equals(4));
      expect(MeshPalette.iosSunset().length, equals(4));
      expect(MeshPalette.cyberNeon().length, equals(3));
      expect(MeshPalette.cottonCandy().length, equals(4));
      expect(MeshPalette.darkOasis().length, equals(4));
    });
  });
}
