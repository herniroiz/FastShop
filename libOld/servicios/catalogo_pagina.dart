import 'dart:collection';

import 'package:fast_shop/common/models/producto.dart';

/// Una pagina de items del catalogo traida de internet.
///
///Trae resultados en lotes de la api de productos


class PaginaCatalogo {
  final List<Producto> _productos;

  final int indiceInicial;

  PaginaCatalogo(this._productos, this.indiceInicial);

  int get count => _productos.length;

  int get endIndex => indiceInicial + count - 1;

  UnmodifiableListView<Producto> get productos =>
      UnmodifiableListView<Producto>(_productos);

  @override
  String toString() => "_PaginaCatalogo($indiceInicial-$endIndex)";
}
