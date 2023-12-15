// ignore_for_file: file_names

import 'dart:convert';

import 'package:pymemanager/data/env/env.dart';
import 'package:pymemanager/domain/request/invoiceRequest.dart';
import 'package:http/http.dart' as http;

class InvoiceHttp {
  /*
   * Metodo para crear un factura
   */
  Future<bool> createInvoice(InvoiceRequest invoiceRequest) async {
    const url = '${Env.url}/sales';
    print(invoiceRequest.toJsonSinId());
    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode(invoiceRequest.toJsonSinId()),
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
}
