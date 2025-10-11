import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'products_screen.dart';
import 'advisory_screen.dart';
import 'alerts_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  late AnimationController _controller;

  final _pages = const [
    HomeScreen(),
    ProductsScreen(),
    AdvisoryScreen(),
    AlertsScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _onItemTapped(int i) {
    _controller.forward(from: 0.0);
    setState(() {
      _index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0.02),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _pages[_index],
      ),
      bottomNavigationBar: CustomPaint(
        painter: _WavePainter(_index, _controller),
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (i) {
              final isSelected = _index == i;
              final iconData = [
                Icons.home_rounded,
                Icons.grid_view_rounded,
                Icons.map_rounded,
                Icons.notifications_rounded,
                Icons.settings_rounded,
              ][i];

              return GestureDetector(
                onTap: () => _onItemTapped(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    iconData,
                    size: isSelected ? 32 : 28,
                    color: isSelected ? Colors.green.shade600 : Colors.grey,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _WavePainter extends CustomPainter {
  final int selectedIndex;
  final AnimationController controller;

  _WavePainter(this.selectedIndex, this.controller)
      : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    double waveHeight = 20 * controller.value;

    double step = size.width / 5;
    double centerX = step * selectedIndex + step / 2;

    path.moveTo(0, 0);
    path.lineTo(centerX - step / 2, 0);
    path.quadraticBezierTo(
        centerX, waveHeight, centerX + step / 2, 0); // wavy curve
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) => true;
}
