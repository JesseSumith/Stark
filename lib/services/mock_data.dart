// lib/services/mock_data.dart
import 'dart:convert';
import 'package:flutter/services.dart';

class BannerItem {
  final String title;
  final String imageUrl;
  BannerItem({required this.title, required this.imageUrl});

  factory BannerItem.fromJson(Map<String, dynamic> j) => BannerItem(
        title: j['title'] ?? '',
        imageUrl: j['image'] ?? '',
      );
}

class LocalProduct {
  final String name;
  final double price;
  final String trend; // "up" / "down" / "neutral"
  final String imageUrl;

  LocalProduct({
    required this.name,
    required this.price,
    required this.trend,
    required this.imageUrl,
  });

  factory LocalProduct.fromJson(Map<String, dynamic> j) => LocalProduct(
        name: j['name'] ?? '',
        price: (j['price'] as num?)?.toDouble() ?? 0.0,
        trend: j['trend'] ?? 'neutral',
        imageUrl: j['image'] ?? '',
      );
}

class HomeMockData {
  final List<BannerItem> banners;
  final List<LocalProduct> products;

  HomeMockData({required this.banners, required this.products});
}

/// Loads both banners.json and products.json from assets/mock_data/
/// Example assets structure:
/// assets/mock_data/products.json
/// assets/mock_data/banners.json
class MockDataLoader {
  static Future<HomeMockData> loadAll() async {
    final bannersJson =
        await rootBundle.loadString('assets/mock_data/banners.json');
    final productsJson =
        await rootBundle.loadString('assets/mock_data/products.json');

    final bannersList = json.decode(bannersJson) as List<dynamic>;
    final productsList = json.decode(productsJson) as List<dynamic>;

    final banners = bannersList
        .map((e) => BannerItem.fromJson(e as Map<String, dynamic>))
        .toList();
    final products = productsList
        .map((e) => LocalProduct.fromJson(e as Map<String, dynamic>))
        .toList();

    return HomeMockData(banners: banners, products: products);
  }
}
