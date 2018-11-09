import 'dart:async';
import 'dart:convert';

import 'package:fast_shop/api/fstshp_api.dart';
import 'package:fast_shop/models/listas.dart';

class Repository {
  final listasProvider = FstShpApi();

  static Future<List<Lista>> fetchListas() async {
    List<Lista> result = [];
    try {
      result = await api.listasList();
    } catch (e) {
      print(e);
    }
    return result;
  }
}