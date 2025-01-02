class Productmodel {
  dynamic id;
  dynamic toolName;
  dynamic toolDesc;
  dynamic toolRentPrice; // Expecting double here
  dynamic image;
  dynamic category;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Productmodel({
    required this.id,
    required this.toolName,
    required this.toolDesc,
    required this.toolRentPrice,
    required this.image,
    required this.category,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Productmodel.fromJson(Map<String, dynamic> json) {
    return Productmodel(
      id: json['ID'],
      toolName: json['toolName'],
      toolDesc: json['toolDesc'],
      toolRentPrice: json['toolRentPrice'],
      image: json['image'],
      category: json['Category'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
