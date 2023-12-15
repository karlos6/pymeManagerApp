// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pymemanager/data/http/categoriesHttp.dart';
import 'package:pymemanager/domain/request/categoriesRequest.dart';
import 'package:pymemanager/ui/widgets/mensaje_alerta.dart';

class CotrollerCategorias {
  CategoriesHttp categoriesHttp = CategoriesHttp();

  /*
   * Metodo para listar los productos
   */
  Future<List<CategoriesRequest>> listarCategorias() async {
    return await categoriesHttp.listCategories();
  }

  /*
   * Metodo para crear un categoria
   */
  Future<void> crearCategoria(
      BuildContext context, CategoriesRequest categoriesRequest) async {
    bool respuesta = await categoriesHttp.createCategory(categoriesRequest);
    if (respuesta) {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.success,
          titulo: "Creacion",
          contenido: "Categoria creada correctamente",
          color: Colors.green);
    } else {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.error,
          titulo: "Creacion",
          contenido: "Error al crear la categoria",
          color: Colors.red);
    }
  }

  /*
   * Metodo para actualizar un categoria
   */
  Future actualizarCategoria(
      BuildContext context, CategoriesRequest categoriesRequest) async {
    bool respuesta = await categoriesHttp.updateCategory(categoriesRequest);
    if (respuesta) {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.success,
          titulo: "Creacion",
          contenido: "Categoria creada correctamente",
          color: Colors.green);
    } else {
      await alertaDialogo(
          context: context,
          dialogType: DialogType.error,
          titulo: "Creacion",
          contenido: "Error al crear la categoria",
          color: Colors.red);
    }
  }

  /*
   * Metodo para eliminar un categoria
   */
  Future<bool> eliminarCategoria(BuildContext context, String id) async {
    bool repuesta = false;
    bool eliminar = await alertaEliminacion(
        context: context,
        titulo: "Eliminacion",
        contenido: "¿Estas seguro de eliminar esta categoria?");
    if (eliminar) {
      repuesta = await categoriesHttp.deleteCategory(id);
      if (repuesta) {
        await alertaDialogo(
            context: context,
            dialogType: DialogType.success,
            titulo: "Eliminacion",
            contenido: "Categoria eliminada correctamente",
            color: Colors.green);
      } else {
        await alertaDialogo(
            context: context,
            dialogType: DialogType.error,
            titulo: "Eliminacion",
            contenido: "Error al eliminar la categoria",
            color: Colors.red);
      }
    }
    return repuesta;
  }
}
