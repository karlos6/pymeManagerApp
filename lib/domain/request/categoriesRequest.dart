// ignore_for_file: file_names

class CategoriesRequest {
  String id = "";
  String name = "";

  CategoriesRequest();

  CategoriesRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  Map<String, dynamic> toJsonSinID() => {
        'name': name,
      };
}
