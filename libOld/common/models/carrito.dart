import 'dart:collection';
import 'dart:math';

import 'package:fast_shop/common/models/item_carrito.dart';
import 'package:fast_shop/common/models/producto.dart';

class Carrito {
  final List<ItemCarrito> _items = <ItemCarrito>[];

  /// Crea un carrito vacio.
  Carrito();

  /// Crea un Carrito de un Carrito viejo
  Carrito.clone(Carrito carrito) {
    _items.addAll(carrito._items);
  }

  /// Llena un carrito con muestras de productos.
  Carrito.sample(Iterable<Producto> productos) {
    _items.addAll(productos.take(3).map((producto) => ItemCarrito(1, producto)));
  }

  /// Cuenta total de items en el carrito, incluyendo duplicados del mismo item.
  ///
  /// Hace basicamente [items.length], con la diferencia que solo cuenta
  /// cada producto una sola vez, no importa cuantos haya comprado del mismo producto.
  int get itemCount => _items.fold(0, (sum, el) => sum + el.count);

  /// Este es el estado actual del carrito.
  ///
  /// Es un listado por que los usuarios esperan que sus items aparezcan
  /// en el mismo orden en que los compraron.
  ///
  /// Usar [add] y [remove] para modificar el estado.
  UnmodifiableListView<ItemCarrito> get items => UnmodifiableListView(_items);

  /// Agrega el [producto] al carrito. O actualiza un [ItemCarrito] existente
  /// en los [items] o agrega uno al final del listado.
  void add(Producto producto, [int count = 1]) {
    _updateCount(producto, count);
  }

  /// Remueve el [producto] del carrito. O actualiza un [ItemCarrito] existente 
  /// en los [items] o lo remueve (si la cuenta llega a `0`).
  void remove(Producto producto, [int count = 1]) {
    _updateCount(producto, -count);
  }

  @override
  String toString() => "$items";

  void _updateCount(Producto producto, int diferencia) {
    if (diferencia == 0) return;
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      if (producto == item.producto) {
        final nuevaCuenta = item.count + diferencia;
        if (nuevaCuenta <= 0) {
          _items.removeAt(i);
          return;
        }
        _items[i] = ItemCarrito(nuevaCuenta, item.producto);
        return;
      }
    }
    if (diferencia < 0) return;
    _items.add(ItemCarrito(max(diferencia, 0), producto));
  }
}
