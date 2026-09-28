import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mesh_gradient_canvas/mesh_gradient_canvas.dart';

void main() {
  group('MeshGradientController Tests', () {
    test('Initializes with default points and playing state', () {
      final controller = MeshGradientController();

      expect(controller.isPlaying, isTrue);
      expect(controller.speed, equals(1.0));
      expect(controller.points.isNotEmpty, isTrue);
      controller.dispose();
    });

    test('play, pause, and togglePlayPause update playing state correctly', () {
      final controller = MeshGradientController(autoPlay: true);

      controller.pause();
      expect(controller.isPlaying, isFalse);

      controller.play();
      expect(controller.isPlaying, isTrue);

      controller.togglePlayPause();
      expect(controller.isPlaying, isFalse);
      controller.dispose();
    });

    test('displacePoint updates target point within normalized boundaries', () {
      final controller = MeshGradientController();
      final originalPos = controller.points[0].position;

      controller.displacePoint(0, const Offset(0.1, -0.05));
      final newPos = controller.points[0].position;

      expect(newPos.dx, closeTo(originalPos.dx + 0.1, 0.001));
      expect(newPos.dy, closeTo(originalPos.dy - 0.05, 0.001));
      controller.dispose();
    });

    test('stepPhysics updates coordinates over time', () {
      final controller = MeshGradientController();
      final initialPos = controller.points[0].position;

      controller.stepPhysics(0.5);
      final steppedPos = controller.points[0].position;

      expect(steppedPos, isNot(equals(initialPos)));
      controller.dispose();
    });

    test('addPoint and setPoints update point list and notify listeners', () {
      final controller = MeshGradientController();
      int notifyCount = 0;
      controller.addListener(() => notifyCount++);

      controller.addPoint(
        MeshPoint(color: Colors.amber, position: const Offset(0.5, 0.5)),
      );
      expect(notifyCount, equals(1));

      controller.setPoints([
        MeshPoint(color: Colors.cyan, position: const Offset(0.1, 0.1)),
      ]);
      expect(controller.points.length, equals(1));
      expect(notifyCount, equals(2));
      controller.dispose();
    });
  });
}
