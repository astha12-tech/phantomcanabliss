import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phantomscanbliss/bloc/best_selling_bloc.dart';
import 'package:phantomscanbliss/bloc/category_bloc.dart';
import 'package:phantomscanbliss/bloc/products_bloc.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/best_selling_model.dart'
    as bestsellingmodel;
import 'package:phantomscanbliss/model/category_model.dart' as categorymodel;
import 'package:phantomscanbliss/model/products_model.dart' as productmodel;

import 'package:phantomscanbliss/screens/product_detail_screen.dart';
import 'package:phantomscanbliss/screens/product_screen.dart';
import 'package:phantomscanbliss/text_component/text14.dart';
import 'package:phantomscanbliss/urils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List gridImages = [
    "assets/png/product.png",
    "assets/png/product2.png",
    "assets/png/product3.png",
    "assets/png/product4.png",
    "assets/png/product.png",
    "assets/png/product2.png",
    "assets/png/product3.png",
    "assets/png/product4.png",
  ];
  List carouselsliderImages = [
    "assets/png/GUMMIES_2.jpg",
    "assets/png/Phantom-Pen-cbd_1.1.jpg",
    "assets/png/Phantoms-THCA-Flower.jpg",
  ];
  List bannerImages = [
    "assets/png/Banner_1.jpg",
    "assets/png/Banner_2.jpg",
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HOME"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            CarouselSlider(
              options: CarouselOptions(
                // height: 180,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },

                initialPage: 0,
                enlargeCenterPage: true,
                autoPlay: true,
                reverse: false,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
              ),
              items: carouselsliderImages.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              opacity: 0.4,
                              image: AssetImage("assets/png/app_icon.png")),
                          // color: colors.themebluecolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            i,
                            fit: BoxFit.fill,
                          )),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselsliderImages.map((i) {
                int index = carouselsliderImages.indexOf(i);

                return Container(
                  width: 7,
                  height: 7,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? colors.browncolor
                          : colors.whitecolor,
                      border: Border.all(
                          color: currentIndex == index
                              ? Colors.transparent
                              : colors.blackcolor)),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            StreamBuilder<List<categorymodel.CategoryModel>>(
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
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < snapshot.data!.length; i++)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                              categoryID: snapshot.data![i].id,
                                              title: snapshot.data![i].name!,
                                            )));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border:
                                        Border.all(color: colors.browncolor)),
                                child: Text(snapshot.data![i].name!),
                              ),
                            )
                        ],
                      ),
                    );
                  } else {
                    categoryBloc.categoryBloc(pl);
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Latest Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<List<productmodel.ProductsModel>>(
                stream: productsBloc.productStream,
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
                                  await productsBloc
                                      .productBloc(pl, "")
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
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.69),
                      itemBuilder: (context, index) {
                        return GestureDetector(
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
                                  snapshot.data![index].price == ""
                                      ? Container()
                                      : Text(
                                        "\$${snapshot.data![index].price}",
                                        style: const TextStyle(
                                            color: Colors.redAccent),
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
                    productsBloc.productBloc(pl, "");
                    return const Center(child: CircularProgressIndicator());
                  }
                }),

            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index; // Update the currentIndex
                  });
                },

                initialPage: 0,
                viewportFraction: 1,
                // enlargeCenterPage: true,
                autoPlay: true,
                // reverse: false,
                // enableInfiniteScroll: true,
                // autoPlayInterval: const Duration(seconds: 2),
                scrollDirection: Axis.horizontal,
              ),
              items: bannerImages.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            opacity: 0.4,
                            image: AssetImage("assets/png/app_icon.png")),
                        // color: colors.themebluecolor,
                      ),
                      child: Image.asset(
                        i,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       for (int i = 0; i < 2; i++)
            //         Image.asset(
            //           "assets/png/Banner_1.jpg",
            //         )
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Best Selling Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<List<bestsellingmodel.BestSellingModel>>(
                stream: bestSellingProductsBloc.bestSellingproductStream,
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
                                  await bestSellingProductsBloc
                                      .bestSellingproductBloc(pl)
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
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.69),
                      itemBuilder: (context, index) {
                        return GestureDetector(
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
                                snapshot.data![index].price == ""
                                    ? Container()
                                    : Text(
                                        "\$${snapshot.data![index].price}",
                                        style: const TextStyle(
                                            color: Colors.redAccent),
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
                    bestSellingProductsBloc.bestSellingproductBloc(pl);
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
