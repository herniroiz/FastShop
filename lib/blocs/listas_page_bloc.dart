import 'dart:async';
import 'dart:collection';

import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/models/listas.dart';
import 'package:fast_shop/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListaPageBloc extends BlocBase {
  List<Lista> _listas = []; 
  /// Streams para mostrar las listas
  BehaviorSubject<List<Lista>> _listController = BehaviorSubject<List<Lista>>();
  StreamSink<List<Lista>> get _listadoSink => _listController.sink;
  Stream<List<Lista>> get listadoStream => _listController.stream;
  
  ListaPageBloc(){
    _fetchListas();
    }
    
    @override
    void dispose() {
       _listController.close();
    }
    
    Future<void> _fetchListas() async{
      _listas = await Repository.fetchListas();
      _listadoSink.add(UnmodifiableListView<Lista>(_listas));
    }
}