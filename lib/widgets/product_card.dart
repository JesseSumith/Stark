import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(product.imageUrl,
              width: 64, height: 64, fit: BoxFit.cover),
        ),
        title: Text(
            '${product.name} • ${product.price.toStringAsFixed(0)} ${product.unit}'),
        subtitle: Text('Trend: ${product.trend} • ${product.category}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product)));
        },
      ),
    );
  }
}
