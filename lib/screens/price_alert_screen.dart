import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class PriceAlertScreen extends StatefulWidget {
  const PriceAlertScreen({super.key});

  @override
  State<PriceAlertScreen> createState() => _PriceAlertScreenState();
}

class _PriceAlertScreenState extends State<PriceAlertScreen> {
  String selectedProduct = 'Cashew';
  double targetPrice = 0.0;
  double currentPrice = 0.0;
  TextEditingController targetController = TextEditingController();
  Timer? _timer;
  final Random _random = Random();

  final Map<String, double> basePrices = {
    'Cashew': 100.0,
    'Jackfruit': 50.0,
    'Honey': 120.0,
    'Rice': 60.0,
  };

  @override
  void initState() {
    super.initState();
    // Initialize notifications
    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
        InitializationSettings(android: initSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initSettings);

    // Start periodic price check
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _checkPrice());
  }

  @override
  void dispose() {
    _timer?.cancel();
    targetController.dispose();
    super.dispose();
  }

  void _checkPrice() {
    final price = _getMockPrice(selectedProduct);
    setState(() {
      currentPrice = price;
    });

    if (targetPrice > 0 && currentPrice >= targetPrice) {
      _showNotification(selectedProduct, currentPrice);
      // Optional: reset targetPrice so it doesn't spam notifications
      targetPrice = 0.0;
    }
  }

  double _getMockPrice(String product) {
    // Simulate small random changes
    final base = basePrices[product]!;
    return base + _random.nextInt(10) - 3; // e.g., ±3 fluctuation
  }

  Future<void> _showNotification(String product, double price) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'price_alerts',
      'Price Alerts',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails generalDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      '🎯 $product Target Reached!',
      '$product price is now ₹${price.toStringAsFixed(0)}',
      generalDetails,
    );
  }

  void _setAlert() {
    final entered = double.tryParse(targetController.text);
    if (entered == null || entered <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a valid target price')));
      return;
    }

    setState(() {
      targetPrice = entered;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Alert set for $selectedProduct at ₹${targetPrice.toStringAsFixed(0)}')),
    );

    targetController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Alerts'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedProduct,
              items: basePrices.keys
                  .map((product) => DropdownMenuItem(
                        value: product,
                        child: Text(product),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => selectedProduct = value!),
              decoration: const InputDecoration(
                labelText: 'Select Product',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Target Price (₹)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _setAlert,
              icon: const Icon(Icons.notifications_active),
              label: const Text('Set Alert'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Current Price of $selectedProduct: ₹${currentPrice.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Price updates every 5 seconds',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
