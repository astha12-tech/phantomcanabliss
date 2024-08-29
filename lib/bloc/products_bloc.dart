import 'dart:async';

import 'package:phantomscanbliss/api/api.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/products_model.dart';

class ProductsBloc {
  StreamController<List<ProductsModel>> productstreamController =
      StreamController.broadcast();
  Stream<List<ProductsModel>> get productStream =>
      productstreamController.stream;
  List<ProductsModel>? productsModel;
  productBloc(ProgressLoader pl, categoryID) async {
    productsModel = await api.productListApi(pl, categoryID);
    productstreamController.sink.add(productsModel!);
  }
}

ProductsBloc productsBloc = ProductsBloc();
