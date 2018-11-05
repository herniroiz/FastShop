import 'package:fast_shop/models/promocion_card.dart';

class PromocionPageResult {
  final int pageIndex;
  final int totalResults;
  final int totalPages;
  final List<PromocionCard> promociones;

PromocionPageResult({this.pageIndex, this.totalResults, this.totalPages, this.promociones});

  PromocionPageResult.fromJSON(Map<String, dynamic> json)
    : pageIndex = json['page'],
      totalResults = json['total_results'],
      totalPages = json['total_pages'],
      promociones = (json['results'] as List).map((json) => PromocionCard.fromJSON(json)).toList();
}