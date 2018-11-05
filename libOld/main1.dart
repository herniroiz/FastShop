import 'package:flutter/material.dart';

import 'package:fast_shop/carrito/carrito_bloc.dart';
import 'package:fast_shop/carrito/carrito_pagina_bloc.dart';
import 'package:fast_shop/carrito/carrito_proveedor.dart';
import 'package:fast_shop/catalogo/catalogo_bloc.dart';
import 'package:fast_shop/catalogo/catalogo_proveedor.dart';
import 'package:fast_shop/common/widgets/theme.dart';
import 'package:fast_shop/fastshop_home.dart';
import 'package:fast_shop/servicios/catalogo.dart';


// se crea un nuevo 
void main() {
  // Servicios iniciales
  // recibe todo el catalogo de productos
  final catalogoService = CatalogoServicio();

  // setea componentes para toda la app
  final catalogo = CatalogoBloc(catalogoService);
  // final listado = ListadoBloc();
  final carrito = CarritoBloc();
  
  // iniciar la app
  // runApp(MyApp(catalogo, listado, carrito));
  runApp(MyApp(catalogo, carrito));
}


class MyApp extends StatelessWidget {
  final CatalogoBloc catalogo;
  
  final CarritoBloc carrito;
  
  //final ListadoBloc listado;
  
  // MyApp(this.catalogo, this.carrito, this.listado);
  MyApp(this.catalogo, this.carrito);


  @override
  Widget build(BuildContext context) {
    return ProveedorCatalogo(
    // aca proveemos el componente catalogo...
    catalogo: catalogo,
      // ... y los componentes carrito y listado a traves de InheritedWidget.
      child: ProveedorCarrito(
        carritoBloc: carrito,
        // listadoBloc: listado,
        child: MaterialApp(
          title: 'FASTSHOP',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: FastshopHome(),
          routes: { CarritoPaginaBloc.routeName: (context) => CarritoPaginaBloc()},
        ),
      ),
    );
  }
}