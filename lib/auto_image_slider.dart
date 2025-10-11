import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AutoImageSlider extends StatefulWidget {
  const AutoImageSlider({super.key});

  @override
  State<AutoImageSlider> createState() => _AutoImageSliderState();
}

class _AutoImageSliderState extends State<AutoImageSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _images = [
    'assets/images/one.png',
    'assets/images/two.png',
    'assets/images/three.png',
  ];

  @override
  void initState() {
    super.initState();

    // Auto slide timer
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
  controller: _pageController,
  itemCount: _images.length,
  onPageChanged: (index) {
    setState(() {
      _currentPage = index;
    });
  },
  itemBuilder: (context, index) {
    return Image.asset(
      _images[index],
      fit: BoxFit.cover,
    );
  },
),

        ),
        const SizedBox(height: 12),
        // Page indicator (the dots)
        SmoothPageIndicator(
          controller: _pageController,
          count: _images.length,
          effect: const WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Colors.green,
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
