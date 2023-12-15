import 'dart:convert';

import 'package:pymemanager/data/env/env.dart';
import 'package:pymemanager/domain/request/inventoryRequest.dart';
import 'package:http/http.dart' as http;

class InvetoryHttp {
  Future<List<InventoryRequest>> listInventory({required String filtro}) async {
    const url = '${Env.url}/inventory';
    try {
      final res = await http.get(
        Uri.parse(url),
      );

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        List<InventoryRequest> inventoryList =
            serviceResponse.map((e) => InventoryRequest.fromJson(e)).toList();
        if (filtro == "2") {
          return inventoryList
              .where((inventoru) => int.parse(inventoru.quantity) > 0)
              .toList();
        } else if (filtro == "3") {
          return inventoryList
              .where((inventoru) => int.parse(inventoru.quantity) < 0)
              .toList();
        } else {
          return inventoryList;
        }
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
