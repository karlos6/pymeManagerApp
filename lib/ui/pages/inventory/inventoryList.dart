// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:pymemanager/domain/request/inventoryRequest.dart';
import 'package:pymemanager/ui/pages/inventory/controllerInventory.dart';
import 'package:pymemanager/ui/utilities/dimensiones.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';
import 'package:pymemanager/ui/widgets/menu.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({super.key});

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  List<InventoryRequest> listaInventory = [];
  CotrollerInventory cotrollerInventory = CotrollerInventory();
  bool isVisible = true;
  bool enEspera = true;
  String valorSeleccionado = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializacion();
  }

  inicializacion() async {
    listaInventory = await cotrollerInventory.listarInventory("1");
    enEspera = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: const Menu(),
          appBar: AppBar(
            title: const Text('Entradas y salidas'),
          ),
          body: _body()),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _contenidoProgresoVariables(),
      ],
    );
  }

  Widget _contenidoProgresoVariables() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: Adapt.px(10),
          expandedHeight: Adapt.hp(15, context),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[300],
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.all(5),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Adapt.wp(10, context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonFormField<String>(
                        value: "1",
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem<String>(
                            value: "1",
                            child: Text("Todas"),
                          ),
                          DropdownMenuItem<String>(
                            value: "2",
                            child: Text("Entradas"),
                          ),
                          DropdownMenuItem<String>(
                            value: "3",
                            child: Text("Salidas"),
                          ),
                        ],
                        onChanged: (String? newValue) async {
                          if (newValue != null) {
                            listaInventory = await cotrollerInventory
                                .listarInventory(newValue);
                          }
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          label: const Text("Filtro"),
                          hintText: "Ingrese un valor",
                          border: TextFieldDesingCustom.outlineInputBorder,
                          enabledBorder:
                              TextFieldDesingCustom.outlineInputBorder,
                          focusedBorder:
                              TextFieldDesingCustom.outlineInputBorder,
                          errorBorder:
                              TextFieldDesingCustom.outlineInputBorderRed,
                          focusedErrorBorder:
                              TextFieldDesingCustom.outlineInputBorderRed,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: Adapt.hp(2, context)),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return enEspera
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      )
                    : SizedBox(
                        child: _registroInventario(index),
                      );
              },
              childCount: listaInventory.length,
            ),
          ),
        ),
      ],
    );
  }

  Padding _registroInventario(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 5,
        child: ListTile(
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              int.parse(listaInventory[index].quantity) > 0
                  ? const Icon(
                      Icons.arrow_upward,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.arrow_downward,
                      color: Colors.blue,
                    ),
              SizedBox(
                width: Adapt.wp(1, context),
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black,
              )
            ],
          ),
          title: Text("Fecha: ${listaInventory[index].operationDate}",
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Código: ${listaInventory[index].id}'),
              Text('Código Producto: ${listaInventory[index].productId}'),
              Text('Cantidad: ${listaInventory[index].quantity}'),
            ],
          ),
        ),
      ),
    );
  }
}
