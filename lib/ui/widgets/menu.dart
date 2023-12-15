import 'package:flutter/material.dart';
import 'package:pymemanager/ui/utilities/dimensiones.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: Adapt.hp(30, context),
            width: Adapt.wp(100, context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/fondo_arp.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Image.asset('assets/img/Pyme_logo.png'),
          ),
          ExpansionTile(
            title: const Text("Registros"),
            children: [
              ListTile(
                leading: const Icon(
                  Icons.category_outlined,
                ),
                title: Text(
                  'Categorias',
                  style: TextStyle(color: Colors.blueGrey[600]),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'categoriesList');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.airport_shuttle_outlined,
                ),
                title: Text(
                  'Proveedores',
                  style: TextStyle(color: Colors.blueGrey[600]),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'suppliersList');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                title: Text(
                  'Productos',
                  style: TextStyle(color: Colors.blueGrey[600]),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'shoppingList');
                },
              ),
            ],
          ),
          ExpansionTile(
            title: const Text("Ventas"),
            children: [
              ListTile(
                leading: const Icon(
                  Icons.point_of_sale_outlined,
                ),
                title: Text(
                  'Lista de ventas',
                  style: TextStyle(color: Colors.blueGrey[600]),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'salesList');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                ),
                title: Text(
                  'Clientes',
                  style: TextStyle(color: Colors.blueGrey[600]),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'customersList');
                },
              ),
            ],
          ), //customersList
          ExpansionTile(
            title: const Text("Inventario"),
            children: [
              ListTile(
                leading: const Icon(
                  Icons.inventory_outlined,
                ),
                title: Text(
                  'Inventario',
                  style: TextStyle(color: Colors.blueGrey[600]),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'inventoryList');
                },
              ),
            ],
          ),
          SizedBox(
            height: Adapt.hp(10, context),
          ),
          SizedBox(
            height: Adapt.hp(5, context),
            width: Adapt.wp(5, context),
            child: Image.asset('assets/img/logo.jpg'),
          )
        ],
      ),
    );
  }
}
