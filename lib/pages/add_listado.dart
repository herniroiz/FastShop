import 'package:fast_shop/blocs/add_listado_page_provider.dart';
import 'package:flutter/material.dart';

class AddListadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addListadoBloc = AddListadoPageBlocProvider.of(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          //TODO: agregar el nombre del listado
          title: Text('Listado'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                onChanged: addListadoBloc.query.add,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Buscar una categoria (ej: almacen)',
                ),
              ),
            ),
            StreamBuilder(
              stream: addListadoBloc.log,
              builder: (context, snapshot) => Container(
                    child: Text(snapshot?.data ?? ''),
                  ),
            ),
            Flexible(
              child: StreamBuilder(
                stream: addListadoBloc.results,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text(snapshot.data[index].descripcion),
                          // subtitle: Text(snapshot.data[index].descripcion), me va a servir para el favorito
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
