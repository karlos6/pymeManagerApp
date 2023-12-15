// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pymemanager/ui/pages/shopping/controllerShopping.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';
import '../utilities/dimensiones.dart';

class ImageTextFrom extends StatefulWidget {
  final Function(String?) onSaved;
  final String label;

  const ImageTextFrom({
    Key? key,
    required this.onSaved,
    required this.label,
  }) : super(key: key);

  @override
  _ImageTextFromState createState() => _ImageTextFromState();
}

class _ImageTextFromState extends State<ImageTextFrom> {
  File _imagen = File('');
  ProductoController productoController = ProductoController();
  final _actualizadoImagen = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Este campo es obligatorio";
                      }
                    },
                    controller: _actualizadoImagen,
                    onSaved: widget.onSaved,
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text(widget.label),
                      hintText: "Ingrese un valor",
                      border: TextFieldDesingCustom.outlineInputBorder,
                      enabledBorder: TextFieldDesingCustom.outlineInputBorder,
                      focusedBorder: TextFieldDesingCustom.outlineInputBorder,
                      errorBorder: TextFieldDesingCustom.outlineInputBorderRed,
                      focusedErrorBorder:
                          TextFieldDesingCustom.outlineInputBorderRed,
                    )),
              ),
              SizedBox(width: Adapt.wp(2, context)),
              _imagen.path.isNotEmpty
                  ? Expanded(
                      flex: 1,
                      child: InkWell(
                        // onTap: () => Navigator.pushNamed(
                        //     context, 'imagenVariablePage',
                        //     arguments: _imagen),
                        //alertDialogVisualizarImagen(context, _imagen),
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          height: Adapt.hp(5, context),
                          width: Adapt.wp(15, context),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.file(_imagen, fit: BoxFit.fill),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              IconButton(
                  onPressed: () async {
                    _imagen = await productoController.cargarImagen(2);
                    _actualizadoImagen.text = _imagen.path;
                    widget.onSaved(_actualizadoImagen.text);
                    print(_imagen.path);
                    setState(() {});
                  },
                  icon: const Icon(Icons.add_a_photo_outlined,
                      color: Colors.blue)),
              IconButton(
                  onPressed: () async {
                    _imagen = await productoController.cargarImagen(1);
                    _actualizadoImagen.text = _imagen.path;
                    widget.onSaved(_actualizadoImagen.text);
                    print(_imagen.path);
                    setState(() {});
                  },
                  icon: const Icon(Icons.image_outlined, color: Colors.blue)),
            ],
          ),
        )
      ],
    );
  }
}
