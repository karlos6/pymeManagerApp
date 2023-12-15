import 'package:flutter/material.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';

class TextFromFieldText extends StatefulWidget {
  final Function(String?) onSaved;
  final bool? esEditable;
  final String label;
  final String? valorInicial;

  const TextFromFieldText({
    Key? key,
    required this.onSaved,
    this.esEditable = false,
    required this.label,
    this.valorInicial,
  }) : super(key: key);

  @override
  _TextFromFieldTextState createState() => _TextFromFieldTextState();
}

class _TextFromFieldTextState extends State<TextFromFieldText> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: widget.esEditable == null ? false : widget.esEditable!,
        initialValue: widget.valorInicial,
        validator: (value) {
          if (value!.isEmpty) {
            return "Este campo es obligatorio";
          }
        },
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
        ));
  }
}
