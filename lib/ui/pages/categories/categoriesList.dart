// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pymemanager/domain/request/categoriesRequest.dart';
import 'package:pymemanager/ui/pages/categories/controllerCategories.dart';
import 'package:pymemanager/ui/utilities/dimensiones.dart';
import 'package:pymemanager/ui/utilities/textfield_desing.dart';
import 'package:pymemanager/ui/widgets/TextFromFieldTextt.dart';
import 'package:pymemanager/ui/widgets/mensaje_alerta.dart';
import 'package:pymemanager/ui/widgets/menu.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<CategoriesRequest> listaCategorias = [];
  CotrollerCategorias cotrollerCategorias = CotrollerCategorias();
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
    listaCategorias = await cotrollerCategorias.listarCategorias();
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
            title: const Text('Categorias'),
          ),
          body: _body()),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _listaCategorias(),
        _botonRegistrarCategoria(),
      ],
    );
  }

  Widget _listaCategorias() {
    return enEspera
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : SizedBox(
            child: ListView.builder(
              controller: scrollController,
              itemCount: listaCategorias.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(listaCategorias[index].name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Código: ${listaCategorias[index].id}'),
                        ],
                      ),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        _botonActualizarIncidente(
                            context, listaCategorias[index]),
                        const SizedBox(
                          width: 5,
                        ),
                        _botonEliminarCategoria(
                            context, listaCategorias[index]),
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
                  child: Text("Registrar categoria",
                      style: TextStyle(
                          fontSize: Adapt.px(25), color: Colors.white)),
                  onPressed: () {
                    _registerAndUpdate(
                        context: context,
                        titulo: "Registrar categoria",
                        esRegistro: true,
                        categoriesActualizacion: CategoriesRequest());
                  },
                ),
              ),
            )),
      ),
    );
  }

  Widget _botonEliminarCategoria(
      BuildContext context, CategoriesRequest categoriesRequest) {
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
            bool cargar = await cotrollerCategorias.eliminarCategoria(
                context, categoriesRequest.id);
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
      BuildContext context, CategoriesRequest categoriesRequest) {
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
                titulo: "Actualizar categoria",
                esRegistro: false,
                categoriesActualizacion: categoriesRequest);
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
      required bool esRegistro,
      required CategoriesRequest categoriesActualizacion}) {
    CategoriesRequest categoriesRegistro = CategoriesRequest();
    AwesomeDialog(
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
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.pop(context);
              if (esRegistro) {
                await cotrollerCategorias.crearCategoria(
                    context, categoriesRegistro);
              } else {
                await cotrollerCategorias.actualizarCategoria(
                    context, categoriesActualizacion);
              }
              inicializacion();
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
                TextFromFieldText(
                    onSaved: (value) => esRegistro
                        ? categoriesRegistro.name = value!
                        : categoriesActualizacion.name = value!,
                    esEditable: false,
                    label: "Categoria",
                    valorInicial: esRegistro
                        ? categoriesRegistro.name
                        : categoriesActualizacion.name),
              ],
            ),
          ),
        )).show();
  }
}
