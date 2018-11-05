import 'dart:ui' show Color;

class Producto {
  /// identificador unico del producto.
  final int id;

  /// El nombre.
  final String nombre;

  /// color asociado al producto.
  final Color color;

  final String precio;

  const Producto(this.id, this.nombre, this.color, this.precio);



  //setters
  //TODO: cambiarlos para que traigan datos de las API

  @override
  int get hashCode => id;

  //comparador
  @override
  bool operator ==(other) => other is Producto && other.hashCode == hashCode;

  //tostring
  @override
  String toString() => "$nombre (precio=$precio)";
}
