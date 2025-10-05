import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../providers/locale_provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final locale = context.watch<LocaleProvider>();
    final filtered = provider.products
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              hintText: locale.translate(
                  en: 'Search products...', te: 'ఉత్పత్తుల్ని ఆజ్ఞ పడండి...'),
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, idx) =>
                  ProductCard(product: filtered[idx]),
            ),
          )
        ]),
      ),
    );
  }
}
