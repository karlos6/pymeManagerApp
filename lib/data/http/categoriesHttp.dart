import 'dart:convert';
import 'package:pymemanager/data/env/env.dart';
import 'package:pymemanager/domain/request/categoriesRequest.dart';
import 'package:http/http.dart' as http;

class CategoriesHttp {
  Future<List<CategoriesRequest>> listCategories() async {
    const url = '${Env.url}/categories';
    try {
      final res = await http.get(
        Uri.parse(url),
      );

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse
            .map((e) => CategoriesRequest.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> createCategory(CategoriesRequest category) async {
    const url = '${Env.url}/categories/';
    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode(category.toJsonSinID()),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateCategory(CategoriesRequest category) async {
    final url = '${Env.url}/categories/${category.id}';
    try {
      final res = await http.put(
        Uri.parse(url),
        body: json.encode(category.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCategory(String id) async {
    final url = '${Env.url}/categories/$id';
    try {
      final res = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
