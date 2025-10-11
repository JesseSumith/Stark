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

    // Take first product for demo advisory
    final sample =
        productProv.products.isNotEmpty ? productProv.products.first : null;

    // If sample exists, create mock market data if empty
    final markets = sample != null && sample.markets.isEmpty
        ? [
            {"name": "Mandi A", "price": sample.price + 5, "distanceKm": 12},
            {"name": "Mandi B", "price": sample.price - 3, "distanceKm": 25},
            {"name": "Mandi C", "price": sample.price + 8, "distanceKm": 7},
          ]
        : sample?.markets ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.translate(en: 'Advisory', te: 'సలహా')),
        backgroundColor: Colors.green.shade600,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: sample == null
              ? Center(child: Text('No products available'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.translate(en: 'Advisory', te: 'సలహా'),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Product info card
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: Image.network(
                          sample.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          sample.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          'Unit: ${sample.unit} • Price: ₹${sample.price.toStringAsFixed(0)}',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      locale.translate(
                          en: 'Market Comparison', te: 'మార్కెట్ సరిపోలిక'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),

                    // Markets list
                    Expanded(
                      child: ListView.separated(
                        itemCount: markets.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, idx) {
                          final m = markets[idx];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green.shade100,
                                child: Text(
                                  (m as Map<String, dynamic>)['name'][0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ),
                              title: Text('${m['name']}'),
                              subtitle: Text(
                                  'Price: ₹${m['price']} • Distance: ${m['distanceKm']} km'),
                              trailing: Icon(
                                m['price'] >= sample.price
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: m['price'] >= sample.price
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Map button
                    Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.map),
                        label: Text(locale.translate(
                            en: 'Open Map View', te: 'నకషా చూడండి')),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Map view placeholder')));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
