class MarketEntry {
  final String name;
  final double price;
  final double distanceKm;

  MarketEntry(
      {required this.name, required this.price, required this.distanceKm});

  factory MarketEntry.fromJson(Map<String, dynamic> json) => MarketEntry(
        name: json['name'],
        price: (json['price'] as num).toDouble(),
        distanceKm: (json['distanceKm'] as num).toDouble(),
      );
}

class Product {
  final int id;
  final String name;
  final String unit;
  final double price;
  final String trend;
  final String category;
  final String imageUrl;
  final List<MarketEntry> markets;

  Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
    required this.trend,
    required this.category,
    required this.imageUrl,
    required this.markets,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      unit: json['unit'],
      price: (json['price'] as num).toDouble(),
      trend: json['trend'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      markets: (json['markets'] as List<dynamic>)
          .map((e) => MarketEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
