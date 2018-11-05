import 'dart:math';
import 'dart:ui' show Color;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//import 'api_key.dart';

class Promocion {
  /// identificador unico de ls promocion.
  final int id;

  /// El nombre.
  final String nombre;

  /// color asociado a la promocion.
   final Color color;

  const Promocion(this.id, this.nombre, this.color, );

  

  //setters
  //TODO: cambiarlos para que traigan datos de las API

  @override
  int get hashCode => id;

  //comparador
  @override
  bool operator ==(other) => other is Promocion && other.hashCode == hashCode;

  //tostring
  @override
  String toString() => "$nombre";

  Promocion.fromJson(Map json)
      : id = json['idTipoPromociom'],
        nombre = json["descripcion"],
        color =  Color(0xFF000000 | Random().nextInt(0xFFFFFF));
}



class API {
  final http.Client _client = http.Client();
  //reemplazar por api que busque promociones
  static const String _url =
      'https://app-1538168783.000webhostapp.com/apiRest/select-Promociones.php';

  Future<List<Promocion>> get(String query) async {
    List<Promocion> list = [];

    await _client
        .get(Uri.parse(_url))
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json["results"])
        .then((promociones) =>
            promociones.forEach((promocion) => list.add(Promocion.fromJson(promocion))));

    return list;
  }
}