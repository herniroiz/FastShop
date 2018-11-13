class Promocion {
  int _id;
  String _descripcion;
  String _rutaPoster;

  Promocion(int _id, String _descripcion, String _rutaPoster);

  Promocion.fromJson(promocion) {
    _id = promocion['idTipoPromocion'];
    _descripcion = promocion['descripcion'];
    _rutaPoster = promocion['ruta_poster'];
  }
  int get id => this._id;
  String get descripcion => this._descripcion;
  String get rutaPoster => this._rutaPoster;
}
