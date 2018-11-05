import 'package:fast_shop/common/models/producto.dart';

/// Una sola fila del carrito.
class ItemCarrito {
  final int count;
  final Producto producto;

  const ItemCarrito(this.count, this.producto);

  @override
  String toString() => "${producto.nombre} ✕ $count";
}
