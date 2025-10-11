import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> banners = [
    {
      'image':
          'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=1200&q=80',
      'title': 'Know Market Prices',
      'subtitle': 'Compare nearby mandis and choose the best deal.',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1500534623283-312aade485b7?w=1200&q=80',
      'title': 'Compare & Save',
      'subtitle': 'Analyze transport cost and maximize your profit.',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1506784983877-45594efa4cbe?w=1200&q=80',
      'title': 'Get Alerts & Advice',
      'subtitle': 'Stay informed with smart notifications and insights.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_controller.hasClients) {
        int next = _currentPage + 1;
        if (next >= banners.length) next = 0;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });

    _controller.addListener(() {
      int newPage = _controller.page!.round();
      if (_currentPage != newPage) {
        setState(() => _currentPage = newPage);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // 🟩 Animated Banner Section
            SizedBox(
              height: 240,
              child: PageView.builder(
                controller: _controller,
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  final scale =
                      _currentPage == index ? 1.0 : 0.9; // parallax feel

                  return AnimatedScale(
                    scale: scale,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Background Image
                            ShaderMask(
                              shaderCallback: (rect) => LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.2),
                                  Colors.black.withOpacity(0.5),
                                ],
                              ).createShader(rect),
                              blendMode: BlendMode.darken,
                              child: Image.network(
                                banner['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Text Overlay
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    banner['title']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    banner['subtitle']!,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🟡 Dots Indicator
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.green.shade600
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Example Placeholder Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Text(
                    "Welcome back!",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Here's the latest market insight and updates near you.",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text("📊 Market Overview Coming Soon"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
