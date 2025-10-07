import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/mock_data.dart';

class ProductCardLarge extends StatelessWidget {
  final LocalProduct product;
  final VoidCallback? onTap;

  const ProductCardLarge({super.key, required this.product, this.onTap});

  Color _trendColor(String t) {
    if (t.toLowerCase() == 'up') return Colors.green.shade700;
    if (t.toLowerCase() == 'down') return Colors.red.shade700;
    return Colors.grey.shade700;
  }

  IconData _trendIcon(String t) {
    if (t.toLowerCase() == 'up') return Icons.trending_up;
    if (t.toLowerCase() == 'down') return Icons.trending_down;
    return Icons.trending_flat;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} tapped')));
          },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('₹${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(_trendIcon(product.trend),
                              size: 16, color: _trendColor(product.trend)),
                          const SizedBox(width: 6),
                          Text(
                            product.trend.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13,
                                color: _trendColor(product.trend)),
                          ),
                        ],
                      ),
                    ]),
              )
            ],
          ),
        ),
      ).animate().fadeIn(duration: 350.ms).slideX(begin: 0.05),
    );
  }
}
