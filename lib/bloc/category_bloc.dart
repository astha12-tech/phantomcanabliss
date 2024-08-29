import 'dart:async';

import 'package:phantomscanbliss/api/api.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/category_model.dart';

class CategoryBloc {
  StreamController<List<CategoryModel>> categorystreamController =
      StreamController.broadcast();
  Stream<List<CategoryModel>> get categoryStream => categorystreamController.stream;
  List<CategoryModel>? categoryModel;
  categoryBloc(ProgressLoader pl) async {
    categoryModel = await api.categoryListApi(pl);
    categorystreamController.sink.add(categoryModel!);
  }
}

CategoryBloc categoryBloc = CategoryBloc();
