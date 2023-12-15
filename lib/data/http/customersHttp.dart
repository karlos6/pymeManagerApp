import 'dart:convert';

import 'package:pymemanager/data/env/env.dart';
import 'package:pymemanager/domain/request/customersRequest.dart';
import 'package:http/http.dart' as http;

class CustomersHttp {
  Future<List<CustomersRequest>> listCustomers() async {
    const url = '${Env.url}/customers';
    try {
      final res = await http.get(
        Uri.parse(url),
      );

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse
            .map((e) => CustomersRequest.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> createCustomer(CustomersRequest customersRequest) async {
    const url = '${Env.url}/customers/';
    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode(customersRequest.toJsonSinId()),
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

  Future<bool> updateCustomer(CustomersRequest customersRequest) async {
    final url = '${Env.url}/customers/${customersRequest.id}';
    try {
      final res = await http.put(
        Uri.parse(url),
        body: json.encode(customersRequest.toJson()),
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

  Future<bool> deleteCustomer(String id) async {
    final url = '${Env.url}/customers/$id';
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
