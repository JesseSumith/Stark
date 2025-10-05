import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/locale_provider.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ProductProvider>();
    final locale = context.watch<LocaleProvider>();
    final alerts = prov.alerts;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: alerts.isEmpty
            ? Center(
                child: Text(locale.translate(
                    en: 'No alerts set', te: 'ఏ అలారమ్స్ లేదు')))
            : ListView(
                children: alerts.entries.map((e) {
                  final prod = prov.findById(e.key);
                  return Card(
                    child: ListTile(
                      title: Text(
                          '${prod?.name ?? 'Product'} target ₹${e.value.toStringAsFixed(0)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => prov.removeAlert(e.key),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
