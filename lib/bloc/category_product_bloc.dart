import 'dart:async';

import 'package:phantomscanbliss/api/api.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/category_product_model.dart';

class CategoryProductsBloc {
  StreamController<List<CategoryProductsModel>> productstreamController =
      StreamController.broadcast();
  Stream<List<CategoryProductsModel>> get productStream =>
      productstreamController.stream;
  List<CategoryProductsModel>? productsModel;
  productBloc(ProgressLoader pl, categoryID) async {
    productsModel = await api.categoryproductListApi(pl, categoryID);
    productstreamController.sink.add(productsModel!);
  }
}

CategoryProductsBloc categoryProductsBloc = CategoryProductsBloc();
