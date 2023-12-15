// ignore_for_file: file_names

class PriceRequest {
  String id = "";
  double price = 0.0;
  String date = "";
  String productId = "";

  PriceRequest();

  PriceRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    price = json['price'];
    date = json['date'].toString();
    productId = json['productId'].toString();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'date': date,
        'productId': productId,
      };

  Map<String, dynamic> toJsonSinId() => {
        'price': price,
        'date': date,
        'productId': productId,
      };
}
