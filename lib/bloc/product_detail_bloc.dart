import 'dart:async';

import 'package:phantomscanbliss/api/api.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/product_detail_model.dart';

class ProductDetailBloc {
  StreamController<ProductDetailModel> productdetailstreamController =
      StreamController.broadcast();
  Stream<ProductDetailModel> get productStream =>
      productdetailstreamController.stream;
  ProductDetailModel? productsDetailModel;
  productDetailBloc(ProgressLoader pl, productID) async {
    productsDetailModel = await api.productDetailApi(pl, productID);
    productdetailstreamController.sink.add(productsDetailModel!);
  }
}

ProductDetailBloc productDetailBloc = ProductDetailBloc();
