import 'dart:async';
import 'dart:collection';

import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/models/promocion_card.dart';
import 'package:fast_shop/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PromocionBloc extends BlocBase {
  /// Streams para mostrar las listas de compras
  BehaviorSubject<List<Promocion>> _promocionController =
      BehaviorSubject<List<Promocion>>();
  StreamSink<List<Promocion>> get _inPromocionList =>
      _promocionController.sink;
  Stream<List<Promocion>> get outPromocionList =>
      _promocionController.stream;

  /// Constructor
  PromocionBloc() {
    _fetchPromociones();
  }

  @override
  void dispose() {
    _promocionController.close();
  }

  ///
  /// Metodo de conexion con el servicio que trae las listas
  /// de compras
  ///
  Future<void> _fetchPromociones() async {
    List<Promocion> _listas = [];
    _listas = await Repository.fetchPromociones();
    _inPromocionList.add(UnmodifiableListView<Promocion>(_listas));
  }
}
