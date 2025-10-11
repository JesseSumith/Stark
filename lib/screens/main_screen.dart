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
  int _previousIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

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
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  void _onItemTapped(int i) {
    setState(() {
      _previousIndex = _index;
      _index = i;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final step = width / 5;

    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_index],
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return CustomPaint(
                  size: Size(width, 80),
                  painter: _SlidingWavePainter(
                    previousIndex: _previousIndex,
                    selectedIndex: _index,
                    animationValue: _animation.value,
                    step: step,
                    width: width,
                  ),
                );
              },
            ),
            Row(
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
                      color: isSelected
                          ? Colors.green.shade600
                          : Colors.grey.shade600,
                    ),
                  ),
                );
              }),
            ),
          ],
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

class _SlidingWavePainter extends CustomPainter {
  final int previousIndex;
  final int selectedIndex;
  final double animationValue;
  final double step;
  final double width;

  _SlidingWavePainter({
    required this.previousIndex,
    required this.selectedIndex,
    required this.animationValue,
    required this.step,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Calculate horizontal wave position (smooth slide)
    double startX = previousIndex * step + step / 2;
    double endX = selectedIndex * step + step / 2;
    double currentX = startX + (endX - startX) * animationValue;

    double waveHeight = 25;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(currentX - step / 2, 0);
    path.quadraticBezierTo(currentX, -waveHeight, currentX + step / 2, 0);
    path.lineTo(width, 0);
    path.lineTo(width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SlidingWavePainter oldDelegate) => true;
}
