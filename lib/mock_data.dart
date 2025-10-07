import '../models/product_model.dart';

class MockData {
  static Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> rawData = [
      {
        "id": 1,
        "name": "Cashew",
        "unit": "kg",
        "price": 125.0,
        "trend": "up",
        "category": "Nuts",
        "imageUrl": "https://cdn-icons-png.flaticon.com/512/7648/7648128.png",
        "markets": []
      },
      {
        "id": 2,
        "name": "Jackfruit",
        "unit": "kg",
        "price": 40.0,
        "trend": "down",
        "category": "Fruits",
        "imageUrl": "https://cdn-icons-png.flaticon.com/512/415/415682.png",
        "markets": []
      },
      {
        "id": 3,
        "name": "Turmeric",
        "unit": "kg",
        "price": 90.0,
        "trend": "up",
        "category": "Spices",
        "imageUrl": "https://cdn-icons-png.flaticon.com/512/4139/4139772.png",
        "markets": []
      },
      {
        "id": 4,
        "name": "Rice",
        "unit": "kg",
        "price": 52.0,
        "trend": "neutral",
        "category": "Grains",
        "imageUrl": "https://cdn-icons-png.flaticon.com/512/415/415733.png",
        "markets": []
      },
    ];

    return rawData.map((e) => Product.fromJson(e)).toList();
  }
}
