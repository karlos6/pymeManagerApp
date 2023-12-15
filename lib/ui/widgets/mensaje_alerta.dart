import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';
import '../utilities/dimensiones.dart';

modalDeCarga(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      context = context;
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 105,
                width: 105,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: Adapt.hp(1, context),
                    ),
                    Text(
                      "Cargando",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future alertaDialogo(
    {required BuildContext context,
    required DialogType dialogType,
    required String titulo,
    required String contenido,
    required Color color}) async {
  await AwesomeDialog(
    width: Adapt.px(550),
    dismissOnTouchOutside: false,
    context: context,
    dialogType: dialogType,
    animType: AnimType.rightSlide,
    title: titulo,
    desc: contenido,
    titleTextStyle: TextFieldDesingCustom.styleTextBold(fontSize: 20),
    descTextStyle: TextFieldDesingCustom.styleTextNormal(fontSize: 15),
    btnOk: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Aceptar',
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ).show();
}

Future<bool> alertaEliminacion({
  required BuildContext context,
  required String titulo,
  required String contenido,
}) async {
  bool isDelete = false;
  await AwesomeDialog(
    width: Adapt.px(550),
    dismissOnTouchOutside: false,
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.rightSlide,
    title: titulo,
    desc: contenido,
    titleTextStyle: TextFieldDesingCustom.styleTextBold(fontSize: 20),
    descTextStyle: TextFieldDesingCustom.styleTextNormal(fontSize: 15),
    btnCancel: TextButton(
      onPressed: () {
        isDelete = false;
        Navigator.pop(context);
      },
      child: const Text(
        'Cancelar',
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    btnOk: TextButton(
      onPressed: () {
        isDelete = true;
        Navigator.pop(context);
      },
      child: const Text(
        'Aceptar',
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ).show();
  return isDelete;
}
