// import 'dart:collection';

// import 'package:fast_shop/common/models/promocion.dart';

// /// Una pagina de items del catalogo traida de internet.
// ///
// ///Trae resultados en lotes de la api de productos


// class PaginaPromocion {
//   final List<Promocion> _promocion;

//   final int indiceInicial;

//   PaginaPromocion(this._promocion, this.indiceInicial);

//   int get count => _promocion.length;

//   int get endIndex => indiceInicial + count - 1;

//   UnmodifiableListView<Promocion> get promociones =>
//       UnmodifiableListView<Promocion>(_promocion);

//   @override
//   String toString() => "_PaginaPromocion($indiceInicial-$endIndex)";
// }
