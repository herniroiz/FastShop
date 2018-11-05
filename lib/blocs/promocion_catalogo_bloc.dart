import 'dart:async';
import 'dart:collection';

import 'package:fast_shop/api/fstshp_api.dart';
import 'package:fast_shop/blocs/bloc_provider.dart';
import 'package:fast_shop/models/promocion_card.dart';
import 'package:fast_shop/models/promocion_page_result.dart';
import 'package:rxdart/rxdart.dart';

class PromocionCatalogoBloc implements BlocBase {
  ///
  /// Numero maximo de promociones traidas por pagina
  ///
  final int _promocionesPorPagina = 20;

  ///
  /// Numero total de promociones en el catalogo
  ///
  int _totalPromociones = -1; 

  ///
  /// Lista todas las promociones traidas de Internet.
  /// Utilizamos un [Map]a para guardarlos, para poder identificar
  /// el indice de la pagina mas facilmente
  ///
  final _fetchPages = <int, PromocionPageResult>{};

  ///
  /// Lista de las paginas actualmente siendo traidas de Internet
  ///
  final _pagesBeingFetched = Set<int>();




  // ##########  STREAMS  ##############

  ///
  /// Necesitaremos el listado de promociones
  ///
  PublishSubject<List<PromocionCard>> _promocionesController = PublishSubject<List<PromocionCard>>();
  Sink<List<PromocionCard>> get _inPromocionesList => _promocionesController.sink;
  Stream<List<PromocionCard>> get outPromocionesList => _promocionesController.stream;

  ///
  /// Cada vez que tenemos que renderizar una PromocionCard, pasaremos su [index]
  /// para que podamos chequear si ya fue traida de internet
  /// Sino, automaticamente se traera.
  ///
  PublishSubject<int> _indexController = PublishSubject<int>();
  Sink<int> get inPromocionIndex => _indexController.sink;

  ///
  /// listeners para saber si una modificacion se aplico a la cantidad de promociones
  /// servira en un futuro si se busca filtrar las promociones.
  ///
  BehaviorSubject<int> _totalPromocionesControlles = BehaviorSubject<int>(seedValue: 0);
  Sink<int> get _inTotalPromociones => _totalPromocionesControlles.sink;
  Stream<int> get outTotalPromociones => _totalPromocionesControlles.stream;


  ///
  /// Constructor
  ///
  PromocionCatalogoBloc() {
    //
    // Cada vez que tengamos que renderizar una PromocionCard, se enviara un [index] 
    // de la promocion a renderizar.  
    // si no ha sido traida de internet necesitaremos traerla
    // Para eso necesiramos escuchar cada pedido para poderlo manejar.
    //
    _indexController.stream
                    // tomamos un cierto tiempo entre cada request
                    .bufferTime(Duration(microseconds: 500))
                    // no actualizamos cuando no necesitamos
                    .where((batch) => batch.isNotEmpty)
                    .listen(_handleIndexes);
  }

  void dispose(){
    _promocionesController.close();
    _indexController.close();
    _totalPromocionesControlles.close();
  }



  // ############# HANDLING  #####################

  ///
  /// para cada index de producto, necesitamos chequear si 
  /// ha sido traido de internet.  Un usuario puede llegar a scrollear muy rapido, 
  /// y terminar trayendo multiples paginas (cada pagina solo contiene 20 promociones) de internet
  ///
  void _handleIndexes(List<int> indexes){
    // Iterar todos los indices requeridos
    indexes.forEach((int index){
      final int pageIndex = 1 + ((index+1) ~/ _promocionesPorPagina);

      // Chequear si la pagina ya ha sido traida
      if (!_fetchPages.containsKey(pageIndex)){
        // La pagina NO ha sido traida asi que necesitamos
        // traerla de Internet
        // (excepto que la estemos trayendo justo ahota)
        if (!_pagesBeingFetched.contains(pageIndex)){
          // registrar la pagia
          _pagesBeingFetched.add(pageIndex);
          // Traerla
          api.pagedPromocionList(pageIndex: pageIndex)
              .then((PromocionPageResult fetchedPage) => _handleFetchedPage(fetchedPage, pageIndex));
        }
      }
    });
  }

  ///
  /// Una vez que se trajo la pagina de Internet, necesitamos
  /// 1) registrarla
  /// 2) notificar a todos los interesados
  /// 
  void _handleFetchedPage(PromocionPageResult page, int pageIndex){
    // Registrar la pagina
    _fetchPages[pageIndex] = page;
    // Sacarla de el stream de las que estan siendo traidas
    _pagesBeingFetched.remove(pageIndex);
   
    // Notificar a todos los interesados en tener acceso 
    // a las paginas... pero necesitamos traer solo las paginas
    // que respetan la secuencia (debido a que PromocionCard esta en secuencia)
    // por lo tanto, necesitamos iterar las paginas que estan siendo traidas
    // y detener si hay un hueco o una inconsistencia.
    List<PromocionCard> promociones = <PromocionCard>[];
    List<int> pageIndexes = _fetchPages.keys.toList();
    pageIndexes.sort((a, b) => a.compareTo(b));

    final int minPageIndex = pageIndexes[0];
    final int maxPageIndex = pageIndexes[pageIndexes.length - 1];

    // Si la primer pagina siendo traida no corresponde con la primer pagina, saltearla
    // apenas se haya traido habra que notificar
    if (minPageIndex == 1){
      for (int i = 1; i <= maxPageIndex; i++){
        if (!_fetchPages.containsKey(i)){
          // si hay un hueco, parar
          break;
        }
        // Agregar el listado de promociones obtenidas de internet a la lista
        promociones.addAll(_fetchPages[i].promociones);
      }
    }

    // Tomamos la oportunidad de grabar el numero de promociones
    // y notificar si hay algun interesado en saberlo
    if (_totalPromociones == -1){
      _totalPromociones = page.totalResults;
      _inTotalPromociones.add(_totalPromociones);
    }

    // Notificar solo cuando hay promociones
    if (promociones.length > 0){
      _inPromocionesList.add(UnmodifiableListView<PromocionCard>(promociones));
    }
  }
}
