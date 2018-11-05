// import 'dart:async';
// import 'dart:collection';

// import 'package:fast_shop/api/fstshp_api.dart';
// import 'package:fast_shop/blocs/bloc_provider.dart';
// import 'package:fast_shop/models/promocion_card.dart';


// class ApplicationBloc implements BlocBase {

//   ///
//   /// Synchronous Stream to handle the provision of the promociones
//   ///
//   StreamController<List<PromocionCard>> _syncController = StreamController<List<PromocionCard>>.broadcast();
//   Stream<List<PromocionCard>> get outPromocionCards => _syncController.stream;

//   /// 
//   StreamController<List<PromocionCard>> _cmdController = StreamController<List<PromocionCard>>.broadcast();
//   StreamSink get getPromocionCards => _cmdController.sink;

//   ApplicationBloc() {
//     // Read all genres from Internet
//     api.().then((list) {
//       _genresList = list;
//     });

//     _cmdController.stream.listen((_){
//       _syncController.sink.add(UnmodifiableListView<PromocionCard>(_genresList.genres));
//     });
//   }

//   void dispose(){
//     _syncController.close();
//     _cmdController.close();
//   }

//   PromocionCardsList _genresList;
 
// }
