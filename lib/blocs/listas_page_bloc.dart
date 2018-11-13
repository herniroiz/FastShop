import 'dart:async';
import 'dart:collection';

import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/models/listas.dart';
import 'package:fast_shop/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListaBloc extends BlocBase {
  /// Streams para mostrar las listas de compras
  BehaviorSubject<List<Lista>> _listController = BehaviorSubject<List<Lista>>();
  StreamSink<List<Lista>> get _inListadoList => _listController.sink;
  Stream<List<Lista>> get outListadoList => _listController.stream;

  /// Constructor
  ListaBloc() {
    _fetchListas();
  }

  @override
  void dispose() {
    _listController.close();
  }

  ///
  /// Metodo de conexion con el servicio que trae las listas
  /// de compras
  ///
  Future<void> _fetchListas() async {
    List<Lista> _listas = [];
    _listas = await Repository.fetchListas();
    _inListadoList.add(UnmodifiableListView<Lista>(_listas));
  }
}
