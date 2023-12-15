// ignore_for_file: use_build_context_synchronously
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pymemanager/domain/request/suppliersRequest.dart';
import 'package:pymemanager/ui/pages/suppliers/controllerSuppliers.dart';
import 'package:pymemanager/ui/utilities/dimensiones.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';
import 'package:pymemanager/ui/widgets/TextFromFieldTextt.dart';
import 'package:pymemanager/ui/widgets/menu.dart';

class SuppliersList extends StatefulWidget {
  const SuppliersList({super.key});

  @override
  State<SuppliersList> createState() => _SuppliersListState();
}

class _SuppliersListState extends State<SuppliersList> {
  List<SuppliersRequest> listaSuppliers = [];
  ControllerSuppliers cotrollerSuppliers = ControllerSuppliers();
  final _formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  bool isVisible = true;
  bool enEspera = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializacion();
    inicializarControlerScroll();
  }

  inicializacion() async {
    enEspera = true;
    setState(() {});
    listaSuppliers = await cotrollerSuppliers.listarSuppliers();
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
            title: const Text('Proveedores'),
          ),
          body: _body()),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _listaSuppliers(),
        _botonRegistrarCategoria(),
      ],
    );
  }

  Widget _listaSuppliers() {
    return enEspera
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : SizedBox(
            child: ListView.builder(
              controller: scrollController,
              itemCount: listaSuppliers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(listaSuppliers[index].name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dirección: ${listaSuppliers[index].address}'),
                          Text('Telefono: ${listaSuppliers[index].phone}'),
                          Text('Email: ${listaSuppliers[index].email}'),
                        ],
                      ),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        _botonDetallesIncidente(context, listaSuppliers[index]),
                        const SizedBox(
                          width: 5,
                        ),
                        _botonActualizarIncidente(
                            context, listaSuppliers[index]),
                        const SizedBox(
                          width: 5,
                        ),
                        _botonEliminarCategoria(context, listaSuppliers[index]),
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
                        titulo: "Registrar proveedor",
                        tipo: 1,
                        actualizarSuppliers: SuppliersRequest(),
                        esInmodificable: false);
                  },
                ),
              ),
            )),
      ),
    );
  }

  Widget _botonDetallesIncidente(
      BuildContext context, SuppliersRequest supplierRequest) {
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
                actualizarSuppliers: supplierRequest,
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

  Widget _botonEliminarCategoria(
      BuildContext context, SuppliersRequest supplierRequest) {
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
            bool cargar = await cotrollerSuppliers.eliminarSuppliers(
                context, supplierRequest.id, supplierRequest.name);
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

  Material _botonActualizarIncidente(
      BuildContext context, SuppliersRequest supplierRequest) {
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
          onTap: () {
            _registerAndUpdate(
                context: context,
                titulo: "Actualizar Proveedor",
                tipo: 2,
                actualizarSuppliers: supplierRequest,
                esInmodificable: false);
          },
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
      required SuppliersRequest actualizarSuppliers,
      required bool esInmodificable}) {
    SuppliersRequest registroSuppliers = SuppliersRequest();
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
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pop(context);
                if (tipo == 1) {
                  await cotrollerSuppliers.crearSuppliers(
                      context, registroSuppliers);
                  inicializacion();
                } else if (tipo == 2) {
                  await cotrollerSuppliers.actualizarSuppliers(
                      context, actualizarSuppliers);
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
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  titulo,
                  style: TextFieldDesingCustom.styleTextBold(fontSize: 20),
                ),
                SizedBox(height: Adapt.hp(3, context)),

                //Categoria
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroSuppliers.name = value!
                        : actualizarSuppliers.name = value!,
                    esEditable: esInmodificable,
                    label: "Categoria",
                    valorInicial: tipo == 1
                        ? registroSuppliers.name
                        : actualizarSuppliers.name),
                SizedBox(height: Adapt.hp(2, context)),

                //Direccion
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroSuppliers.address = value!
                        : actualizarSuppliers.address = value!,
                    esEditable: esInmodificable,
                    label: "Direccion",
                    valorInicial: tipo == 1
                        ? registroSuppliers.address
                        : actualizarSuppliers.address),
                SizedBox(height: Adapt.hp(2, context)),

                // Telefono
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroSuppliers.phone = value!
                        : actualizarSuppliers.phone = value!,
                    esEditable: esInmodificable,
                    label: "Telefono",
                    valorInicial: tipo == 1
                        ? registroSuppliers.phone
                        : actualizarSuppliers.phone),
                SizedBox(height: Adapt.hp(2, context)),

                // Email
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroSuppliers.email = value!
                        : actualizarSuppliers.email = value!,
                    esEditable: esInmodificable,
                    label: "Email",
                    valorInicial: tipo == 1
                        ? registroSuppliers.email
                        : actualizarSuppliers.email),
                SizedBox(height: Adapt.hp(2, context)),

                // Sitio Web
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroSuppliers.website = value!
                        : actualizarSuppliers.website = value!,
                    esEditable: esInmodificable,
                    label: "Sitio Web",
                    valorInicial: tipo == 1
                        ? registroSuppliers.website
                        : actualizarSuppliers.website),
                SizedBox(height: Adapt.hp(2, context)),

                // Nombre de contacto
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroSuppliers.contact_name = value!
                        : actualizarSuppliers.contact_name = value!,
                    esEditable: esInmodificable,
                    label: "Nombre de contacto",
                    valorInicial: tipo == 1
                        ? registroSuppliers.contact_name
                        : actualizarSuppliers.contact_name),
                SizedBox(height: Adapt.hp(2, context)),

                // Telefono de contacto
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroSuppliers.contact_phone = value!
                        : actualizarSuppliers.contact_phone = value!,
                    esEditable: esInmodificable,
                    label: "Telefono de contacto",
                    valorInicial: tipo == 1
                        ? registroSuppliers.contact_phone
                        : actualizarSuppliers.contact_phone),
                SizedBox(height: Adapt.hp(2, context)),

                // Email de contacto
                TextFromFieldText(
                    onSaved: (value) => tipo == 1
                        ? registroSuppliers.contact_email = value!
                        : actualizarSuppliers.contact_email = value!,
                    esEditable: esInmodificable,
                    label: "Email de contacto",
                    valorInicial: tipo == 1
                        ? registroSuppliers.contact_email
                        : actualizarSuppliers.contact_email),
              ],
            ),
          ),
        )).show();
  }
}
