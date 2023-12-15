import 'package:flutter/material.dart';
import 'package:pymemanager/ui/pages/categories/categoriesList.dart';
import 'package:pymemanager/ui/pages/customers/customersList.dart';
import 'package:pymemanager/ui/pages/inventory/inventoryList.dart';
import 'package:pymemanager/ui/pages/login/login.dart';
import 'package:pymemanager/ui/pages/salses/InvoiceList.dart';
import 'package:pymemanager/ui/pages/shopping/shoppingList.dart';
import 'package:pymemanager/ui/pages/shopping/shoppingRegister.dart';
import 'package:pymemanager/ui/pages/suppliers/suppliersList.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PymeManager",
      debugShowCheckedModeBanner: false,
      initialRoute: "login",
      routes: {
        "login": (context) => LoginPage(),
        "shoppingList": (context) => ShoppingList(),
        "shoppingRegister": (context) => ShoppingRegister(),
        "salesList": (context) => InvoiceList(),
        "categoriesList": (context) => CategoriesList(),
        "suppliersList": (context) => SuppliersList(),
        "inventoryList": (context) => InventoryList(),
        "customersList": (context) => CustomersList(),
      },
    );
  }
}
