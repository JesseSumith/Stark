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
        "imageUrl": "https://pngimg.com/uploads/cashew/cashew_PNG44.png",
        "markets": []
      },
      {
        "id": 2,
        "name": "Jackfruit",
        "unit": "kg",
        "price": 40.0,
        "trend": "down",
        "category": "Fruits",
        "imageUrl": "https://pngfre.com/wp-content/uploads/Jackfruit-23.png",
        "markets": []
      },
      {
        "id": 3,
        "name": "Turmeric",
        "unit": "kg",
        "price": 90.0,
        "trend": "up",
        "category": "Spices",
        "imageUrl":
            "https://bigdeals.lk/uploads/product/normal/bdlpktm08n1.png",
        "markets": []
      },
      {
        "id": 4,
        "name": "Rice",
        "unit": "kg",
        "price": 52.0,
        "trend": "neutral",
        "category": "Grains",
        "imageUrl":
            "https://images.rawpixel.com/image_png_social_landscape/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsX29mZmljZV8yMV9waG90b19vZl9yaWNlX3NhY2tfd2l0aF9yaWNlX2Nyb3BfaXNvbGF0ZWRfb185ZmI0NTg5My1mMThiLTRjMTktOTU1NS1hZThkNjc5NzQyZTMucG5n.png",
        "markets": []
      },
    ];

    return rawData.map((e) => Product.fromJson(e)).toList();
  }
}
