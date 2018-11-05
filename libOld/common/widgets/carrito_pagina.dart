import 'package:flutter/material.dart';
import 'package:fast_shop/common/models/carrito.dart';
import 'package:fast_shop/common/models/item_carrito.dart';
import 'package:fast_shop/common/utils/is_dark.dart';

class PaginaCarrito extends StatelessWidget {
  PaginaCarrito(this.carrito);
  final Carrito carrito;

  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tu carrito"),
      ),
      body: carrito.items.isEmpty
          ? Center(
              child: Text('El carrito esta vacio', style: Theme.of(context).textTheme.display1))
          : ListView(
              children:
                  carrito.items.map((item) => ItemMosaico(item: item)).toList()),
    );
  }
}

class ItemMosaico extends StatelessWidget {
  ItemMosaico({this.item});
  final ItemCarrito item;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        color: isDark(item.producto.color) ? Colors.white : Colors.black);

    return Container(
      color: item.producto.color,
      child: ListTile(
        title: Text(
          item.producto.nombre,
          style: textStyle,
        ),
        trailing: CircleAvatar(
            backgroundColor: const Color(0x33FFFFFF),
            child: Text(item.count.toString(), style: textStyle)),
      ),
    );
  }
}
