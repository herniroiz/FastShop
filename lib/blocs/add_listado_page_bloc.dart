import 'dart:async';

import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/models/categoria.dart';
import 'package:fast_shop/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AddListadoBloc extends BlocBase {

  Stream<List<Categoria>> _results = Stream.empty();
  Stream<String> _log = Stream.empty();

  ReplaySubject<String> _query = ReplaySubject<String>();

  Stream<String> get log => _log;
  Stream<List<Categoria>> get results => _results;
  Sink<String> get query => _query;

  AddListadoBloc() {
    _results = _query.distinct().asyncMap(Repository.fetchQueryCategoria).asBroadcastStream();

    _log = Observable(results)
        .withLatestFrom(_query.stream, (_, query) => 'Resultados de productos para $query')
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _query.close();
  }
}