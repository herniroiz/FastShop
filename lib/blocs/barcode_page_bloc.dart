import 'dart:async';
import 'dart:collection';

import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class BarcodePageBloc extends BlocBase {
  //Lista de todos los barcodes
  List<int> _barcodes = List<int>();

  //interface para agregar un nuevo codigo de barras escaneado
  BehaviorSubject<int> _barcodeAddController = BehaviorSubject<int>();
  StreamSink<int> get inAddBarcode => _barcodeAddController.sink;

  BehaviorSubject<List<int>> _barcodeController =
      new BehaviorSubject<List<int>>();
  Sink<List<int>> get _inBarcodes => _barcodeController.sink;
  Stream<List<int>> get outBarcodes => _barcodeController.stream;

  BehaviorSubject<int> _barcodeOutController = BehaviorSubject<int>();
  Sink<int> get _inBarcode => _barcodeOutController.sink;
  Stream<int> get outBarcode => _barcodeOutController.stream;

  //Bloc para manejar el estado de la camara
  // BehaviorSubject<bool> _camStateController = BehaviorSubject<bool>(seedValue: false);
  // StreamSink<bool> get inCamState => _camStateController.sink;
  // Stream<bool> get outCamState => _camStateController.stream;

  BarcodePageBloc() {
    _barcodeAddController.listen(_handleAddBarcode);
    // _camStateController.listen(_handleAddCamState);
  }

  @override
  void dispose() {
    _barcodeController.close();
    _barcodeAddController.close();
    _barcodeOutController.close();
  }

  void _handleAddBarcode(int barcode) {
    if (!_barcodes.contains(barcode)) {
      _barcodes.add(barcode);
      _notify(barcode);
    }
  }

  void _notify(int barcode) {
    // The new list of all favorite movies
    _inBarcode.add(barcode);
    _inBarcodes.add(UnmodifiableListView(_barcodes));
  }

  //     void _handleAddCamState(bool event) {
  //       // inCamState.add(event);
  // }
}
