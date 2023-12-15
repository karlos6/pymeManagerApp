// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pymemanager/data/http/customersHttp.dart';
import 'package:pymemanager/data/http/invoiceHttp.dart';
import 'package:pymemanager/data/http/productsHttp.dart';
import 'package:pymemanager/domain/request/customersRequest.dart';
import 'package:pymemanager/domain/request/invoiceRequest.dart';
import 'package:pymemanager/domain/request/priceRequest.dart';
import 'package:pymemanager/domain/request/productsRequest.dart';
import 'package:pymemanager/ui/widgets/mensaje_alerta.dart';

class ControllerInvoice {
  HttpProducts productoHttp = HttpProducts();
  InvoiceHttp invoiceHttp = InvoiceHttp();
  CustomersHttp customersHttp = CustomersHttp();

/*
   * Metodo para crear un categoria
   */
  Future<void> crearCategoria(
      BuildContext context, InvoiceRequest invoiceRequest) async {
    bool respuesta = await invoiceHttp.createInvoice(invoiceRequest);
    if (respuesta) {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.success,
          titulo: "Creacion",
          contenido: "Factura creada correctamente",
          color: Colors.green);
    } else {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.error,
          titulo: "Creacion",
          contenido: "Error al crear la Factura",
          color: Colors.red);
    }
  }

  /*
   * Metodo para listar los productos
   */
  Future<List<ProductsRequest>> listarProductos() async {
    return await productoHttp.listProducts();
  }

  /*
   * Metodo precio producto
   */
  Future<PriceRequest> precioCompraProducto(String id) async {
    return await productoHttp.getPriceCompra(id);
  }

  /*
   * Metodo precio vente
   */
  Future<PriceRequest> precioVentaProducto(String id) async {
    return await productoHttp.getPriceVenta(id);
  }

  /*
   * Metodo para listar los clientes
   */
  Future<List<CustomersRequest>> listarClientes() async {
    return await customersHttp.listCustomers();
  }
}
