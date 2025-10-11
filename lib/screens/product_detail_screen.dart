import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../providers/locale_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final TextEditingController _targetController = TextEditingController();

  @override
  void dispose() {
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final productProv = context.read<ProductProvider>();
    final locale = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Row(children: [
            Image.network(product.imageUrl,
                width: 100, height: 100, fit: BoxFit.cover),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('${product.price.toStringAsFixed(0)} ${product.unit}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Trend: ${product.trend}'),
                ]))
          ]),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          Align(alignment: Alignment.centerLeft, child: Text('Market Prices:')),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: product.markets.length,
              itemBuilder: (context, idx) {
                final m = product.markets[idx];
                // simplistic
                return Card(
                  child: ListTile(
                    title: Text(
                        '${m.name} • ${m.price.toStringAsFixed(0)} ${product.unit}'),
                    subtitle: Text('Distance: ${m.distanceKm} km'),
                    trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'After transport: ₹${(m.price - (m.distanceKm * 0.5)).toStringAsFixed(0)}'),
                        ]),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _targetController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: locale.translate(
                  en: 'Set target price (₹)',
                  te: 'లక్ష్య ధర ని సెట్ చేయండి (₹)'),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: ElevatedButton(
                child: Text(
                    locale.translate(en: 'Set Alert', te: 'అలారం సెట్ చేయండి')),
                onPressed: () {
                  final val = double.tryParse(_targetController.text);
                  if (val != null) {
                    productProv.setAlert(product.id, val);
                    showSimpleNotification(
                      Text(locale.translate(
                          en: 'Alert set!', te: 'అలారం సెట్ అయింది!')),
                      background: Colors.green,
                    );
                  } else {
                    showSimpleNotification(
                        Text(locale.translate(
                            en: 'Enter valid amount',
                            te: 'సరైన మొత్తం ఎంటర్ చేయండి')),
                        background: Colors.red);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                child: Text(locale.translate(
                    en: 'Compare Markets', te: 'మార్కెట్లు పోల్చండి')),
                onPressed: () {
                  // For MVP this opens Advisory screen, or could do a modal
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Scaffold(
                                appBar: AppBar(title: const Text('Comparison')),
                                body: Center(
                                    child: Text(
                                        'Map view placeholder — expand with flutter_map')),
                              )));
                },
              ),
            ),
          ])
        ]),
      ),
    );
  }
}
