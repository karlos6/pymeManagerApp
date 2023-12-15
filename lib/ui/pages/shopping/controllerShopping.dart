// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pymemanager/data/http/categoriesHttp.dart';
import 'package:pymemanager/data/http/productsHttp.dart';
import 'package:pymemanager/data/http/supplierHttp.dart';
import 'package:pymemanager/domain/request/categoriesRequest.dart';
import 'package:pymemanager/domain/request/priceRequest.dart';
import 'package:pymemanager/domain/request/productsRequest.dart';
import 'package:pymemanager/domain/request/suppliersRequest.dart';
import 'package:pymemanager/ui/widgets/mensaje_alerta.dart';

class ProductoController {
  HttpProducts productoHttp = HttpProducts();
  SupplierHttp supplierHttp = SupplierHttp();
  CategoriesHttp categoriesHttp = CategoriesHttp();

  /*
   * Metodo para listar los productos
   */
  Future<List<ProductsRequest>> listarProductos() async {
    return await productoHttp.listProducts();
  }

  /*
   * Metodo para leer el codigo de barras 
   */
  Future<String> leerCodigoBarras() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    return barcodeScanRes;
  }

  /*
   * Metodo para listar las categorias
   */

  Future<List<CategoriesRequest>> listarCategorias() async {
    return await categoriesHttp.listCategories();
  }

  /*
   * Metodo para listar los proveedores
   */
  Future<List<SuppliersRequest>> listarSuppliers() async {
    return await supplierHttp.listSuppliers();
  }

  /*
   * Metodo para  cargar las imagenes
   */
  Future<File> cargarImagen(int opcion) async {
    File imagen = File('');
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;

    if (opcion == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }
    if (pickedFile != null) {
      imagen = File(pickedFile.path);
    }
    return imagen;
  }

  /*
   * Metodo para registrar un producto
   */
  Future<void> crearProducto(
    BuildContext context,
    ProductsRequest productsRequest,
    PriceRequest precioCompra,
    PriceRequest precioVenta,
  ) async {
    precioCompra.productId = productsRequest.id;
    precioCompra.date = DateTime.now().toString();

    precioVenta.productId = productsRequest.id;
    precioVenta.date = DateTime.now().toString();

    bool respuesta = await productoHttp.createProduct(productsRequest);
    if (respuesta) {
      await productoHttp.createPriceCompra(precioCompra);
      await productoHttp.createPriceVenta(precioVenta);
      await alertaDialogo(
          context: context,
          dialogType: DialogType.success,
          titulo: "Creacion",
          contenido: "Producto creado correctamente",
          color: Colors.green);
    } else {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.error,
          titulo: "Creacion",
          contenido: "Error al crear la producto",
          color: Colors.red);
    }
  }

  /*
   * Metodo para actualizar un Supplier
   */
  Future actualizarProducto(
      BuildContext context, ProductsRequest productRequest) async {
    bool respuesta = await productoHttp.updateProduct(productRequest);
    if (respuesta) {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.success,
          titulo: "Creacion",
          contenido: "Producto creado correctamente",
          color: Colors.green);
    } else {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.error,
          titulo: "Creacion",
          contenido: "Error al crear la producto",
          color: Colors.red);
    }
  }

  /*
   * Metodo para eliminar un Supplier
   */
  Future<bool> eliminarProducto(
      BuildContext context, String id, String nombreProveedeor) async {
    bool repuesta = false;
    bool eliminar = await alertaEliminacion(
        context: context,
        titulo: "Eliminacion",
        contenido:
            "¿Estas seguro que desea eliminar el producto $nombreProveedeor?");
    if (eliminar) {
      repuesta = await productoHttp.deleteProduct(id);
      if (repuesta) {
        await alertaDialogo(
            context: context,
            dialogType: DialogType.success,
            titulo: "Eliminacion",
            contenido: "producto $nombreProveedeor eliminado correctamente",
            color: Colors.green);
      } else {
        await alertaDialogo(
            context: context,
            dialogType: DialogType.error,
            titulo: "Eliminacion",
            contenido: "Error al eliminar la Supplier",
            color: Colors.red);
      }
    }
    return repuesta;
  }
}
