import 'package:flutter/material.dart';
import 'package:pymemanager/ui/pages/shopping/controllerShopping.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';

class CodigoDeBarras extends StatefulWidget {
  final Function(String?) onSaved;
  final bool esEditable;
  final String label;

  // key form

  const CodigoDeBarras({
    Key? key,
    required this.onSaved,
    required this.esEditable,
    required this.label,
  }) : super(key: key);

  @override
  _CodigoDeBarrasState createState() => _CodigoDeBarrasState();
}

class _CodigoDeBarrasState extends State<CodigoDeBarras> {
  TextEditingController codigoDeBarrasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: TextFormField(
              controller: codigoDeBarrasController,
              onSaved: widget.onSaved,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(widget.label),
                hintText: "Ingrese un valor",
                border: TextFieldDesingCustom.outlineInputBorder,
                enabledBorder: TextFieldDesingCustom.outlineInputBorder,
                focusedBorder: TextFieldDesingCustom.outlineInputBorder,
                errorBorder: TextFieldDesingCustom.outlineInputBorderRed,
                focusedErrorBorder: TextFieldDesingCustom.outlineInputBorderRed,
              )),
        ),
        const SizedBox(width: 10),
        Expanded(flex: 2, child: _botonCodigoQR(context)),
      ],
    );
  }

  Material _botonCodigoQR(
    BuildContext context,
  ) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () async {
            ProductoController productoController = ProductoController();
            String codigoDeBarras = await productoController.leerCodigoBarras();
            codigoDeBarrasController.text = codigoDeBarras;
            widget.onSaved(codigoDeBarrasController.text);
          },
          child: const Icon(
            Icons.document_scanner_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
