class Order {
  int? id;
  int? identifier;
  DateTime? createdAt;
  List<dynamic>? orders;
  double? total;

  Order({
    required this.id,
    required this.identifier,
    required this.createdAt,
    required this.orders,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["data"]["id"],
      identifier: json["data"]["identifier"],
      createdAt: DateTime.parse(json["data"]["created_at"].toString()),
      orders: json["data"]["orders"],
      total: json["data"]["total"],
    );
  }
}
