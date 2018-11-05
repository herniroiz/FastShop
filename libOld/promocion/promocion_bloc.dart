import 'dart:async';

import 'package:fast_shop/common/models/promocion.dart';

import 'package:rxdart/rxdart.dart';

class PromocionBloc {
  final API api;

  Stream<List<Promocion>> _results = Stream.empty();


  ReplaySubject<String> _query = ReplaySubject<String>();

  Stream<List<Promocion>> get results => _results;
  Sink<String> get query => _query;

  PromocionBloc(this.api) {
    _results = _query.distinct().asyncMap(api.get).asBroadcastStream();
  }

  void dispose() {
    _query.close();
  }
}




// import 'dart:math';

// import 'package:fast_shop/promocion/promocion_lote.dart';
// import 'package:fast_shop/servicios/promocion.dart';
// import 'package:fast_shop/servicios/promocion_pagina.dart';
// import 'package:flutter/widgets.dart';
// import 'package:rxdart/rxdart.dart';



// /// Este componente encapsula la logica de traer promociones de
// /// la base de datos, pagina por pagina, de acuerdo a una posicion de una lista indefinida.
// ///
// /// Solo los datos cercanos a la posicion que se encuentra en pantalla son obtenidos
// /// el resto se tira a la basura.

// class PromocionBloc {
//   /// Utilizamos ReactiveX's [PublishSubject] por que queremos
//   /// poner en el buffer el string facilmente. Mirar el constructor [PromocionBloc].
//   final _controladorDeIndice = PublishSubject<int>();

//   /// Estas paginas estan guardadas en memoria para traerlas con O(1), las guardamos en 
//   /// una estructura [Map]. el valor indice es [PromocionPagina.indiceInicial].
//   final _paginas = <int, PaginaPromocion>{};

//   /// Paginas siendo traidas de la red.
//   /// identidicadas por [PromocionPagina.indiceInicial].
//   final _paginasRequeridas = Set<int>();

//   final _loteSujeto =
//       BehaviorSubject<LotePromocion>(seedValue: LotePromocion.empty());

//   final PromocionServicio _promocionServicio;

//   PromocionBloc(this._promocionServicio) {
//     _controladorDeIndice.stream
//         // No hay que recargar tan frecuente
//         .bufferTime(Duration(milliseconds: 500))
//         // No recargar cuando no es necesario
//         .where((lote) => lote.isNotEmpty)
//         .listen(_manejarIndices);
//   }

//   /// Indices que el [ListView.builder] o el  [GridView.builder]) 
//   /// toman como entrada de los callbacks al contructor. Hacer push en 
//   /// el componente [Sink] del indice que se obtiene con [IndexedWidgetBuilder] .
//   ///
//   /// Este componente usa su entrada para resolver que paginas tiene que traer
//   /// de internet.
//   Sink<int> get indice => _controladorDeIndice.sink;

//   /// Porciones de datos de una lista (que puede ser infinita)
//   ValueObservable<LotePromocion> get lote => _loteSujeto.stream;

//   /// dado un indice arbitrario de un producto, se devuelve 
//   /// el [PaginaPromocion.indiceInicial] 
  
//   int _getPageStartFromIndex(int indice) =>
//       (indice ~/ PromocionServicio.promocionesPorPagina) *
//       PromocionServicio.promocionesPorPagina;

//   /// Maneja los [indices] entrantes (requeridos por el [IndexedWidgetBuilder]) 
//   /// y si hace falta trae los datos requeridos.
//   void _manejarIndices(List<int> indices) {
//     const maxInt = 0x7fffffff;
//     final int minIndice = indices.fold(maxInt, min);
//     final int maxIndice = indices.fold(-1, max);

//     final minPaginaIndice = _getPageStartFromIndex(minIndice);
//     final maxPaginaIndice = _getPageStartFromIndex(maxIndice);

//     for (int i = minPaginaIndice;
//         i <= maxPaginaIndice;
//         i += PromocionServicio.promocionesPorPagina) {
//       if (_paginas.containsKey(i)) continue;
//       if (_paginasRequeridas.contains(i)) continue;

//       _paginasRequeridas.add(i);
//       _promocionServicio.requestPage(i).then((pagina) => _manejarNuevaPagina(pagina, i));
//     }

//     // Remver pagians que estan lejos de la posicion actual
//     _paginas.removeWhere((paginaIndice, _) =>
//         paginaIndice < minPaginaIndice - PromocionServicio.promocionesPorPagina ||
//         paginaIndice > maxPaginaIndice + PromocionServicio.promocionesPorPagina);
//   }

//   /// Maneja la llegada de una nueva [pagina] de la red. llama a
//   /// [_enviarNuevaPorcion].
//   void _manejarNuevaPagina(PaginaPromocion pagina, int indice) {
//     _paginas[indice] = pagina;
//     _paginasRequeridas.remove(indice);
//     _enviarNuevaPorcion();
//   }

//   /// Crea un [LotePromocion] de las [_paginas] actuales y las
//   /// envia a el stream de [lote]s.
//   void _enviarNuevaPorcion() {
//     final paginas = _paginas.values.toList(growable: false);

//     final porcion = LotePromocion(paginas, true);

//     _loteSujeto.add(porcion);
//   }

//   /// este es el stream de items del carrito. Usar para mostrar el contenido
//   /// del carrito cuando necesitamos toda la informacion en [ItemCarrito].
//   ValueObservable<List<Promocion>> get items => _.stream;
// }



