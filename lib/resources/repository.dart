import 'dart:async';

import 'package:fast_shop/api/fstshp_api.dart';
import 'package:fast_shop/models/categoria.dart';
import 'package:fast_shop/models/listas.dart';
import 'package:fast_shop/models/producto.dart';
import 'package:fast_shop/models/promocion_card.dart';

class Repository {
  static Future<List<Lista>> fetchListas() async {
    List<Lista> result = [];
    try {
      result = await api.listasList();
    } catch (e) {
      // print(e);
    }
    return result;
  }

  static Future<List<Promocion>> fetchPromociones() async {
    List<Promocion> result = [];
    try {
      result = await api.promocionList();
    } catch (e) {
      // print(e);
    }
    return result;
  }

  static Future<List<Categoria>> fetchQueryCategoria(String query) async{
    List<Categoria> result = [];
    try {
      result = await api.getCategoriaQuery(query);
    } catch (e) {
      // print(e);
    }
    return result;
  }

  static Future<Producto> fetchProductoScanned(code) async{
    Producto result;
    try {
      result = await api.fetchProductoScanned(code);
    } catch (e) {
      result = null;
    }
    return result;
  }
}
