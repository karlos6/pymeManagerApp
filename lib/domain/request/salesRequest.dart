class SaleRequest {
  String id = "";
  String saleId = "";
  String productId = "";
  String productName = "";
  String description = "";
  int quantity = 0;
  double unitPrice = 0;
  double discount = 5;
  double total = 0;

  SaleRequest();

  SaleRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    saleId = json['saleId'].toString();
    productId = json['productId'].toString();
    productName = json['productName'].toString();
    description = json['description'].toString();
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    discount = json['discount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'saleId': saleId,
        'productId': productId,
        'productName': productName,
        'description': description,
        'quantity': quantity,
        'unitPrice': unitPrice,
        'discount': discount,
        'total': total,
      };

  Map<String, dynamic> toJsonSinId() => {
        'productId': productId,
        'productName': productName,
        'description': description,
        'quantity': quantity,
        'unitPrice': unitPrice,
        'discount': discount,
        'total': total,
      };

  double totalSales() {
    double total = 0;
    total =
        (quantity * unitPrice) - ((quantity * unitPrice) * (discount / 100));
    return total;
  }
}
