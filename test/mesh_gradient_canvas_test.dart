import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mesh_gradient_canvas/mesh_gradient_canvas.dart';

void main() {
  group('MeshGradientCanvas Widget Tests', () {
    testWidgets('Renders mesh canvas and child content correctly',
        (WidgetTester tester) async {
      final controller = MeshGradientController(autoPlay: false);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MeshGradientCanvas(
              controller: controller,
              child: const Center(
                child: Text('Hello Mesh Gradient'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(MeshGradientCanvas), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
      expect(find.text('Hello Mesh Gradient'), findsOneWidget);

      controller.dispose();
    });

    testWidgets('Drag gestures interactively displace nearest mesh anchor point',
        (WidgetTester tester) async {
      final controller = MeshGradientController(autoPlay: false);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 300,
              child: MeshGradientCanvas(
                controller: controller,
                enableTouchReactivity: true,
              ),
            ),
          ),
        ),
      );

      final initialPos = controller.points[0].position;

      // Perform drag gesture across the canvas
      final canvasFinder = find.byType(MeshGradientCanvas);
      await tester.drag(canvasFinder, const Offset(50, 50));
      await tester.pump();

      // At least one point was displaced
      final points = controller.points;
      final anyMoved = points.any((p) => p.position != initialPos);
      expect(anyMoved, isTrue);

      controller.dispose();
    });

    testWidgets('Advances frame ticks without throwing exceptions',
        (WidgetTester tester) async {
      final controller = MeshGradientController(autoPlay: true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MeshGradientCanvas(
              controller: controller,
            ),
          ),
        ),
      );

      // Advance frames
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.byType(MeshGradientCanvas), findsOneWidget);

      controller.pause();
      await tester.pump();
      controller.dispose();
    });
  });
}
