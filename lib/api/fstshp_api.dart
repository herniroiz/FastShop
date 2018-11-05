import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fast_shop/models/promocion_page_result.dart';

///
/// FASTSHOP API
/// 
/// 

class FstShpApi {
  static const String baseUrl = 'app-1538168783.000webhostapp.com';
  //TODO:servidor de imagenes
  final String imageBaseUrl = 'http://app-1538168783.000webhostapp.com';
  final _httpClient = new HttpClient();

  ///
  /// Retorna el listado de categorias basado en criterios:
  /// [tipo]: categoria Padre o hijo
  /// [pageIndex]: pagina
  /// [categoriaSup]: categoriaSuperior
  ///
  // Future<CategoriaPageResult> pagedList({String tipo: "hijo", int pageIndex: 1, int categoriaSup: 0}) async {
  //   var uri = Uri.https(
  //     baseUrl,
  //     '3/discover/$tipo',
  //     <String, String>{
  //       'api_key': TMDB_API_KEY,
  //       'language': 'en-US',
  //       'sort_by': 'popularity.desc',
  //       'include_adult': 'false',
  //       'include_video': 'false',
  //       'page': '$pageIndex',
  //       'release_date.gte': '$minYear',
  //       'release_date.lte': '$maxYear',
  //       'with_genres': '$genre',
  //     },
  //   );

  //   var response = await _getRequest(uri);
  //   PromocionPageResult list = PromocionPageResult.fromJSON(json.decode(response));

  //   // Give some additional delay to simulate slow network
  //   await Future.delayed(const Duration(seconds: 1));

  //   return list;
  // }


  Future<PromocionPageResult> pagedPromocionList({int pageIndex: 1}) async {
    var uri = Uri.https(
      baseUrl,
      '/apiRest/select-Promociones.php',
      <String, String>{
        'page': '$pageIndex',
      },
    );

    var response = await _getRequest(uri);
    PromocionPageResult list = PromocionPageResult.fromJSON(json.decode(response));

    return list;
  }




  ///
  /// Returns the list of all genres
  ///
  // Future<MovieGenresList> movieGenres({String type: "movie"}) async {
  //   var uri = Uri.https(
  //     baseUrl,
  //     '3/genre/$type/list',
  //     <String, String>{
  //       'api_key': TMDB_API_KEY,
  //       'language': 'en-US',
  //     },
  //   );

  //   var response = await _getRequest(uri);
  //   MovieGenresList list = MovieGenresList.fromJSON(json.decode(response));

  //   return list;
  // }

  ///
  /// Routine to invoke the TMDB Web Server to get answers
  ///
  Future<String> _getRequest(Uri uri) async {
    var request = await _httpClient.getUrl(uri);
    var response = await request.close();

    return response.transform(utf8.decoder).join();
  }
}

FstShpApi api = FstShpApi();
