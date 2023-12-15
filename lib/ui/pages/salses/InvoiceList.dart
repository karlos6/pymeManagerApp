// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pymemanager/data/http/customersHttp.dart';
import 'package:pymemanager/domain/request/customersRequest.dart';
import 'package:pymemanager/domain/request/invoiceRequest.dart';
import 'package:pymemanager/domain/request/priceRequest.dart';
import 'package:pymemanager/domain/request/productsRequest.dart';
import 'package:pymemanager/domain/request/salesRequest.dart';
import 'package:pymemanager/ui/pages/salses/controllerSale.dart';
import 'package:pymemanager/ui/utilities/dimensiones.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';
import 'package:pymemanager/ui/widgets/TextFromFieldTextt.dart';
import 'package:pymemanager/ui/widgets/menu.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({super.key});

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  ControllerInvoice invoiceController = ControllerInvoice();
  InvoiceRequest invoiceRequest = InvoiceRequest();
  List<ProductsRequest> listaProductos = [];
  SaleRequest saleRequest = SaleRequest();
  bool enEspera = true;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  List<SaleRequest> totalVentas = [];

  bool isVisible = true;
  ScrollController scrollController = ScrollController();
  double totalSaldo = 0.0;
  List<CustomersRequest> listaCustomers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializacion();
    inicializarControlerScroll();
  }

  inicializacion() async {
    listaProductos = await invoiceController.listarProductos();
    listaCustomers = await invoiceController.listarClientes();

    enEspera = false;
    setState(() {});
  }

  inicializarControlerScroll() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible) {
          setState(() {
            isVisible = false;
          });
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isVisible) {
          setState(() {
            isVisible = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: Menu(),
          appBar: AppBar(
            title: const Text('Vender productos'),
          ),
          body: _body()),
    );
  }

  Widget _body() {
    return Stack(
      children: [_listaProductos(), _botonRegistrarCategoria()],
    );
  }

  Widget _listaProductos() {
    return enEspera
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : SizedBox(
            child: ListView.builder(
              controller: scrollController,
              itemCount: listaProductos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(listaProductos[index].name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Código: ${listaProductos[index].id}'),
                          Text('Stock: ${listaProductos[index].stock}'),
                          Text(
                              'Fecha expedición: ${listaProductos[index].expirationDate}'),
                        ],
                      ),
                      leading: Container(
                        color: Colors.blue[100],
                        width: Adapt.wp(13, context),
                        height: Adapt.hp(12, context),
                        child: Image.asset(
                          'assets/img/productos.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      trailing: _botonActualizarIncidente(
                          context, listaProductos[index]),
                    ),
                  ),
                );
              },
            ),
          );
  }

  Padding _botonRegistrarCategoria() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: isVisible ? 60.0 : 0.0,
            child: Center(
              child: SizedBox(
                width: Adapt.wp(70, context),
                height: Adapt.hp(6, context),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // agregar icono al lado derecho y un texto de facturar
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Facturar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.shopping_cart_outlined),
                      const SizedBox(width: 10),
                      totalVentas.isNotEmpty
                          ? //circulo rojo con el numero
                          Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  totalVentas.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  onPressed: () {
                    for (SaleRequest element in totalVentas) {
                      print(
                          "Items: ${element.productName}***************************+");
                    }

                    invoiceRequest.items = totalVentas;
                    _registrarProductos(context: context);
                  },
                ),
              ),
            )),
      ),
    );
  }

  Material _botonActualizarIncidente(
      BuildContext context, ProductsRequest producto) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () async {
            PriceRequest precioVenta = await invoiceController
                .precioCompraProducto(producto.id.toString());
            _cantidadComprar(
                context: context,
                titulo: "Cantidad a comprar",
                producto: producto,
                precioVenta: precioVenta);
          },
          child: const Icon(
            // icono carro de compra
            Icons.shopping_cart_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _cantidadComprar(
      {required BuildContext context,
      required String titulo,
      required ProductsRequest producto,
      required PriceRequest precioVenta}) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        btnCancel: TextButton(
          onPressed: () {
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
          onPressed: () async {
            if (!keyForm.currentState!.validate()) return;
            keyForm.currentState!.save();
            saleRequest.productId = producto.id;
            saleRequest.productName = producto.name;
            saleRequest.description = producto.description;
            saleRequest.unitPrice = precioVenta.price;
            totalVentas.add(saleRequest);

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
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                TextFromFieldText(
                  onSaved: (value) => saleRequest.quantity = int.parse(value!),
                  label: "Cantidad",
                ),
                SizedBox(height: Adapt.hp(2, context)),
                TextFromFieldText(
                  onSaved: (value) =>
                      saleRequest.discount = double.parse(value!),
                  label: "Descuento",
                ),
              ],
            ),
          ),
        )).show();
  }

  _registrarProductos({
    required BuildContext context,
  }) {
    for (SaleRequest element in totalVentas) {
      totalSaldo += (element.unitPrice * element.quantity) -
          (element.unitPrice * element.quantity) * (element.discount / 100);
    }
    AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        btnCancel: TextButton(
          onPressed: () {
            totalSaldo = 0.0;
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
        btnOk: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            for (SaleRequest element in totalVentas) {
              element.total = (element.unitPrice * element.quantity) -
                  (element.unitPrice * element.quantity) *
                      (element.discount / 100);
            }
            invoiceRequest.total = totalSaldo;
            totalSaldo = 0.0;
            invoiceRequest.items = totalVentas;
            totalVentas = [];
            invoiceController.crearCategoria(context, invoiceRequest);
            Navigator.pop(context);
          },
          child: Text(
            '$totalSaldo',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: "facturas",
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Factura",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: Adapt.hp(2, context)),
                Text("Codigo factura: ${invoiceRequest.invoiceNumber}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: Adapt.hp(2, context)),
                DropdownButtonFormField<String>(
                    //onSaved: widget.onSaved,
                    value: invoiceRequest.customerId.isEmpty
                        ? null
                        : invoiceRequest.customerId,
                    validator: (value) {
                      if (value == null) {
                        return "Este campo es obligatorio";
                      }
                    },
                    isExpanded: true,
                    items: listaCustomers.map((CustomersRequest value) {
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
                        if (newValue != null) {
                          invoiceRequest.customerId = newValue;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      label: const Text("Cliente"),
                      hintText: "Ingrese un valor",
                      border: TextFieldDesingCustom.outlineInputBorder,
                      enabledBorder: TextFieldDesingCustom.outlineInputBorder,
                      focusedBorder: TextFieldDesingCustom.outlineInputBorder,
                      errorBorder: TextFieldDesingCustom.outlineInputBorderRed,
                      focusedErrorBorder:
                          TextFieldDesingCustom.outlineInputBorderRed,
                    )),
                SizedBox(height: Adapt.hp(2, context)),
                invoiceRequest.customerId != ""
                    ? Text("Cliente: ${invoiceRequest.customerNumber}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ))
                    : const SizedBox(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: totalVentas.length,
                    itemBuilder: (context, indice) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(totalVentas[indice].productName,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Cantidad: ${totalVentas[indice].quantity}'),
                                Text(
                                    'Precio: ${totalVentas[indice].unitPrice}'),
                              ],
                            ),
                            leading: Container(
                              color: Colors.blue[100],
                              width: Adapt.wp(13, context),
                              height: Adapt.hp(12, context),
                              child: Image.asset(
                                'assets/img/productos.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )).show();
  }
}
