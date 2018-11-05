import 'package:fast_shop/carrito/carrito_pagina_bloc.dart';
import 'package:fast_shop/common/widgets/carrito_boton.dart';
import 'package:fast_shop/grilla_productos/product_grid.dart';
import 'package:fast_shop/grilla_promociones/promocion_grid.dart';
import 'package:flutter/material.dart';
import 'package:fast_shop/carrito/carrito_proveedor.dart';

class FastshopHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartBloc = ProveedorCarrito.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
            Tab(
              text: "PROMOS",
            ),
            Tab(
              text: "LISTADO",
            ),
            Tab(
              text: "CARRITO",
            ),
            ],
          ),
          title: Text('FASTSHOP'),
          actions: <Widget>[
          StreamBuilder<int>(
            stream: cartBloc.itemCount,
            initialData: cartBloc.itemCount.value,
            builder: (context, snapshot) => BotonCarrito(
                  itemCount: snapshot.data,
                  onPressed: () {
                    Navigator.of(context).pushNamed(CarritoPaginaBloc.routeName);
                  },
                ),
          )
        ],
        ),
        body: TabBarView(
          children: [
            //PromocionGrid(),
            ProductoList(),
            PromocionGrid(),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}