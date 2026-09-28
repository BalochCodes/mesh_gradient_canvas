import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'mesh_gradient_controller.dart';
import 'mesh_palette.dart';
import 'mesh_point.dart';
import 'widgets/mesh_painter.dart';

/// An organic, multi-color mesh gradient canvas inspired by Stripe and iOS 18
/// design systems, featuring floating color blobs, touch reactivity, and fluid physics.
class MeshGradientCanvas extends StatefulWidget {
  /// Initial control points defining the mesh gradient blobs.
  /// Defaults to [MeshPalette.stripeAurora].
  final List<MeshPoint>? points;

  /// External programmatic controller to pause, play, or update points.
  final MeshGradientController? controller;

  /// Canvas background base color. Defaults to deep navy `Color(0xFF0B0F19)`.
  final Color backgroundColor;

  /// Sigma blur intensity applied across the entire mesh canvas. Defaults to `50.0`.
  final double blurRadius;

  /// Blend mode used when layering radial color blobs. Defaults to [BlendMode.srcOver].
  final BlendMode blendMode;

  /// Whether user pan/drag gestures interactively displace the nearest control point.
  final bool enableTouchReactivity;

  /// Optional child widget displayed directly over the fluid mesh background.
  final Widget? child;

  const MeshGradientCanvas({
    super.key,
    this.points,
    this.controller,
    this.backgroundColor = const Color(0xFF0B0F19),
    this.blurRadius = 50.0,
    this.blendMode = BlendMode.srcOver,
    this.enableTouchReactivity = true,
    this.child,
  });

  @override
  State<MeshGradientCanvas> createState() => _MeshGradientCanvasState();
}

class _MeshGradientCanvasState extends State<MeshGradientCanvas>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  MeshGradientController? _internalController;
  MeshGradientController get _effectiveController =>
      widget.controller ??
      (_internalController ??= MeshGradientController(
        initialPoints: widget.points ?? MeshPalette.stripeAurora(),
      ));

  int? _activeDraggedIndex;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    if (_effectiveController.isPlaying) {
      _ticker.start();
    }

    _effectiveController.addListener(_onControllerUpdate);
  }

  @override
  void didUpdateWidget(covariant MeshGradientCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onControllerUpdate);
      _effectiveController.addListener(_onControllerUpdate);
    }
  }

  void _onTick(Duration elapsed) {
    if (_lastElapsed == Duration.zero) {
      _lastElapsed = elapsed;
      return;
    }
    final double dt = (elapsed.inMicroseconds - _lastElapsed.inMicroseconds) / 1000000.0;
    _lastElapsed = elapsed;

    if (_effectiveController.isPlaying) {
      _effectiveController.stepPhysics(dt.clamp(0.0, 0.1));
    }
  }

  void _onControllerUpdate() {
    if (!mounted) return;
    if (_effectiveController.isPlaying && !_ticker.isActive) {
      _lastElapsed = Duration.zero;
      _ticker.start();
    } else if (!_effectiveController.isPlaying && _ticker.isActive) {
      _ticker.stop();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _ticker.dispose();
    widget.controller?.removeListener(_onControllerUpdate);
    _internalController?.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details, Size size) {
    if (!widget.enableTouchReactivity || size.width <= 0 || size.height <= 0) return;

    final touchNormalized = Offset(
      details.localPosition.dx / size.width,
      details.localPosition.dy / size.height,
    );

    // Find nearest point index
    double minDistance = double.infinity;
    int nearestIndex = 0;

    final points = _effectiveController.points;
    for (int i = 0; i < points.length; i++) {
      final dist = (points[i].position - touchNormalized).distance;
      if (dist < minDistance) {
        minDistance = dist;
        nearestIndex = i;
      }
    }

    _activeDraggedIndex = nearestIndex;
  }

  void _onPanUpdate(DragUpdateDetails details, Size size) {
    if (!widget.enableTouchReactivity || _activeDraggedIndex == null || size.width <= 0) return;

    final deltaNormalized = Offset(
      details.delta.dx / size.width,
      details.delta.dy / size.height,
    );

    _effectiveController.displacePoint(_activeDraggedIndex!, deltaNormalized);
  }

  void _onPanEnd(DragEndDetails details) {
    _activeDraggedIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        final canvasContent = Stack(
          fit: StackFit.expand,
          children: [
            // 1. Organic Mesh CustomPainter
            CustomPaint(
              painter: MeshPainter(
                points: _effectiveController.points,
                backgroundColor: widget.backgroundColor,
                blendMode: widget.blendMode,
              ),
              size: size,
            ),

            // 2. High-Quality Gaussian Diffusion Blur
            if (widget.blurRadius > 0)
              ClipRect(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: widget.blurRadius,
                    sigmaY: widget.blurRadius,
                    tileMode: TileMode.clamp,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),

            // 3. User Child Overlay
            if (widget.child != null) widget.child!,
          ],
        );

        if (!widget.enableTouchReactivity) {
          return canvasContent;
        }

        return GestureDetector(
          onPanStart: (details) => _onPanStart(details, size),
          onPanUpdate: (details) => _onPanUpdate(details, size),
          onPanEnd: _onPanEnd,
          behavior: HitTestBehavior.translucent,
          child: canvasContent,
        );
      },
    );
  }
}
