import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'mesh_palette.dart';
import 'mesh_point.dart';

/// Programmatic controller driving floating physics, speeds, and anchor displacements
/// for a [MeshGradientCanvas].
class MeshGradientController extends ChangeNotifier {
  List<MeshPoint> _points;
  bool _isPlaying;
  double _speed;
  double _elapsedTime = 0.0;

  MeshGradientController({
    List<MeshPoint>? initialPoints,
    bool autoPlay = true,
    double speed = 1.0,
  })  : _points = initialPoints ?? MeshPalette.stripeAurora(),
        _isPlaying = autoPlay,
        _speed = speed;

  /// Current list of active control points.
  List<MeshPoint> get points => _points;

  /// Whether autonomous drift animation is running.
  bool get isPlaying => _isPlaying;

  /// Animation speed multiplier.
  double get speed => _speed;

  /// Starts drift animation.
  void play() {
    if (!_isPlaying) {
      _isPlaying = true;
      notifyListeners();
    }
  }

  /// Pauses drift animation.
  void pause() {
    if (_isPlaying) {
      _isPlaying = false;
      notifyListeners();
    }
  }

  /// Toggles between play and pause.
  void togglePlayPause() {
    if (_isPlaying) {
      pause();
    } else {
      play();
    }
  }

  /// Sets playback speed multiplier.
  void setSpeed(double newSpeed) {
    if (_speed != newSpeed) {
      _speed = newSpeed.clamp(0.1, 5.0);
      notifyListeners();
    }
  }

  /// Replaces the active control points.
  void setPoints(List<MeshPoint> newPoints) {
    _points = List.from(newPoints);
    notifyListeners();
  }

  /// Adds a new control point to the canvas.
  void addPoint(MeshPoint point) {
    _points.add(point);
    notifyListeners();
  }

  /// Interactively moves a specific control point (e.g. during user drag).
  void displacePoint(int index, Offset normalizedDelta) {
    if (index >= 0 && index < _points.length) {
      final p = _points[index];
      final newPos = Offset(
        (p.position.dx + normalizedDelta.dx).clamp(0.0, 1.0),
        (p.position.dy + normalizedDelta.dy).clamp(0.0, 1.0),
      );
      p.position = newPos;
      notifyListeners();
    }
  }

  /// Advances physics simulation by delta time in seconds.
  void stepPhysics(double dt) {
    if (!_isPlaying) return;

    _elapsedTime += dt * _speed;

    for (final p in _points) {
      final double waveX = math.sin(_elapsedTime + p.phase) * p.driftAmplitude;
      final double waveY = math.cos(_elapsedTime * 0.8 + p.phase) * p.driftAmplitude;

      final double nextX = (p.position.dx + (waveX * p.velocity.dx * dt * _speed)).clamp(-0.1, 1.1);
      final double nextY = (p.position.dy + (waveY * p.velocity.dy * dt * _speed)).clamp(-0.1, 1.1);

      p.position = Offset(nextX, nextY);
    }
    notifyListeners();
  }
}
