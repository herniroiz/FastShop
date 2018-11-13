class Lista {
  int _id;
  String _descripcion;
  String _fechaCreacion;

  Lista(int _id, String _descripcion, String _fechaCreacion);

  Lista.fromJson(lista) {
    _id = lista['idListado'];
    _descripcion = lista['descripcion'];
    DateTime _fechaDT = DateTime.parse(lista['fechaCreacion']);
    _fechaCreacion =
        "${_fechaDT.day.toString()}/${_fechaDT.month.toString()}/${_fechaDT.year.toString()}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idListado'] = this._id;
    data['descripcion'] = this._descripcion;
    data['fechaCreacion'] = this._fechaCreacion;
    return data;
  }

  int get id => this._id;
  String get descripcion => this._descripcion;
  String get fechaCreacion => this._fechaCreacion;
}
