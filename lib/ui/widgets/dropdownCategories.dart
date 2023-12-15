import 'package:flutter/material.dart';
import 'package:pymemanager/domain/request/categoriesRequest.dart';
import 'package:pymemanager/ui/pages/shopping/controllerShopping.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';

class DropdownCategories extends StatefulWidget {
  final Function(String?) onSaved;
  final String label;

  const DropdownCategories({
    Key? key,
    required this.onSaved,
    required this.label,
  }) : super(key: key);

  @override
  _DropdownCategoriesState createState() => _DropdownCategoriesState();
}

class _DropdownCategoriesState extends State<DropdownCategories> {
  List<CategoriesRequest> listaCategorias = [];
  ProductoController productoController = ProductoController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializacion();
  }

  inicializacion() async {
    listaCategorias = await productoController.listarCategorias();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        onSaved: widget.onSaved,
        validator: (value) {
          if (value == null) {
            return "Este campo es obligatorio";
          }
        },
        isExpanded: true,
        items: listaCategorias.map((CategoriesRequest value) {
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
