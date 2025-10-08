import 'package:flutter/material.dart';
import 'main_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      {
        'title': 'Know Market Prices',
        'subtitle':
            'See prices across nearby mandis and choose best place to sell.',
      },
      {
        'title': 'Compare & Save',
        'subtitle': 'Compare price after transport and choose the right mandi.',
      },
      {
        'title': 'Alerts & Advice',
        'subtitle': 'Set a target price and get notified when reached.',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              itemCount: pages.length,
              itemBuilder: (context, idx) {
                final p = pages[idx];
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Text(p['title']!,
                            style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 16),
                        Text(p['subtitle']!, textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        Image.network(
                            'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=700&q=80',
                            height: 200),
                      ]),
                );
              },
            ),
          ),
         Padding(
  padding: const EdgeInsets.all(16.0),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6D4C41),
      // 1. Increased the height slightly for a bigger button
      minimumSize: const Size.fromHeight(52),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    },
    // 2. Replaced the Text widget with a Stack for the stroke effect
    child: Stack(
      children: <Widget>[
        // Background text creates the stroke
        Text(
          'Get Started',
          style: TextStyle(
            fontSize: 16,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5 // Adjust stroke thickness here
              ..color = Colors.black.withOpacity(0.6), // Stroke color
          ),
        ),
        // Foreground text is the main fill
        const Text(
          'Get Started',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white, // Main text color
          ),
        ),
      ],
    ),
  ),
),
        ]),
      ),
    );
  }
}