import 'package:flutter/material.dart';
import 'package:mesh_gradient_canvas/mesh_gradient_canvas.dart';

void main() {
  runApp(const MeshGradientExampleApp());
}

class MeshGradientExampleApp extends StatelessWidget {
  const MeshGradientExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mesh Gradient Canvas Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090D16),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6366F1),
          surface: Color(0xFF131926),
        ),
        useMaterial3: true,
      ),
      home: const MeshShowcaseScreen(),
    );
  }
}

class MeshShowcaseScreen extends StatefulWidget {
  const MeshShowcaseScreen({super.key});

  @override
  State<MeshShowcaseScreen> createState() => _MeshShowcaseScreenState();
}

class _MeshShowcaseScreenState extends State<MeshShowcaseScreen> {
  final MeshGradientController _controller = MeshGradientController(
    initialPoints: MeshPalette.stripeAurora(),
    speed: 1.0,
  );

  int _selectedPaletteIndex = 0;
  double _blurRadius = 55.0;

  final List<Map<String, dynamic>> _palettes = [
    {'name': 'Stripe Aurora', 'points': MeshPalette.stripeAurora()},
    {'name': 'iOS Sunset', 'points': MeshPalette.iosSunset()},
    {'name': 'Cyber Neon', 'points': MeshPalette.cyberNeon()},
    {'name': 'Cotton Candy', 'points': MeshPalette.cottonCandy()},
    {'name': 'Dark Oasis', 'points': MeshPalette.darkOasis()},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchPalette(int index) {
    setState(() {
      _selectedPaletteIndex = index;
      _controller.setPoints(_palettes[index]['points']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Mesh Gradient Canvas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: MeshGradientCanvas(
        controller: _controller,
        blurRadius: _blurRadius,
        enableTouchReactivity: true,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Tip pill
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(90),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Text(
                  '✨ Drag anywhere on screen to physically displace mesh blobs',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ),
              const Spacer(),

              // Glassmorphic Hero Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(120),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white.withAlpha(35), width: 1.2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x55000000),
                      blurRadius: 30,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Fluid Color Dynamics',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Stripe and iOS 18 inspired organic mesh gradients. Rendered at smooth 120 FPS using high-performance custom radial shaders.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFCBD5E1),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Palette Selector Pills
                    SizedBox(
                      height: 34,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _palettes.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final item = _palettes[index];
                          final isSelected = _selectedPaletteIndex == index;
                          return ChoiceChip(
                            label: Text(item['name']),
                            selected: isSelected,
                            selectedColor: const Color(0xFF6366F1).withAlpha(180),
                            onSelected: (_) => _switchPalette(index),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Controls Row: Play/Pause, Speed, Blur Slider
                    Row(
                      children: [
                        IconButton.filledTonal(
                          icon: Icon(
                            _controller.isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.togglePlayPause();
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Blur Diffusion: ${_blurRadius.toStringAsFixed(0)}px',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white70,
                                ),
                              ),
                              Slider(
                                value: _blurRadius,
                                min: 10.0,
                                max: 90.0,
                                onChanged: (val) => setState(() => _blurRadius = val),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
