// import 'dart:async';
// import 'dart:math';
// import 'dart:ui';

// import 'package:fast_shop/common/models/promocion.dart';
// import 'package:fast_shop/servicios/promocion_pagina.dart';
// import 'package:random_string/random_string.dart';

// /// Clase para servicio de conexion http
// class PromocionServicio{
//   /// La cantidad de promocions en cada retorno [PaginaPromocion].
//   /// 
//   /// Cambiando esta variable mientras la app esta corriendo no tiene un comportamiento definido.
//   /// Variable inicial que se setea una sola vez.
//   static int promocionesPorPagina = 10;

//   // SIMULA  UNA CONEXION A LA RED, 
//   // TODO: REALIZAR UNA CONEXION VERDADERA

//   /// delay enre el request y la respuesta del servidor (simulada)
//   static int networkDelay = 500;

//   /// Trae una pagina de promocions de la base de datos. El valor [offset]
//   /// sera guardado en [PaginaPromocion.startindex]
//   Future<PaginaPromocion> requestPage(int offset) async{
//     //simular delay de la red
//     await Future.delayed(Duration(milliseconds: networkDelay));

//     //crea una lista random de promocions. 
//     final random = Random(offset);
//     final promociones = List.generate(promocionesPorPagina, (index){
//       final id = random.nextInt(0xffff);
//       final color = Color(0xFF000000 | random.nextInt(0xFFFFFF));
//       final nombre = randomAlpha(7);
//       return Promocion(id, nombre, color);
//     });
//     return PaginaPromocion(promociones, offset);
//   }

// }