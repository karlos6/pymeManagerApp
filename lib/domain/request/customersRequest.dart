// ignore_for_file: file_names

class CustomersRequest {
  String id = "";
  String name = "";
  String email = "";
  String phone = "";
  String address = "";

  CustomersRequest();

  CustomersRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    address = json['address'].toString();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      };

  Map<String, dynamic> toJsonSinId() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      };
}
