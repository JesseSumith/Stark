import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/locale_provider.dart';

class AdvisoryScreen extends StatelessWidget {
  const AdvisoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProv = context.watch<ProductProvider>();
    final locale = context.watch<LocaleProvider>();

    // Simple advisory: pick highest price from first product for demo
    final sample =
        productProv.products.isNotEmpty ? productProv.products.first : null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: sample == null
            ? const Center(child: Text('No data'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(locale.translate(en: 'Advisory', te: 'సలహా'),
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      title: Text('Best market for ${sample.name}'),
                      subtitle: Text('Based on price and distance (demo)'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Comparison (price vs distance):'),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: sample.markets.length,
                      itemBuilder: (context, idx) {
                        final m = sample.markets[idx];
                        return Card(
                          child: ListTile(
                            title: Text(
                                '${m.name} • ₹${m.price.toStringAsFixed(0)}'),
                            subtitle: Text('Distance: ${m.distanceKm} km'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Map placeholder — integrate flutter_map OpenStreetMap here for full map
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Open map placeholder')));
                    },
                    child: Text(locale.translate(
                        en: 'Open Map View', te: 'నకషా చూడండి')),
                  )
                ],
              ),
      ),
    );
  }
}
