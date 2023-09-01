class Product {
  int? id;
  String? name;
  double? price;
  bool? available;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.available,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      available: json['available'],
    );
  }
}
