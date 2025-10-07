import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AutoCarousel extends StatefulWidget {
  final List<Widget> items;
  final double height;

  const AutoCarousel({super.key, required this.items, this.height = 180});

  @override
  State<AutoCarousel> createState() => _AutoCarouselState();
}

class _AutoCarouselState extends State<AutoCarousel> {
  late final PageController _controller;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.85);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (_controller.hasClients && widget.items.isNotEmpty) {
        _current = (_current + 1) % widget.items.length;
        _controller.animateToPage(
          _current,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return widget.items[index]
              .animate()
              .fade(duration: 400.ms)
              .slideY(begin: 0.1, duration: 400.ms);
        },
      ),
    );
  }
}
