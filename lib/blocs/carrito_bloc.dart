import 'dart:async';
import 'dart:collection';

import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/models/producto.dart';
import 'package:fast_shop/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CarritoBloc extends BlocBase {



  ///Listado de productos del articulo de compra
  List<Producto> _carrito = List<Producto>();
  // Listado de los codigos de barra escaneados
  List<int> _barcodes = List<int>();



  //interfaz para agregar un nuevo codigo de barras escaneado
  BehaviorSubject<int> _barcodeAddController = BehaviorSubject<int>();
  StreamSink<int> get inAddBarcode => _barcodeAddController.sink;


  ///interfaz para obtener el listado de todos los articulos del carrito
  BehaviorSubject<List<Producto>> _carritoController = BehaviorSubject<List<Producto>>();
  StreamSink<List<Producto>> get _inCarrito => _carritoController.sink;
  Stream<List<Producto>> get outCarrito => _carritoController.stream;



  BehaviorSubject<List<int>> _barcodeController = new BehaviorSubject<List<int>>();
  Sink<List<int>> get _inBarcodes => _barcodeController.sink;
  Stream<List<int>> get outBarcodes => _barcodeController.stream;
  ///
  /// Interfaz para obtener la cantidad total de articulos del carrito
  ///
  BehaviorSubject<int> _carritoTotalController =
      new BehaviorSubject<int>(seedValue: 0);
  Sink<int> get _inTotalCarrito => _carritoTotalController.sink;
  Stream<int> get outTotalCarrito => _carritoTotalController.stream;



  ///
  /// Interfaz que permite agregar un nuevo articulo al carrito
  ///
  BehaviorSubject<Producto> _articuloAddController =
      new BehaviorSubject<Producto>();
  Sink<Producto> get inAddArticulo => _articuloAddController.sink;


  ///
  ///interfaz para agregar un nuevo codigo de barras al listado
  BehaviorSubject<int> _barcodeOutController = BehaviorSubject<int>();
  Sink<int> get _inBarcode => _barcodeOutController.sink;
  Stream<int> get outBarcode => _barcodeOutController.stream;




  ///
  /// Interfaz que permite eliminar un articulo del articulo
  ///
  BehaviorSubject<Producto> _articuloRemoveController =
      new BehaviorSubject<Producto>();
  Sink<Producto> get inRemoveArticulo => _articuloRemoveController.sink;

  CarritoBloc() {
    _articuloAddController.listen(_handleAddArticulo);
    _articuloRemoveController.listen(_handleRemoveArticulo);
    _barcodeAddController.listen(_handleAddBarcode);
  }

  @override
  void dispose() {
    _carritoController.close();
    _carritoTotalController.close();
    _articuloAddController.close();
    _articuloRemoveController.close();
    _barcodeController.close();
    _barcodeAddController.close();
    _barcodeOutController.close();
  }

  void _handleAddArticulo(Producto event) {
    _carrito.add(event);
    _notifyAdd();
  }
    
      void _handleRemoveArticulo(Producto event) {
        _carrito.remove(event);
        _notifyRemove();
              }
              // void _notify() {
              //   // Enviar a interesados...
              //   // El numero todal de articulos en el carrito
              //   _inTotalCarrito.add(_articulo.length);
            
              //   // El nuevo carrito de todos los articulos
              //   _inCarrito.add(UnmodifiableListView(_articulo));
              // }
            
              Future _handleAddBarcode(int barcode) async {
                if (!_barcodes.contains(barcode)) {
                  _barcodes.add(barcode);
                  _notify(barcode);

                  var _producto = await Repository.fetchProductoScanned(barcode);
                  if (_producto != null)
                  {
                    _carrito.add(_producto);
                    _notifyAdd();
                  }
                }
              }
            
              void _notify(int barcode) {
                // The new list of all favorite movies
                _inBarcode.add(barcode);
                _inBarcodes.add(UnmodifiableListView(_barcodes));
              }
            
              void _notifyAdd() {
                _inCarrito.add(_carrito);
              }
            void _notifyRemove() {}






}
