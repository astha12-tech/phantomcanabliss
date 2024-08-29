import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phantomscanbliss/bloc/category_product_bloc.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/category_product_model.dart'
    as categoryproductmodel;
import 'package:phantomscanbliss/screens/product_detail_screen.dart';

import 'package:phantomscanbliss/text_component/text14.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductScreen extends StatefulWidget {
  var categoryID;
  String title;
  ProductScreen({super.key, required this.categoryID, required this.title});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<categoryproductmodel.CategoryProductsModel>>(
          stream: categoryProductsBloc.productStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  text14new(
                    snapshot.error,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () async {
                            await pl.show();
                            await categoryProductsBloc
                                .productBloc(pl, widget.categoryID)
                                .catchError((error) async {
                              if (pl.isShowing()) {
                                await pl.hide();
                              }
                            });
                            await pl.hide();
                          },
                          child: text14("Retry", FontWeight.bold)),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.69),
                itemBuilder: (context, index) {
                  return snapshot.data![index].catalogVisibility == "hidden"
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  productID: snapshot.data![index].id,
                                  data: snapshot.data,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                  imageUrl:
                                      snapshot.data![index].images![0].src!,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data![index].name![0].toUpperCase() +
                                      snapshot.data![index].name!
                                          .substring(1)
                                          .toLowerCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "\$${snapshot.data![index].price}",
                                  style:
                                      const TextStyle(color: Colors.redAccent),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Image.asset(
                                          "assets/png/star.png",
                                          height: 10,
                                          width: 10,
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                },
              );
            } else {
              categoryProductsBloc.productBloc(pl, widget.categoryID);
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
