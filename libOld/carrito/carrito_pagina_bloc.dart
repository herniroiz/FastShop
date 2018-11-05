import 'package:flutter/material.dart';
import 'package:fast_shop/common/models/item_carrito.dart';
import 'package:fast_shop/common/widgets/carrito_pagina.dart';
import 'package:fast_shop/carrito/carrito_proveedor.dart';

class CarritoPaginaBloc extends StatelessWidget {
  CarritoPaginaBloc();

  static const routeName = "/carrito";

  @override
  Widget build(BuildContext context) {
    final carrito = ProveedorCarrito.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tu Carrito"),
      ),
      body: StreamBuilder<List<ItemCarrito>>(
          stream: carrito.items,
          builder: (context, snapshot) {
            if (snapshot.data?.isEmpty ?? true) {
              return Center(
                  child: Text('El carrito está vacio',
                      style: Theme.of(context).textTheme.display1));
            }

            return ListView(
                children:
                    snapshot.data.map((item) => ItemMosaico(item: item)).toList());
          }),
    );
  }
}
