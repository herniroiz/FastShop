
class PromocionCard {
  final int id;
  final String descripcion;
  final String rutaPoster;

  PromocionCard(this.id, this.descripcion, this.rutaPoster);

  PromocionCard.fromJSON(Map<String, dynamic> json)
    : id = json['idTipoPromocion'],
      descripcion = json['descripcion'],
      rutaPoster = json['ruta_poster'];
}