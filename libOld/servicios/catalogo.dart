import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:fast_shop/common/models/producto.dart';
import 'package:fast_shop/servicios/catalogo_pagina.dart';
import 'package:random_string/random_string.dart';

/// Clase para servicio de conexion http
class CatalogoServicio{
  /// La cantidad de productos en cada retorno [CalatogoPage].
  /// 
  /// Cambiando esta variable mientras la app esta corriendo no tiene un comportamiento definido.
  /// Variable inicial que se setea una sola vez.
  static int productosPorPagina = 10;

  // SIMULA  UNA CONEXION A LA RED, 
  // TODO: REALIZAR UNA CONEXION VERDADERA

  /// delay enre el request y la respuesta del servidor (simulada)
  static int networkDelay = 500;

  /// Trae una pagina de productos de la base de datos. El valor [offset]
  /// sera guardado en [CatalogoPage.startindex]
  Future<PaginaCatalogo> requestPage(int offset) async{
    //simular delay de la red
    await Future.delayed(Duration(milliseconds: networkDelay));

    //crea una lista random de productos. 
    final random = Random(offset);
    final productos = List.generate(productosPorPagina, (index){
      final id = random.nextInt(0xffff);
      final color = Color(0xFF000000 | random.nextInt(0xFFFFFF));
      final precio = random.nextInt(100).toString();
      final nombre = randomAlpha(7);
      return Producto(id, nombre, color, precio);
    });
    return PaginaCatalogo(productos, offset);
  }

}

