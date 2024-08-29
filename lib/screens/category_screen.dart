import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:phantomscanbliss/bloc/category_bloc.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/category_model.dart' as categorymodel;
import 'package:phantomscanbliss/text_component/text14.dart';
import 'package:phantomscanbliss/urils/colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("C a t e g o r y"),
        ),
        body: StreamBuilder<List<categorymodel.CategoryModel>>(
            stream: categoryBloc.categoryStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    text14new(snapshot.error,
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () async {
                              await pl.show();
                              await categoryBloc
                                  .categoryBloc(pl)
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < snapshot.data!.length; i++)
                        Container(
                            height: 200,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: colors.whitecolor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              alignment: Alignment.center,
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: snapshot.data![i].image == null
                                      ? Image.asset(
                                          "assets/png/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg",
                                          fit: BoxFit.fill,
                                          opacity:
                                              const AlwaysStoppedAnimation(0.4),
                                        )
                                      : Opacity(
                                          opacity: 0.2,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                const Center(
                                              child:
                                                  CupertinoActivityIndicator(),
                                            ),
                                            imageUrl:
                                                snapshot.data![i].image!.src!,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                ),
                                Center(
                                    child: Text(
                                  snapshot.data![i].name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: colors.browncolor),
                                ))
                              ],
                            ))
                    ],
                  ),
                );
              } else {
                categoryBloc.categoryBloc(pl);
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
