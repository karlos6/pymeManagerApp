// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';

class DateTextFrom extends StatefulWidget {
  final String label;
  final Function(String?) onSaved;

  const DateTextFrom({
    Key? key,
    required this.label,
    required this.onSaved,
  }) : super(key: key);

  @override
  _DateTextFromState createState() => _DateTextFromState();
}

class _DateTextFromState extends State<DateTextFrom> {
  String? dropdownValue;
  final _actualizadoInputFecha = TextEditingController();

  Future<DateTime?> _optenerFecha() {
    return showDatePicker(
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050 + 50));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Este campo es obligatorio";
          }
        },
        onSaved: widget.onSaved,
        controller: _actualizadoInputFecha,
        readOnly: true,
        onTap: () async {
          DateTime? newDateTime = await _optenerFecha();

          if (newDateTime == null) {
            return;
          }
          String fechaBusqueda = newDateTime.toString().substring(0, 10);
          _actualizadoInputFecha.text = fechaBusqueda;
        },
        keyboardType: TextInputType.text,
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
