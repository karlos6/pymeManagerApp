// ignore_for_file: file_names

class ProductsRequest {
  String id = "";
  String name = "";
  int supplierId = 0;
  int categoryId = 0;
  double weight = 0.0;
  String expirationDate = "";
  String description = "";
  String image = "";
  int stock = 0;

  ProductsRequest();

  ProductsRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'] ?? "";
    supplierId = json['supplierId'] ?? 0;
    categoryId = json['categoryId'] ?? 0;
    weight = json['weight'];
    expirationDate = json['expirationDate'] ?? "";
    description = json['description'] ?? "";
    image = json['image'] ?? "";
    stock = json['stock'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'supplierId': supplierId,
        'categoryId': categoryId,
        'weight': weight,
        'expirationDate': expirationDate,
        'description': description,
        'image': image,
        'stock': stock,
      };

  Map<String, dynamic> toJsonSinId() => {
        'id': id,
        'name': name,
        'supplierId': supplierId,
        'categoryId': categoryId,
        'weight': weight,
        'expirationDate': expirationDate,
        'description': description,
        'image': image,
        'stock': stock,
      };
}
