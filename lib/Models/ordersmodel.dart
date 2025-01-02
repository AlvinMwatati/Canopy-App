class Order {
  dynamic orderId;
  dynamic productId;
  dynamic amount;
  dynamic createdAt;

  Order({
    required this.orderId,
    required this.productId,
    required this.amount,
    required this.createdAt,
  });

  // Factory method to convert JSON into an Order object
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      productId: json['product_id'],
      amount: json['amount'],
      createdAt: json['created_at'],
    );
  }
}
