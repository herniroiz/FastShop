class Categoria { 
  int _idCategoria;
  String _descripcion;
  int _idCategoriaSuperior;

  Categoria(int _idCategoria, String _descripcion, [Categoria _idCategoriaSuperior]);

  Categoria.fromJson(categoria) {
    _idCategoria = categoria['IdCategoria'];
    _descripcion = categoria['Descripcion'];
    _idCategoriaSuperior = categoria['IdCategoriaSuperiorFK'];
  }

  int get id => this._idCategoria;
  String get descripcion => this._descripcion;
  int get categoriaSuperior => this._idCategoriaSuperior;
}