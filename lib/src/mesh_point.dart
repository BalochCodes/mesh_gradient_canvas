import 'package:flutter/material.dart';

/// Represents a single floating color control point inside a [MeshGradientCanvas].
class MeshPoint {
  /// Color of the control blob.
  final Color color;

  /// Normalized position coordinates (range `0.0` to `1.0`).
  Offset position;

  /// Normalized radius relative to canvas dimensions (range `0.1` to `1.0`). Defaults to `0.45`.
  final double radius;

  /// Velocity vector directing autonomous drift.
  Offset velocity;

  /// Unique oscillation phase offset for sine-wave physics.
  final double phase;

  /// Amplitude of harmonic drift oscillation.
  final double driftAmplitude;

  MeshPoint({
    required this.color,
    required this.position,
    this.radius = 0.45,
    this.velocity = const Offset(0.12, 0.08),
    this.phase = 0.0,
    this.driftAmplitude = 0.15,
  });

  /// Creates a copy of this [MeshPoint] with optional modifications.
  MeshPoint copyWith({
    Color? color,
    Offset? position,
    double? radius,
    Offset? velocity,
    double? phase,
    double? driftAmplitude,
  }) {
    return MeshPoint(
      color: color ?? this.color,
      position: position ?? this.position,
      radius: radius ?? this.radius,
      velocity: velocity ?? this.velocity,
      phase: phase ?? this.phase,
      driftAmplitude: driftAmplitude ?? this.driftAmplitude,
    );
  }
}
