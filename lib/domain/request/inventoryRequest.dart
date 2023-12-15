// ignore_for_file: file_names

class InventoryRequest {
  String id = "";
  String productId = "";
  String quantity = "";
  String operationDate = "";

  InventoryRequest();

  InventoryRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    productId = json['productId'].toString();
    quantity = json['quantity'].toString();
    operationDate = json['operationDate'].toString();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'quantity': quantity,
        'operationDate': operationDate,
      };
}
