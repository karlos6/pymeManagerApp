import 'package:flutter/material.dart';
import 'package:pymemanager/domain/request/suppliersRequest.dart';
import 'package:pymemanager/ui/pages/shopping/controllerShopping.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';

class DropdownSuppliers extends StatefulWidget {
  final Function(String?) onSaved;
  final String label;

  const DropdownSuppliers({
    Key? key,
    required this.onSaved,
    required this.label,
  }) : super(key: key);

  @override
  _DropdownSuppliersState createState() => _DropdownSuppliersState();
}

class _DropdownSuppliersState extends State<DropdownSuppliers> {
  List<SuppliersRequest> listaSuppliers = [];
  ProductoController productoController = ProductoController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializacion();
  }

  inicializacion() async {
    listaSuppliers = await productoController.listarSuppliers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null) {
            return "Este campo es obligatorio";
          }
        },
        isExpanded: true,
        onSaved: widget.onSaved,
        items: listaSuppliers.map((SuppliersRequest value) {
          return DropdownMenuItem<String>(
            value: value.id.toString(),
            child: Text(value.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'CaviarDreamsRegular',
                )),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            newValue;
          });
        },
        decoration: InputDecoration(
          label: Text(widget.label),
          hintText: "Ingrese un valor",
          border: TextFieldDesingCustom.outlineInputBorder,
          enabledBorder: TextFieldDesingCustom.outlineInputBorder,
          focusedBorder: TextFieldDesingCustom.outlineInputBorder,
          errorBorder: TextFieldDesingCustom.outlineInputBorderRed,
          focusedErrorBorder: TextFieldDesingCustom.outlineInputBorderRed,
        ));
  }
}
