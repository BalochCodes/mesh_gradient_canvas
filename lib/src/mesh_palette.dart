import 'package:flutter/material.dart';
import 'mesh_point.dart';

/// Predefined curated color palettes and anchor positions for [MeshGradientCanvas].
class MeshPalette {
  /// Iconic Stripe-inspired deep indigo, electric cyan, and emerald aurora.
  static List<MeshPoint> stripeAurora() {
    return [
      MeshPoint(
        color: const Color(0xFF6366F1), // Indigo
        position: const Offset(0.2, 0.25),
        radius: 0.55,
        velocity: const Offset(0.08, 0.12),
        phase: 0.0,
      ),
      MeshPoint(
        color: const Color(0xFF06B6D4), // Cyan
        position: const Offset(0.8, 0.3),
        radius: 0.50,
        velocity: const Offset(-0.10, 0.09),
        phase: 1.5,
      ),
      MeshPoint(
        color: const Color(0xFF10B981), // Emerald
        position: const Offset(0.3, 0.8),
        radius: 0.60,
        velocity: const Offset(0.12, -0.07),
        phase: 3.0,
      ),
      MeshPoint(
        color: const Color(0xFF8B5CF6), // Violet
        position: const Offset(0.85, 0.85),
        radius: 0.52,
        velocity: const Offset(-0.09, -0.11),
        phase: 4.5,
      ),
    ];
  }

  /// Apple iOS 18 warm sunset with vibrant peach, amber, and violet.
  static List<MeshPoint> iosSunset() {
    return [
      MeshPoint(
        color: const Color(0xFFFF5E62), // Coral
        position: const Offset(0.25, 0.2),
        radius: 0.55,
        velocity: const Offset(0.09, 0.07),
        phase: 0.5,
      ),
      MeshPoint(
        color: const Color(0xFFFF9966), // Peach
        position: const Offset(0.75, 0.25),
        radius: 0.48,
        velocity: const Offset(-0.08, 0.11),
        phase: 2.0,
      ),
      MeshPoint(
        color: const Color(0xFFC026D3), // Magenta
        position: const Offset(0.35, 0.85),
        radius: 0.60,
        velocity: const Offset(0.11, -0.09),
        phase: 3.5,
      ),
      MeshPoint(
        color: const Color(0xFF7C3AED), // Deep Purple
        position: const Offset(0.8, 0.75),
        radius: 0.52,
        velocity: const Offset(-0.07, -0.08),
        phase: 5.0,
      ),
    ];
  }

  /// Futuristic cyber neon glow against dark backgrounds.
  static List<MeshPoint> cyberNeon() {
    return [
      MeshPoint(
        color: const Color(0xFF00F0FF), // Neon Cyan
        position: const Offset(0.2, 0.3),
        radius: 0.48,
        velocity: const Offset(0.12, 0.06),
        phase: 0.0,
      ),
      MeshPoint(
        color: const Color(0xFFFF007F), // Neon Pink
        position: const Offset(0.8, 0.2),
        radius: 0.52,
        velocity: const Offset(-0.07, 0.10),
        phase: 1.8,
      ),
      MeshPoint(
        color: const Color(0xFF7000FF), // Electric Purple
        position: const Offset(0.5, 0.8),
        radius: 0.58,
        velocity: const Offset(0.09, -0.11),
        phase: 3.6,
      ),
    ];
  }

  /// Soft airy pastel cotton candy palette.
  static List<MeshPoint> cottonCandy() {
    return [
      MeshPoint(
        color: const Color(0xFFBAE6FD), // Sky Blue
        position: const Offset(0.2, 0.2),
        radius: 0.55,
        velocity: const Offset(0.06, 0.08),
        phase: 0.0,
      ),
      MeshPoint(
        color: const Color(0xFFFBCFE8), // Baby Pink
        position: const Offset(0.8, 0.3),
        radius: 0.50,
        velocity: const Offset(-0.08, 0.07),
        phase: 1.6,
      ),
      MeshPoint(
        color: const Color(0xFFE9D5FF), // Lilac
        position: const Offset(0.3, 0.8),
        radius: 0.52,
        velocity: const Offset(0.07, -0.06),
        phase: 3.2,
      ),
      MeshPoint(
        color: const Color(0xFFFEF08A), // Soft Lemon
        position: const Offset(0.75, 0.75),
        radius: 0.45,
        velocity: const Offset(-0.06, -0.08),
        phase: 4.8,
      ),
    ];
  }

  /// Mysterious midnight teal and deep sapphire oasis.
  static List<MeshPoint> darkOasis() {
    return [
      MeshPoint(
        color: const Color(0xFF0F766E), // Teal
        position: const Offset(0.25, 0.25),
        radius: 0.55,
        velocity: const Offset(0.08, 0.09),
        phase: 0.2,
      ),
      MeshPoint(
        color: const Color(0xFF1E3A8A), // Sapphire
        position: const Offset(0.75, 0.3),
        radius: 0.50,
        velocity: const Offset(-0.09, 0.08),
        phase: 1.9,
      ),
      MeshPoint(
        color: const Color(0xFF047857), // Deep Emerald
        position: const Offset(0.4, 0.8),
        radius: 0.58,
        velocity: const Offset(0.10, -0.07),
        phase: 3.7,
      ),
      MeshPoint(
        color: const Color(0xFF4338CA), // Deep Indigo
        position: const Offset(0.85, 0.75),
        radius: 0.48,
        velocity: const Offset(-0.07, -0.10),
        phase: 5.2,
      ),
    ];
  }
}
