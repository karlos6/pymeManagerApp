// ignore_for_file: file_names

import 'dart:math';

import 'package:pymemanager/domain/request/salesRequest.dart';

class InvoiceRequest {
  String id = "";
  String customerId = "";
  String invoiceNumber = "";
  String invoiceDate = "";
  String customerNumber = "";
  double total = 0.0;
  List<SaleRequest> items = [];

  InvoiceRequest() {
    this.invoiceDate = DateTime.now().toString();
    this.invoiceNumber = 'INV-${generarNumeroAleatorio(10000, 99999)}';
    this.customerNumber = 'CUST-${generarNumeroAleatorio(10000, 99999)}';
  }

  InvoiceRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    customerId = json['customerId'].toString();
    invoiceNumber = json['invoiceNumber'].toString();
    invoiceDate = json['invoiceDate'].toString();
    customerNumber = json['customerNumber'].toString();
    total = json['total'];
    items =
        json['items'].map<SaleRequest>((e) => SaleRequest.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customerId': customerId,
        'invoiceNumber': invoiceNumber,
        'invoiceDate': invoiceDate,
        'customerNumber': customerNumber,
        'total': total,
        'items': items.map((e) => e.toJsonSinId()).toList(),
      };

  Map<String, dynamic> toJsonSinId() => {
        'customerId': customerId,
        'invoiceNumber': 'INV-${generarNumeroAleatorio(10000, 99999)}',
        'invoiceDate': invoiceDate,
        'customerNumber': 'CUST-${generarNumeroAleatorio(10000, 99999)}',
        'total': total,
        'items': items.map((e) => e.toJsonSinId()).toList(),
      };

  int generarNumeroAleatorio(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min);
  }
}
