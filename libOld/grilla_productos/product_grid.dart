import 'package:flutter/material.dart';


import 'package:fast_shop/carrito/carrito_bloc.dart';
import 'package:fast_shop/carrito/carrito_proveedor.dart';
import 'package:fast_shop/catalogo/catalogo_bloc.dart';
import 'package:fast_shop/catalogo/catalogo_porcion.dart';
import 'package:fast_shop/catalogo/catalogo_proveedor.dart';
import 'package:fast_shop/grilla_productos/product_square.dart';

/// Displays an infinite grid of products.
class ProductoList extends StatelessWidget {


  /// The number of items that will be rendered as loading below the last
  /// loaded item.
  ///
  /// When this is `0`, the user is not able to scroll beyond the items that
  /// are already loaded. If it's a small number, the user is not able to
  /// "flick" many pages down the catalog, since the scrolling stops.
  static const _loadingSpace = 40;

  ProductoList();


  @override
  Widget build(BuildContext context) {
    final cartBloc = ProveedorCarrito.of(context);
    final catalogBloc = ProveedorCatalogo.of(context);
    return StreamBuilder<PorcionCatalogo>(
      stream: catalogBloc.lote,
      initialData: catalogBloc.lote.value,
      builder: (context, snapshot) => ListView.builder(
            //tamano del listado!!
            itemExtent: 120.0,
            itemCount: snapshot.data.endIndex + _loadingSpace,
            itemBuilder: (context, index) =>
                _createSquare(index, snapshot.data, catalogBloc, cartBloc),
          ),
    );
  }

  /// Builds a square of the product on a given [index] in the catalog.
  /// Also sends the [index] to the [catalogBloc] so it can potentially load
  /// more data.
  Widget _createSquare(int index, PorcionCatalogo slice, CatalogoBloc catalogBloc,
      CarritoBloc cartBloc) {
    // Notify catalog BLoC of the latest index that the framework is trying
    // to build.
    catalogBloc.indice.add(index);

    // Get data.
    final product = slice.elementAt(index);

    // Display spinner if waiting for data.
    if (product == null) {
      return Center(child: CircularProgressIndicator());
    }

    // Display data.
    return ProductSquare(
      key: Key(product.id.toString()),
      producto: product,
      itemsStream: cartBloc.items,
      onTap: () {
        cartBloc.adicionCarrito.add(AdicionCarrito(product));
      },
    );
  }
}
