class Order {
  int? id;
  int? identifier;
  DateTime? createdAt;
  List<dynamic>? orders;

  Order({
    required this.id,
    required this.identifier,
    required this.createdAt,
    required this.orders,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      identifier: json["identifier"],
      createdAt: DateTime.parse(json["created_at"].toString()),
      orders: json["orders"],
    );
  }
}
