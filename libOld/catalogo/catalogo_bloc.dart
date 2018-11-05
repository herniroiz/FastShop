import 'dart:math';

import 'package:fast_shop/catalogo/catalogo_porcion.dart';
import 'package:fast_shop/servicios/catalogo.dart';
import 'package:fast_shop/servicios/catalogo_pagina.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';



/// Este componente encapsula la logica de traer productos de
/// la base de datos, pagina por pagina, de acuerdo a una posicion de una lista indefinida.
///
/// Solo los datos cercanos a la posicion son obtenidos
/// el resto se tira a la basura.

class CatalogoBloc {
  /// Utilizamos ReactiveX's [PublishSubject] por que queremos
  /// poner en el buffer el string facilmente. Mirar  el constructor [CatalogoBloc].
  final _controladorDeIndice = PublishSubject<int>();

  /// Estas paginas estan guardadas en memoria para traerlas con O(1), las guardamos en 
  /// una estructura [Map]. el valor indice es [CatalogoPagina.indiceInicial].
  final _paginas = <int, PaginaCatalogo>{};

  /// Paginas siendo traidas de la red.
  /// identidicadas por [CatalogoPagina.indiceInicial].
  final _paginasRequeridas = Set<int>();

  final _loteSujeto =
      BehaviorSubject<PorcionCatalogo>(seedValue: PorcionCatalogo.empty());

  final CatalogoServicio _catalogoServicio;

  CatalogoBloc(this._catalogoServicio) {
    _controladorDeIndice.stream
        // No hay que recargar tan frecuente
        .bufferTime(Duration(milliseconds: 500))
        // No recargar cuando no es necesario
        .where((lote) => lote.isNotEmpty)
        .listen(_manejarIndices);
  }

  /// An input of the indices that the [ListView.builder]
  /// (or [GridView.builder]) is getting in its builder callbacks. Just push
  /// the indice that you get in a [IndexedWidgetBuilder] down this [Sink].
  ///
  /// The component uses this input to figure out which paginas it should
  /// be requesting from the network.
  Sink<int> get indice => _controladorDeIndice.sink;

  /// Porciones de datos de una lista (que puede ser infinita)
  ValueObservable<PorcionCatalogo> get lote => _loteSujeto.stream;

  /// dado un indice arbitrario de un producto devuelve 
  /// la [PaginaCatalogo.indiceInicial] 
  int _getPageStartFromIndex(int indice) =>
      (indice ~/ CatalogoServicio.productosPorPagina) *
      CatalogoServicio.productosPorPagina;

  /// Maneja los [indices] entrantes (requeridos por el 
  /// [IndexedWidgetBuilder]) y si hace falta trae los datos requeridos.
  void _manejarIndices(List<int> indices) {
    const maxInt = 0x7fffffff;
    final int minIndice = indices.fold(maxInt, min);
    final int maxIndice = indices.fold(-1, max);

    final minPaginaIndice = _getPageStartFromIndex(minIndice);
    final maxPaginaIndice = _getPageStartFromIndex(maxIndice);

    for (int i = minPaginaIndice;
        i <= maxPaginaIndice;
        i += CatalogoServicio.productosPorPagina) {
      if (_paginas.containsKey(i)) continue;
      if (_paginasRequeridas.contains(i)) continue;

      _paginasRequeridas.add(i);
      _catalogoServicio.requestPage(i).then((pagina) => _manejarNuevaPagina(pagina, i));
    }

    // Remver pagians que estan lejos de la posicion actual
    _paginas.removeWhere((paginaIndice, _) =>
        paginaIndice < minPaginaIndice - CatalogoServicio.productosPorPagina ||
        paginaIndice > maxPaginaIndice + CatalogoServicio.productosPorPagina);
  }

  /// Maneja la llegada de una nueva [pagina] de la red. llama a
  /// [_enviarNuevaPorcion].
  void _manejarNuevaPagina(PaginaCatalogo pagina, int indice) {
    _paginas[indice] = pagina;
    _paginasRequeridas.remove(indice);
    _enviarNuevaPorcion();
  }

  /// Crea una [PorcionCatalogo] de las [_paginas] actuales y las
  /// envia a el stream de [lote].
  void _enviarNuevaPorcion() {
    final paginas = _paginas.values.toList(growable: false);

    final porcion = PorcionCatalogo(paginas, true);

    _loteSujeto.add(porcion);
  }
}

