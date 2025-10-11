import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product_model.dart';
import '../services/mock_data_service.dart';
import '../utils/constants.dart'; // ✅ Add this import

class ProductProvider extends ChangeNotifier {
  final MockDataService _service = MockDataService();

  List<Product> _products = [];
  List<Product> get products => _products;

  final Map<int, double> _alerts = {};
  Map<int, double> get alerts => _alerts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Fetch real data from Django API
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}products/'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        // Convert JSON to Product objects
        _products = jsonData.map((item) => Product.fromJson(item)).toList();

        print('✅ Products fetched successfully: ${_products.length}');
      } else {
        print('❌ Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      print('⚠️ Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Optional: for setting alerts
  void setAlert(int productId, double targetPrice) {
    _alerts[productId] = targetPrice;
    notifyListeners();
  }

  void removeAlert(int productId) {
    _alerts.remove(productId);
    notifyListeners();
  }

  Product? findById(int id) =>
      _products.firstWhere((p) => p.id == id, orElse: () => _products.first);
}
