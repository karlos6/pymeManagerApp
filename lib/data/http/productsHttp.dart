import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pymemanager/data/env/env.dart';
import 'package:pymemanager/domain/request/priceRequest.dart';
import 'package:pymemanager/domain/request/productsRequest.dart';

class HttpProducts {
  /*
   * Metodo para listar un producto
   */
  Future<List<ProductsRequest>> listProducts() async {
    const url = '${Env.url}/products';
    try {
      final res = await http.get(
        Uri.parse(url),
      );

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse.map((e) => ProductsRequest.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  /*
   * Metodo para crear un producto 
   */
  Future<bool> createProduct(ProductsRequest product) async {
    const url = '${Env.url}/products';
    print(product.toJson());
    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode(product.toJson()),
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
   * Metodo para Actualizar la categorias 
   */
  Future<bool> updateProduct(ProductsRequest product) async {
    final url = '${Env.url}/products/${product.id}';
    try {
      final res = await http.put(
        Uri.parse(url),
        body: json.encode(product.toJson()),
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
   * Metodo para eliminar un producto 
   */
  Future<bool> deleteProduct(String id) async {
    final url = '${Env.url}/products/$id';
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

  // Metodo para crear un precio de compra
  Future<bool> createPriceCompra(PriceRequest price) async {
    final url = '${Env.url}/purchase-prices/${price.productId}';
    print("Precio de venta");
    print(price.toJsonSinId());
    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode(price.toJsonSinId()),
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

  // Metodo para crear un precio de compra
  Future<bool> createPriceVenta(PriceRequest price) async {
    final url = '${Env.url}/sale-prices/${price.productId}';
    print("Precio de venta");
    print(price.toJsonSinId());
    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode(price.toJsonSinId()),
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

  Future<PriceRequest> getPriceCompra(String id) async {
    final url = '${Env.url}/purchase-prices/$id';
    try {
      final res = await http.get(
        Uri.parse(url),
      );

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        List<PriceRequest> priceList =
            serviceResponse.map((e) => PriceRequest.fromJson(e)).toList();
        return priceList.first;
      } else {
        return PriceRequest();
      }
    } catch (e) {
      print(e);
      return PriceRequest();
    }
  }

  Future<PriceRequest> getPriceVenta(String id) async {
    final url = '${Env.url}/purchase-prices/$id';
    try {
      final res = await http.get(
        Uri.parse(url),
      );

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        List<PriceRequest> priceList =
            serviceResponse.map((e) => PriceRequest.fromJson(e)).toList();
        return priceList.first;
      } else {
        return PriceRequest();
      }
    } catch (e) {
      print(e);
      return PriceRequest();
    }
  }
}
