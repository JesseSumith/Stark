import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../providers/product_provider.dart';
import '../providers/locale_provider.dart';
import '../main.dart' as main; // for notifications
import 'price_alert_screen.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Check prices every 10 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _checkAlerts());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _checkAlerts() {
    final prov = context.read<ProductProvider>();
    prov.alerts.forEach((productId, targetPrice) {
      final currentPrice = _getMockPrice(); // Replace with API call later
      if (currentPrice >= targetPrice) {
        _showNotification(
            prov.findById(productId)?.name ?? 'Product', currentPrice);
      }
    });
    setState(() {}); // Refresh UI to show updated current prices
  }

  double _getMockPrice() {
    return 50 + _random.nextInt(100).toDouble();
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

    await main.flutterLocalNotificationsPlugin.show(
      0,
      '🎯 $product Target Reached!',
      '$product is now ₹${price.toStringAsFixed(0)}',
      generalDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ProductProvider>();
    final locale = context.watch<LocaleProvider>();
    final alerts = prov.alerts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Alerts'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: alerts.isEmpty
              ? Center(
                  child: Text(locale.translate(
                      en: 'No alerts set', te: 'ఏ అలారమ్స్ లేదు')),
                )
              : ListView(
                  children: alerts.entries.map((entry) {
                    final product = prov.findById(entry.key);
                    final targetPrice = entry.value;
                    final currentPrice =
                        _getMockPrice(); // replace with real API

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(
                          product?.name ?? 'Product',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${locale.translate(en: "Target Price", te: "లక్ష్య ధర")}: ₹${targetPrice.toStringAsFixed(0)}'),
                            Text(
                                '${locale.translate(en: "Current Price", te: "ప్రస్తుత ధర")}: ₹${currentPrice.toStringAsFixed(0)}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => prov.removeAlert(entry.key),
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
