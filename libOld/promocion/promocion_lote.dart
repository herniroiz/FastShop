// import 'dart:math';

// import 'package:fast_shop/common/models/promocion.dart';
// import 'package:fast_shop/servicios/promocion_pagina.dart';

// /// Lote de promociones que provee al scrolling infinito [ListView].

// // class LotePromocion {
//   final List<PaginaPromocion> _paginas;

//   /// El indice de [Promocion] en el que la pagina empieza a proveer.
//   final int indiceInicial;

//   /// El lote es el ultimo dentro de los lotes de promociones.
//   final bool hasNext;

//   LotePromocion(this._paginas, this.hasNext)
//       : indiceInicial = _paginas.map((p) => p.indiceInicial).fold(0x7FFFFFFF, min);

//   const LotePromocion.empty()
//       : _paginas = const [],
//         indiceInicial = 0,
//         hasNext = true;

//   /// El indice de la ultima promocion del lote.
//   int get endIndex =>
//       indiceInicial + _paginas.map((page) => page.endIndex).fold(-1, max);

//   /// Retorna la promocion en el [indice], o `null` si no hay nada cargado.
//   Promocion elementAt(int indice) {
//     for (final pagina in _paginas) {
//       if (indice >= pagina.indiceInicial && indice <= pagina.endIndex) {
//         return pagina.promociones[indice - pagina.indiceInicial];
//       }
//     }
//     return null;
//   }
// }
