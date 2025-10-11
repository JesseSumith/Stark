import 'package:flutter/material.dart';
import 'package:market_advisor/mock_data.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
// Ensure this file exists and defines MockData
import '../models/product_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _query = '';
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = MockData.getProducts();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade600, Colors.green.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      title: Text(
        locale.translate(en: 'All Products', te: 'అన్ని ఉత్పత్తులు'),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildSearchField(LocaleProvider locale) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: locale.translate(
            en: 'Search products...',
            te: 'ఉత్పత్తులను వెతకండి...',
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.green),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (v) => setState(() => _query = v),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    Color trendColor;
    IconData trendIcon;

    switch (product.trend.toLowerCase()) {
      case 'up':
        trendColor = Colors.green;
        trendIcon = Icons.arrow_upward;
        break;
      case 'down':
        trendColor = Colors.red;
        trendIcon = Icons.arrow_downward;
        break;
      default:
        trendColor = Colors.grey;
        trendIcon = Icons.horizontal_rule;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.green.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            product.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 60),
          ),
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          '${product.price.toStringAsFixed(0)} per ${product.unit}',
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(trendIcon, color: trendColor, size: 20),
            const SizedBox(height: 2),
            Text(
              product.trend.toUpperCase(),
              style: TextStyle(
                  color: trendColor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    final filtered = products
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    if (filtered.isEmpty) {
      final locale = context.watch<LocaleProvider>();
      return Center(
        child: Text(
          locale.translate(
            en: 'No matching products found.',
            te: 'సరిపోలే ఉత్పత్తులు లభించలేదు.',
          ),
          style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filtered.length,
      itemBuilder: (_, index) => _buildProductCard(filtered[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchField(context.watch<LocaleProvider>()),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 5,
                      itemBuilder: (_, __) => Container(
                        height: 100,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return _buildProductList(snapshot.data!);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
