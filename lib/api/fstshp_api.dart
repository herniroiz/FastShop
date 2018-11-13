import 'dart:async';
import 'dart:convert';

import 'package:fast_shop/models/categoria.dart';
import 'package:fast_shop/models/listas.dart';
import 'package:fast_shop/models/promocion_card.dart';
import 'package:http/http.dart' as http;

///
/// FASTSHOP API
///
///

class FstShpApi {
  static const String baseUrl = 'app-1538168783.000webhostapp.com';
  // static const String baseUrl = "10.0.2.2";

  //TODO:servidor de imagenes
  final String imageBaseUrl = 'http://app-1538168783.000webhostapp.com';

  Future<List<Promocion>> promocionList() async {
    var uri = Uri.https(
      baseUrl,
      // '/~HerniRoiz/apiRest/select-Promociones.php',
      '/apiRest/select-Promociones.php',
      <String, String>{},
    );

    final response = await http.get(uri);
    var promociones = (json.decode(response.body)['results'] as List)
        .map((e) => new Promocion.fromJson(e))
        .toList();

    return promociones;
  }

  Future<List<Lista>> listasList() async {
    var uri = Uri.https(
      baseUrl,
      '/apiRest/select-Listados.php',
      <String, String>{},
    );
    final response = await http.get(uri);
    var listado = (json.decode(response.body)['results'] as List)
        .map((e) => new Lista.fromJson(e))
        .toList();

    return listado;
  }

  // Future<List<Lista>> producto() async {
  //   var uri = Uri.https(
  //     baseUrl,
  //     '/apiRest/select-Listados.php',
  //     <String, String>{},
  //   );
  //   final response = await http.get(uri);
  //   var listado = (json.decode(response.body)['results'] as List)
  //       .map((e) => new Lista.fromJson(e))
  //       .toList();

  //   return listado;
  // }





  /// Retorna el listado de categorias basado en una busqueda:
  /// [query]: cadena de caracteres que se buscan
  /// deberia guardarse en una lista para que no tenga que acceder a la BD cada vez que
  /// se realiza una nueva busqueda (osa habria que traer todas las categorias y 
  /// subcategorias y realizar el filtrado desde codigo...)
  Future<List<Categoria>> getCategoriaQuery(String query) async {
    var uri = Uri.https(
      baseUrl,
      'apiRest/select-Categorias-GET.php',
      <String, String>{
        'query': '$query',
      },
    );

    final response = await http.get(uri);
    var listado = (json.decode(response.body)['results'] as List)
        .map((e) => new Categoria.fromJson(e))
        .toList();


    return listado;
  }
}

FstShpApi api = FstShpApi();
