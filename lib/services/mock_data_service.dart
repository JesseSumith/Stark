import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_model.dart';

class MockDataService {
  Future<List<Product>> loadProducts() async {
    final raw = await rootBundle.loadString('assets/mock_data/products.json');
    final list = json.decode(raw) as List<dynamic>;
    return list
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
