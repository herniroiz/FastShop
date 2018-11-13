import 'package:fast_shop/models/categoria.dart';

class Producto {
  int _id;
  int _codigo;
  String _descripcion;
  Categoria _categoria;
  String _marca;
  String _tipoUnidad;
  int _tamano;
  int _precio;

  Producto(int _id, int _codigo, String _descripcion, String _marca,
      String _tipoUnidad, double _tamano, double _precio,
      Categoria _categoria);

  Producto.fromJson(producto) {
    _id = producto['idProducto'];
    _codigo = producto['Codigo'];
    _descripcion = producto['Descripcion'];
    _categoria = producto['Categoria'];
    _marca = producto['Marca'];
    _tipoUnidad = producto['TipoUnidad'];
    _tamano = producto['Tamano'];
    _precio = producto['Precio'];
  }
  int get id => this._id;
  int get codigo => this._codigo;
  String get descripcion => this._descripcion;
  String get marca => this._marca;
  String get tipoUnidad => this._tipoUnidad;
  Categoria get categoria => this._categoria;
  int get tamano => this._tamano;
  int get precio => this._precio;
}
