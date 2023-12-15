import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pymemanager/domain/request/priceRequest.dart';
import 'package:pymemanager/domain/request/productsRequest.dart';
import 'package:pymemanager/ui/pages/shopping/controllerShopping.dart';
import 'package:pymemanager/ui/utilities/dimensiones.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';
import 'package:pymemanager/ui/widgets/TextFromFieldTextt.dart';
import 'package:pymemanager/ui/widgets/codigoDeBarras.dart';
import 'package:pymemanager/ui/widgets/dateTextFrom.dart';
import 'package:pymemanager/ui/widgets/dropdownCategories.dart';
import 'package:pymemanager/ui/widgets/dropdownSuppliers.dart';
import 'package:pymemanager/ui/widgets/imageTextFrom.dart';
import 'package:pymemanager/ui/widgets/menu.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  ProductoController productoController = ProductoController();
  List<ProductsRequest> listaProductos = [];
  bool enEspera = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProductsRequest productsRequest = ProductsRequest();
  PriceRequest precioCompra = PriceRequest();
  PriceRequest precioVenta = PriceRequest();
  bool isVisible = true;
  ScrollController scrollController = ScrollController();
  ProductsRequest registroProducto = ProductsRequest();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializacion();
    inicializarControlerScroll();
  }

  inicializacion() async {
    listaProductos = await productoController.listarProductos();
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
            title: const Text('Compras'),
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
                          Text(
                              'Descripción: ${listaProductos[index].description}'),
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
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        _botonDetallesIncidente(context, index),
                        const SizedBox(
                          width: 5,
                        ),
                        _botonActualizarIncidente(context, index),
                        const SizedBox(
                          width: 5,
                        ),
                        _botonEliminarIncidente(context, index),
                      ]),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text("Registrar proveedor",
                      style: TextStyle(
                          fontSize: Adapt.px(25), color: Colors.white)),
                  onPressed: () {
                    _registerAndUpdate(
                        context: context,
                        titulo: "Registrar producto",
                        tipo: 1,
                        actualizarProducto: ProductsRequest(),
                        esInmodificable: false);
                  },
                ),
              ),
            )),
      ),
    );
  }

  Widget _botonDetallesIncidente(BuildContext context, int index) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () {
            _registerAndUpdate(
                context: context,
                titulo: "Detalles Proveedor",
                tipo: 3,
                actualizarProducto: listaProductos[index],
                esInmodificable: true);
          },
          child: const Icon(
            Icons.remove_red_eye_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _botonEliminarIncidente(BuildContext context, int index) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () async {
            bool cargar = await productoController.eliminarProducto(
                context, listaProductos[index].id, listaProductos[index].name);
            if (cargar) {
              inicializacion();
            }
          },
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Material _botonActualizarIncidente(BuildContext context, int index) {
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
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _registerAndUpdate(
      {required BuildContext context,
      required String titulo,
      required int tipo,
      required ProductsRequest actualizarProducto,
      required bool esInmodificable}) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        btnCancel: tipo != 3
            ? TextButton(
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
              )
            : null,
        btnOk: TextButton(
          onPressed: () async {
            if (tipo != 3) {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                Navigator.pop(context);
                if (tipo == 1) {
                  await productoController.crearProducto(
                      context, registroProducto, precioCompra, precioVenta);
                  inicializacion();
                } else if (tipo == 2) {
                  await productoController.actualizarProducto(
                      context, actualizarProducto);
                }
              }
            } else {
              Navigator.pop(context);
            }
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
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  titulo,
                  style: TextFieldDesingCustom.styleTextBold(fontSize: 20),
                ),
                SizedBox(height: Adapt.hp(3, context)),

                // Codigo de barras
                CodigoDeBarras(
                  onSaved: (value) => tipo == 1
                      ? registroProducto.id = value!
                      : actualizarProducto.id = value!,
                  esEditable: false,
                  label: "Codigo de barras",
                ),
                SizedBox(height: Adapt.hp(2, context)),

                // Nombre del producto
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroProducto.name = value!
                        : actualizarProducto.name = value!,
                    esEditable: esInmodificable,
                    label: "Nombre del producto",
                    valorInicial: tipo == 1
                        ? registroProducto.name
                        : actualizarProducto.name),
                SizedBox(height: Adapt.hp(2, context)),

                //Stock
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroProducto.stock = int.parse(value!)
                        : actualizarProducto.stock = int.parse(value!),
                    esEditable: esInmodificable,
                    label: "Stock",
                    valorInicial:
                        tipo == 1 ? null : actualizarProducto.stock.toString()),
                SizedBox(height: Adapt.hp(2, context)),

                // Peso
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroProducto.weight = double.parse(value!)
                        : actualizarProducto.weight = double.parse(value!),
                    esEditable: esInmodificable,
                    label: "Peso",
                    valorInicial: tipo == 1
                        ? null
                        : actualizarProducto.weight.toString()),
                SizedBox(height: Adapt.hp(2, context)),

                // Categorias
                DropdownCategories(
                  onSaved: (value) => tipo == 1
                      ? registroProducto.categoryId = int.parse(value!)
                      : actualizarProducto.categoryId = int.parse(value!),
                  label: "Categorias",
                ),
                SizedBox(height: Adapt.hp(2, context)),

                // Precio de compra
                TextFromFieldText(
                  label: 'Precio de compra',
                  onSaved: (value) => precioCompra.price = double.parse(value!),
                  esEditable: false,
                ),
                SizedBox(height: Adapt.hp(2, context)),

                // Precio de venta
                TextFromFieldText(
                  label: 'Precio de venta',
                  onSaved: (value) => precioVenta.price = double.parse(value!),
                  esEditable: false,
                ),
                SizedBox(height: Adapt.hp(2, context)),

                DateTextFrom(
                  label: 'Fecha de expiración',
                  onSaved: (value) => tipo == 1
                      ? registroProducto.expirationDate = value!
                      : actualizarProducto.expirationDate = value!,
                ),
                SizedBox(height: Adapt.hp(2, context)),

                DropdownSuppliers(
                  onSaved: (value) => tipo == 1
                      ? registroProducto.supplierId = int.parse(value!)
                      : actualizarProducto.supplierId = int.parse(value!),
                  label: "Proveedores",
                ),
                SizedBox(height: Adapt.hp(2, context)),

                ImageTextFrom(
                  label: 'Imagen',
                  onSaved: (value) => tipo == 1
                      ? registroProducto.image = value!
                      : actualizarProducto.image = value!,
                ),
                SizedBox(height: Adapt.hp(2, context)),

                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroProducto.description = value!
                        : actualizarProducto.description = value!,
                    esEditable: esInmodificable,
                    label: "descripcion",
                    valorInicial: tipo == 1
                        ? registroProducto.description
                        : actualizarProducto.description),
                SizedBox(height: Adapt.hp(2, context)),
              ],
            ),
          ),
        )).show();
  }
}
