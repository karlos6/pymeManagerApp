import 'package:flutter/material.dart';
import 'package:pymemanager/ui/utilities/dimensiones.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _enEspera = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _fondo(),
        _formularioLogin(),
      ],
    );
  }

  Widget _fondo() {
    return Center(
      child: Container(
        width: Adapt.wp(100, context),
        height: Adapt.hp(100, context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/fondo_arp.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _formularioLogin() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Adapt.wp(3, context),
          vertical: Adapt.hp(3, context),
        ),
        width: Adapt.wp(70, context),
        height: Adapt.hp(40, context),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color.fromARGB(200, 255, 255, 255),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _logo(),
              SizedBox(height: Adapt.hp(2, context)),
              _usuarioText(),
              SizedBox(height: Adapt.hp(2, context)),
              _passwordText(),
              SizedBox(height: Adapt.hp(2, context)),
              _botonEntrar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usuarioText() {
    return TextFormField(
      onSaved: (value) {},
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: TextFieldDesingCustom.outlineInputBorder,
        disabledBorder: TextFieldDesingCustom.outlineInputBorder,
        focusedBorder: TextFieldDesingCustom.outlineInputBorder,
        errorBorder: TextFieldDesingCustom.outlineInputBorderRed,
        focusedErrorBorder: TextFieldDesingCustom.outlineInputBorderRed,
        counterText: "",
        prefixIcon: const Icon(
          Icons.person_outline_outlined,
        ),
        label: const Text(
          'Usuario',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      onChanged: (value) {},
    );
  }

  Widget _passwordText() {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: TextFieldDesingCustom.outlineInputBorder,
        disabledBorder: TextFieldDesingCustom.outlineInputBorder,
        focusedBorder: TextFieldDesingCustom.outlineInputBorder,
        errorBorder: TextFieldDesingCustom.outlineInputBorderRed,
        focusedErrorBorder: TextFieldDesingCustom.outlineInputBorderRed,
        counterText: "",
        prefixIcon: const Icon(
          Icons.lock_outline,
        ),
        label: const Text(
          'Contraseña',
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      onChanged: (value) {},
    );
  }

  Widget _botonEntrar() {
    return SizedBox(
      height: 40,
      width: Adapt.wp(40, context),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () async {
          _enEspera = true;
          Navigator.pushReplacementNamed(context, 'salesList');
          setState(() {});
        },
        child: _enEspera
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : const Text('Entrar',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _logo() {
    return Container(
      width: Adapt.wp(55, context),
      height: Adapt.hp(8, context),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/Pyme_logo.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
