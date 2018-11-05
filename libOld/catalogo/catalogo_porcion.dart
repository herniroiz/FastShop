import 'dart:math';

import 'package:fast_shop/common/models/producto.dart';
import 'package:fast_shop/servicios/catalogo_pagina.dart';

/// Porcion del catalogo que se provee al scrolling infinito [ListView].


class PorcionCatalogo {
  final List<PaginaCatalogo> _paginas;

  /// El indice de [Producto]s en el que la pagina empieza a proveer.
  final int indiceInicial;

  /// Whether or not this slice is the end of the catalog.
  ///
  /// Currently always `true` as our catalog is infinite.
  final bool hasNext;

  PorcionCatalogo(this._paginas, this.hasNext)
      : indiceInicial = _paginas.map((p) => p.indiceInicial).fold(0x7FFFFFFF, min);

  const PorcionCatalogo.empty()
      : _paginas = const [],
        indiceInicial = 0,
        hasNext = true;

  /// The index of the last product of this slice.
  int get endIndex =>
      indiceInicial + _paginas.map((page) => page.endIndex).fold(-1, max);

  /// Returns the product at [index], or `null` if data isn't loaded yet.
  Producto elementAt(int indice) {
    for (final pagina in _paginas) {
      if (indice >= pagina.indiceInicial && indice <= pagina.endIndex) {
        return pagina.productos[indice - pagina.indiceInicial];
      }
    }
    return null;
  }
}
