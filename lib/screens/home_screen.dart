import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/locale_provider.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productProv = context.watch<ProductProvider>();
    final locale = context.watch<LocaleProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: productProv.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(locale.translate(en: 'Welcome', te: 'స్వాగతం'),
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(locale.translate(
                      en: 'Track market prices and find the best mandi to sell',
                      te: 'సూక్ష్మ ధరల‌ను గమనించండి & మంచి మార్కెట్‌ను కనుగొనండి')),
                  const SizedBox(height: 16),
                  Text(locale.translate(
                      en: 'Popular Products', te: 'ప్రసిద్ధ ఉత్పత్తులు')),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: productProv.products.length,
                      itemBuilder: (context, index) {
                        final p = productProv.products[index];
                        return ProductCard(product: p);
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
