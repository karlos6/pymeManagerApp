class SuppliersRequest {
  String id = "";
  String name = "";
  String address = "";
  String phone = "";
  String email = "";
  String website = "";
  String contact_name = "";
  String contact_phone = "";
  String contact_email = "";

  SuppliersRequest();

  SuppliersRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    contact_name = json['contact_name'];
    contact_phone = json['contact_phone'];
    contact_email = json['contact_email'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'phone': phone,
        'email': email,
        'website': website,
        'contact_name': contact_name,
        'contact_phone': contact_phone,
        'contact_email': contact_email,
      };

  Map<String, dynamic> toJsonSinID() => {
        'name': name,
        'address': address,
        'phone': phone,
        'email': email,
        'website': website,
        'contact_name': contact_name,
        'contact_phone': contact_phone,
        'contact_email': contact_email,
      };
}
