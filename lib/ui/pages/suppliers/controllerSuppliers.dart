// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pymemanager/data/http/supplierHttp.dart';
import 'package:pymemanager/domain/request/suppliersRequest.dart';
import 'package:pymemanager/ui/widgets/mensaje_alerta.dart';

class ControllerSuppliers {
  SupplierHttp supplierHttp = SupplierHttp();

  /*
   * Metodo para listar los productos
   */
  Future<List<SuppliersRequest>> listarSuppliers() async {
    return await supplierHttp.listSuppliers();
  }

  /*
   * Metodo para crear un Supplier
   */
  Future<void> crearSuppliers(
      BuildContext context, SuppliersRequest suppliersRequest) async {
    bool respuesta = await supplierHttp.createSupplier(suppliersRequest);
    if (respuesta) {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.success,
          titulo: "Creacion",
          contenido: "Supplier creada correctamente",
          color: Colors.green);
    } else {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.error,
          titulo: "Creacion",
          contenido: "Error al crear la Supplier",
          color: Colors.red);
    }
  }

  /*
   * Metodo para actualizar un Supplier
   */
  Future actualizarSuppliers(
      BuildContext context, SuppliersRequest suppliersRequest) async {
    bool respuesta = await supplierHttp.updateSupplier(suppliersRequest);
    if (respuesta) {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.success,
          titulo: "Creacion",
          contenido: "Supplier creada correctamente",
          color: Colors.green);
    } else {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.error,
          titulo: "Creacion",
          contenido: "Error al crear la Supplier",
          color: Colors.red);
    }
  }

  /*
   * Metodo para eliminar un Supplier
   */
  Future<bool> eliminarSuppliers(
      BuildContext context, String id, String nombreProveedeor) async {
    bool repuesta = false;
    bool eliminar = await alertaEliminacion(
        context: context,
        titulo: "Eliminacion",
        contenido:
            "¿Estas seguro que desea eliminar el proveedor $nombreProveedeor?");
    if (eliminar) {
      repuesta = await supplierHttp.deleteSupplier(id);
      if (repuesta) {
        await alertaDialogo(
            context: context,
            dialogType: DialogType.success,
            titulo: "Eliminacion",
            contenido: "Proveedor $nombreProveedeor eliminado correctamente",
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
