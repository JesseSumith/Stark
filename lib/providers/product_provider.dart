import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/mock_data_service.dart';

class ProductProvider extends ChangeNotifier {
  final MockDataService _service = MockDataService();

  List<Product> _products = [];
  List<Product> get products => _products;

  // Simple in-memory alerts: productId -> targetPrice
  final Map<int, double> _alerts = {};
  Map<int, double> get alerts => _alerts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadMockProducts() async {
    _isLoading = true;
    notifyListeners();
    _products = await _service.loadProducts();
    _isLoading = false;
    notifyListeners();
  }

  Product? findById(int id) =>
      _products.firstWhere((p) => p.id == id, orElse: () => _products.first);

  void setAlert(int productId, double targetPrice) {
    _alerts[productId] = targetPrice;
    notifyListeners();
  }

  void removeAlert(int productId) {
    _alerts.remove(productId);
    notifyListeners();
  }
}
