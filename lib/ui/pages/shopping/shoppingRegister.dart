import 'package:flutter/material.dart';
import 'package:pymemanager/domain/request/priceRequest.dart';
import 'package:pymemanager/domain/request/productsRequest.dart';
import 'package:pymemanager/ui/utilities/dimensiones.dart';
import 'package:pymemanager/ui/widgets/TextFromFieldTextt.dart';
import 'package:pymemanager/ui/widgets/codigoDeBarras.dart';
import 'package:pymemanager/ui/widgets/dateTextFrom.dart';
import 'package:pymemanager/ui/widgets/dropdownCategories.dart';
import 'package:pymemanager/ui/widgets/dropdownSuppliers.dart';
import 'package:pymemanager/ui/widgets/imageTextFrom.dart';
import 'package:pymemanager/ui/widgets/menu.dart';

class ShoppingRegister extends StatefulWidget {
  const ShoppingRegister({super.key});

  @override
  State<ShoppingRegister> createState() => _ShoppingRegisterState();
}

class _ShoppingRegisterState extends State<ShoppingRegister> {
  bool _enEspera = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProductsRequest _productsRequest = ProductsRequest();
  PriceRequest precioCompra = PriceRequest();
  PriceRequest precioVenta = PriceRequest();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: const Menu(),
          appBar: AppBar(
            title: const Text('Registrar producto'),
          ),
          body: _body()),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.wp(10, context), vertical: Adapt.hp(2, context)),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: Adapt.hp(1, context)),
              CodigoDeBarras(
                onSaved: (value) => _productsRequest.id = value!,
                esEditable: false,
                label: "Codigo de barras",
              ),
              SizedBox(height: Adapt.hp(2, context)),
              TextFromFieldText(
                label: 'Nombre del producto',
                onSaved: (value) => _productsRequest.name = value!,
                esEditable: false,
              ),
              SizedBox(height: Adapt.hp(2, context)),
              TextFromFieldText(
                label: 'Stock',
                onSaved: (value) => _productsRequest.stock = int.parse(value!),
                esEditable: false,
              ),
              SizedBox(height: Adapt.hp(2, context)),
              TextFromFieldText(
                label: 'Peso',
                onSaved: (value) =>
                    _productsRequest.weight = double.parse(value!),
                esEditable: false,
              ),
              SizedBox(height: Adapt.hp(2, context)),
              DropdownCategories(
                onSaved: (value) =>
                    _productsRequest.categoryId = int.parse(value!),
                label: "Categorias",
              ),
              TextFromFieldText(
                onSaved: (value) => precioCompra.price = double.parse(value!),
                label: "Precio de compra",
              ),
              TextFromFieldText(
                onSaved: (value) => precioVenta.price = double.parse(value!),
                label: "Precio de venta",
              ),
              SizedBox(height: Adapt.hp(2, context)),
              DateTextFrom(
                label: 'Fecha de expiración',
                onSaved: (value) => _productsRequest.expirationDate = value!,
              ),
              SizedBox(height: Adapt.hp(2, context)),
              DropdownSuppliers(
                onSaved: (value) =>
                    _productsRequest.supplierId = int.parse(value!),
                label: "Proveedores",
              ),
              SizedBox(height: Adapt.hp(2, context)),
              ImageTextFrom(
                label: 'Imagen',
                onSaved: (value) => _productsRequest.image = value!,
              ),
              SizedBox(height: Adapt.hp(2, context)),
              TextFromFieldText(
                label: 'Descripción',
                onSaved: (value) => _productsRequest.description = value!,
                esEditable: false,
              ),
              SizedBox(height: Adapt.hp(3, context)),
              _botonRegistrar(),
              SizedBox(height: Adapt.hp(1, context)),
            ],
          ),
        ),
      ),
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
          onTap: () {},
          child: const Icon(
            Icons.document_scanner_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _botonRegistrar() {
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
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            precioCompra.productId = _productsRequest.id;
            precioVenta.productId = _productsRequest.id;
            precioCompra.date = DateTime.now().toString();
            precioVenta.date = DateTime.now().toString();
            print(_productsRequest.toJson());
          }
          _enEspera = false;

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
            : const Text('Registrar',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold)),
      ),
    );
  }
}
