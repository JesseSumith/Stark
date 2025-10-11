import 'dart:async';
import 'package:flutter/material.dart';
import 'main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'title': 'Know Market Prices',
      'subtitle':
          'See prices across nearby mandis and choose best place to sell.',
      'image':
          'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=700&q=80',
    },
    {
      'title': 'Compare & Save',
      'subtitle': 'Compare price after transport and choose the right mandi.',
      'image':
          'https://images.unsplash.com/photo-1500534623283-312aade485b7?w=700&q=80',
    },
    {
      'title': 'Alerts & Advice',
      'subtitle': 'Set a target price and get notified when reached.',
      'image':
          'https://images.unsplash.com/photo-1506784983877-45594efa4cbe?w=700&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Auto slide every 3 seconds
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_currentPage < pages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              itemBuilder: (context, idx) {
                final p = pages[idx];
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        p['title']!,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        p['subtitle']!,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Image.network(
                        p['image']!,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // --- Get Started Button ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6D4C41),
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
              child: Stack(
                children: <Widget>[
                  Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.5
                        ..color = Colors.black.withOpacity(0.6),
                    ),
                  ),
                  const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
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
