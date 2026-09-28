# mesh_gradient_canvas 🎨

An organic, multi-color mesh gradient canvas for Flutter inspired by Stripe and iOS 18 design systems, featuring floating color blobs, touch reactivity, and fluid harmonic physics.

[![pub package](https://img.shields.io/pub/v/mesh_gradient_canvas.svg)](https://pub.dev/packages/mesh_gradient_canvas)
[![pub points](https://img.shields.io/pub/points/mesh_gradient_canvas?color=2E8B57&label=pub%20points)](https://pub.dev/packages/mesh_gradient_canvas/score)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/BalochCodes/mesh_gradient_canvas?style=social)](https://github.com/BalochCodes/mesh_gradient_canvas)

Replace flat, rigid linear gradients with fluid, organic multi-point mesh gradients. `mesh_gradient_canvas` renders floating color blobs that drift across the screen using organic sine-wave physics and respond interactively to touch and drag gestures.

---

## ✨ Features

- 🌊 **Stripe & iOS 18 Aesthetics:** Soft, diffused multi-color mesh gradients that give apps a premium, modern feel.
- ⚡ **120 FPS Performance:** Pure Flutter custom radial shader painting with GPU-accelerated backdrop blur diffusion.
- 🧲 **Interactive Touch Physics:** Users can drag across the canvas to physically pull and displace mesh color anchors.
- 🌀 **Autonomous Fluid Drift:** Built-in harmonic sine-wave oscillation keeps the background alive with gentle motion.
- 🎨 **Prebuilt Factory Palettes:** Instant access to Stripe Aurora, iOS Sunset, Cyber Neon, Cotton Candy, and Dark Oasis.
- 🎛️ **Full Controller Support:** Programmatic play, pause, speed adjustment, and live point manipulation via `MeshGradientController`.
- 📦 **Zero Heavy Dependencies:** Pure Flutter rendering with zero external C++/native dependencies.

---

## 📦 Installation

Add `mesh_gradient_canvas` to your Flutter project:

```bash
flutter pub add mesh_gradient_canvas
```

Or add it directly to your `pubspec.yaml`:

```yaml
dependencies:
  mesh_gradient_canvas: ^0.0.1
```

---

## 🚀 Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:mesh_gradient_canvas/mesh_gradient_canvas.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MeshGradientCanvas(
        blurRadius: 50.0,
        enableTouchReactivity: true,
        child: const Center(
          child: Text(
            'Welcome to the Future',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## 💡 Advanced Examples

### 1. Using Prebuilt Palettes

```dart
// Apple iOS 18 Warm Sunset
MeshGradientCanvas(
  points: MeshPalette.iosSunset(),
  blurRadius: 60.0,
)

// Cyberpunk Neon Glow
MeshGradientCanvas(
  points: MeshPalette.cyberNeon(),
  backgroundColor: Color(0xFF05050A),
  blurRadius: 45.0,
)
```

### 2. Programmatic Controller & Speed Control

```dart
final MeshGradientController _controller = MeshGradientController(
  initialPoints: MeshPalette.stripeAurora(),
  speed: 1.5,
);

// Toggle playback or adjust speed
_controller.pause();
_controller.play();
_controller.setSpeed(2.0);

// Embed into UI
MeshGradientCanvas(
  controller: _controller,
  child: MyForegroundContent(),
)
```

### 3. Custom Color Anchors

```dart
MeshGradientCanvas(
  points: [
    MeshPoint(
      color: Colors.deepPurple,
      position: Offset(0.2, 0.2),
      radius: 0.6,
    ),
    MeshPoint(
      color: Colors.cyanAccent,
      position: Offset(0.8, 0.3),
      radius: 0.5,
    ),
    MeshPoint(
      color: Colors.pinkAccent,
      position: Offset(0.5, 0.8),
      radius: 0.7,
    ),
  ],
)
```

---

## ⚙️ Properties & Customization

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `points` | `List<MeshPoint>?` | `MeshPalette.stripeAurora()` | List of floating color control points. |
| `controller` | `MeshGradientController?` | `null` | Programmatic drift and speed controller. |
| `backgroundColor` | `Color` | `Color(0xFF0B0F19)` | Base canvas background color. |
| `blurRadius` | `double` | `50.0` | Gaussian blur diffusion sigma. |
| `blendMode` | `BlendMode` | `BlendMode.srcOver` | Radial gradient shader blend mode. |
| `enableTouchReactivity` | `bool` | `true` | Enables interactive touch drag displacement. |
| `child` | `Widget?` | `null` | Optional foreground content layered above canvas. |

---

## 🖼️ Example Showcase

Explore the interactive onboarding and playground in [`example/lib/main.dart`](example/lib/main.dart).

---

## 🤝 Contributing

Contributions, bug reports, and suggestions are welcome! Feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/BalochCodes/mesh_gradient_canvas).

---

## 📄 License

This package is licensed under the MIT License. See [LICENSE](LICENSE) for details.

Copyright (c) 2026 BalochCodes.

---

## 👨‍💻 Author

Developed with ❤️ by **Shahzain Baloch** ([BalochCodes](https://github.com/BalochCodes)).
