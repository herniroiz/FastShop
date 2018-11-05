import 'dart:async';

import 'package:fast_shop/common/models/item_carrito.dart';
import 'package:fast_shop/common/models/producto.dart';
import 'package:fast_shop/servicios/carrito.dart';
import 'package:rxdart/rxdart.dart';

class AdicionCarrito {
  final Producto producto;
  final int cuenta;

  AdicionCarrito(this.producto, [this.cuenta = 1]);
}

class CarritoBloc {
  // Este es el estado interno. Es un objeto de ayuda para que
  // en esta clase solo se trabaje con streams.
  final _carrito = ServicioCarrito();

  // objetos internos a los cuales se les provee los streams / sinks 
  final _items = BehaviorSubject<List<ItemCarrito>>(seedValue: []);
  final _itemCount = BehaviorSubject<int>(seedValue: 0);
  final _controladorAdicionCarrito = StreamController<AdicionCarrito>();

  CarritoBloc() {
    _controladorAdicionCarrito.stream.listen(_manejarAdicion);
  }

  /// Esta es la entrada para añadir productos al carrito. Utilizar esta señal
  /// para el componente del usuario que esta queriendo agregar un producto al carrito.
  Sink<AdicionCarrito> get adicionCarrito => _controladorAdicionCarrito.sink;

  /// Este stream adopta un nuevo valor cada vez que cambia el valor del carrito
  ///
  ///
  /// usamos la funcion `distinct()` para que sean publicados en el stram
  /// productos que son validos
  
  ValueObservable<int> get itemCount => _itemCount
      .distinct()
      // Como usamos el operador distinct necesitamos reconvertir
      // a un ValueObservable usando shareValue.
      .shareValue(seedValue: 0);

  /// este es el stream de items del carrito. Usar para mostrar el contenido
  /// del carrito cuando necesitamos toda la informacion en [ItemCarrito].
  ValueObservable<List<ItemCarrito>> get items => _items.stream;

  /// Hacemos algo con los streams cerrantes
  void dispose() {
    _items.close();
    _itemCount.close();
    _controladorAdicionCarrito.close();
  }

  /// Logica de negocio para agregar productos al carrito. 
  void _manejarAdicion(AdicionCarrito addition) {
    _carrito.add(addition.producto, addition.cuenta);
    _items.add(_carrito.items);
    _itemCount.add(_carrito.itemCount);
  }
}
