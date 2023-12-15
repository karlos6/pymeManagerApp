import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pymemanager/data/env/env.dart';
import 'package:pymemanager/domain/request/suppliersRequest.dart';

class SupplierHttp {
  /*
   * Metodo para listar los proveedores 
   */
  Future<List<SuppliersRequest>> listSuppliers() async {
    const url = '${Env.url}/suppliers';
    try {
      final res = await http.get(
        Uri.parse(url),
      );

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse
            .map((e) => SuppliersRequest.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  /*
   * Metodo para crear un proveedor 
   */
  Future<bool> createSupplier(SuppliersRequest supplier) async {
    const url = '${Env.url}/suppliers';
    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode(supplier.toJsonSinID()),
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

  /*
   * Metodo para Actualizar un proveedor 
   */
  Future<bool> updateSupplier(SuppliersRequest supplier) async {
    final url = '${Env.url}/suppliers/${supplier.id}';
    try {
      final res = await http.put(
        Uri.parse(url),
        body: json.encode(supplier.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  /*
   * Metodo para eliminar un proveedor 
   */
  Future<bool> deleteSupplier(String id) async {
    final url = '${Env.url}/suppliers/$id';
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
      print(e);
      return false;
    }
  }
}
