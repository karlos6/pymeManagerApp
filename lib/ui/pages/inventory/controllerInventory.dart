// ignore_for_file: use_build_context_synchronously

import 'package:pymemanager/data/http/inventoryHttp.dart';
import 'package:pymemanager/domain/request/inventoryRequest.dart';

class CotrollerInventory {
  InvetoryHttp invetoryHttp = InvetoryHttp();

  /*
   * Metodo para listar los productos
   */
  Future<List<InventoryRequest>> listarInventory(String filtro) async {
    return await invetoryHttp.listInventory(filtro: filtro);
  }
}
