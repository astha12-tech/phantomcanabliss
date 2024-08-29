import 'dart:async';

import 'package:phantomscanbliss/api/api.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/best_selling_model.dart';

class BestSellingProductsBloc {
  StreamController<List<BestSellingModel>> bestSellingproductstreamController =
      StreamController.broadcast();
  Stream<List<BestSellingModel>> get bestSellingproductStream =>
      bestSellingproductstreamController.stream;
  List<BestSellingModel>? bestsellingmodel;
  bestSellingproductBloc(ProgressLoader pl) async {
    bestsellingmodel = await api.bestsellingProductsListApi(pl);
    bestSellingproductstreamController.sink.add(bestsellingmodel!);
  }
}

BestSellingProductsBloc bestSellingProductsBloc = BestSellingProductsBloc();
