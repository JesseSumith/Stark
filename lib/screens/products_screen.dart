import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/locale_provider.dart';
import '../services/mock_data.dart';
import '../widgets/product_card_large.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _query = '';
  late Future<HomeMockData> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = MockDataLoader.loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(
        title:
            Text(locale.translate(en: 'All Products', te: 'అన్ని ఉత్పత్తులు')),
        backgroundColor: const Color(0xFF6D4C41),
      ),
      body: SafeArea(
        child: FutureBuilder<HomeMockData>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // shimmer loader
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 5,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final data = snapshot.data!;
              final allProducts = data.products;
              final filtered = allProducts
                  .where((p) =>
                      p.name.toLowerCase().contains(_query.toLowerCase()))
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: locale.translate(
                          en: 'Search products...',
                          te: 'ఉత్పత్తులను వెతకండి...',
                        ),
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (v) => setState(() => _query = v),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: filtered.isEmpty
                          ? Center(
                              child: Text(locale.translate(
                                en: 'No matching products found.',
                                te: 'సరిపోలే ఉత్పత్తులు లభించలేదు.',
                              )),
                            )
                          : ListView.builder(
                              itemCount: filtered.length,
                              itemBuilder: (context, i) =>
                                  ProductCardLarge(product: filtered[i]),
                            ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
