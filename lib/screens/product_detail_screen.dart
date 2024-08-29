import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phantomscanbliss/bloc/product_detail_bloc.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/product_detail_model.dart'
    as productdetailmodel;
import 'package:phantomscanbliss/text_component/fontweight.dart';
import 'package:phantomscanbliss/text_component/text.dart';
import 'package:phantomscanbliss/text_component/text14.dart';
import 'package:phantomscanbliss/urils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailScreen extends StatefulWidget {
  var productID;
  var data;
  ProductDetailScreen({super.key, required this.productID, required this.data});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
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
  int currentIndex = 0;
  int selectedImageIndex = 0;
  CarouselSliderController pageController = CarouselSliderController();
  ScrollController scrollController = ScrollController();
  int counter = 1;
  addqty() {
    setState(() {
      counter++;
    });
  }

  removeqty() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Product Detail"),
      ),
      body: StreamBuilder<productdetailmodel.ProductDetailModel>(
          stream: productDetailBloc.productStream,
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
                            await productDetailBloc
                                .productDetailBloc(pl, widget.productID)
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CarouselSlider(
                        carouselController: pageController,
                        options: CarouselOptions(
                          // height: 350,

                          onPageChanged: (index, reason) {
                            setState(() {
                              selectedImageIndex = index;
                            });
                          },

                          initialPage: 0, viewportFraction: 1,
                          // enlargeCenterPage: true,
                          // autoPlay: true,
                          // reverse: false,
                          // enableInfiniteScroll: true,
                          // autoPlayInterval: const Duration(seconds: 2),
                          scrollDirection: Axis.horizontal,
                        ),
                        items: snapshot.data!.images!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            colors.blackcolor.withOpacity(0.2)),
                                    image: const DecorationImage(
                                        opacity: 0.4,
                                        image: AssetImage(
                                            "assets/png/app_icon.png")),
                                    // color: colors.themebluecolor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                    imageUrl: i.src!,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < snapshot.data!.images!.length;
                                  i++)
                                GestureDetector(
                                  onTap: () {
                                    if (selectedImageIndex != i) {
                                      setState(() {
                                        selectedImageIndex = i;
                                      });
                                      pageController.animateToPage(
                                        i,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 11, left: 11),
                                      padding: const EdgeInsets.all(8),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: colors.whitecolor,
                                        border: Border.all(
                                          color: selectedImageIndex == i
                                              ? colors.browncolor
                                              : Colors.transparent,
                                        ),
                                      ),
                                      child: snapshot
                                              .data!.images![i].src!.isEmpty
                                          ? Image.asset(
                                              "assets/png/no_image.png",
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        const Center(
                                                  child:
                                                      CupertinoActivityIndicator(),
                                                ),
                                                fit: BoxFit.fill,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                imageUrl: snapshot
                                                    .data!.images![i].src!,
                                              ),
                                            )

                                      //  Image.network(data.images![i].urlStandard!),
                                      ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data!.name!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "By",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            " ${snapshot.data!.yoastHeadJson!.ogSiteName}",
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "\$2.99",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      snapshot.data!.stockStatus == "outofstock"
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colors.blackcolor.withOpacity(0.1)),
                              child: Center(
                                  child: text("Out of stock",
                                      fontWeight: fontWeight.bold)),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      snapshot.data!.stockStatus == "outofstock"
                          ? Container()
                          : Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: colors.blackcolor
                                              .withOpacity(0.1)),
                                      color: colors.whitecolor),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          removeqty();
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text('$counter'),
                                      IconButton(
                                        onPressed: () {
                                          addqty();
                                        },
                                        icon: const Icon(Icons.add),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                snapshot.data!.stockStatus == "outofstock"
                                    ? Container()
                                    : Container(
                                        height: 45,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        color: colors.browncolor,
                                        child: Center(
                                          child: Text(
                                            "Add to cart",
                                            style: TextStyle(
                                                color: colors.whitecolor),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                      snapshot.data!.stockStatus == "outofstock"
                          ? Container()
                          : const SizedBox(
                              height: 10,
                            ),
                      snapshot.data!.stockStatus == "outofstock"
                          ? Container()
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              color: Colors.redAccent,
                              child: Text(
                                "Buy Now",
                                style: TextStyle(color: colors.whitecolor),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: colors.blackcolor.withOpacity(0.1)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.favorite_border),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Add to wishlist",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Categories: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          for (int i = 0;
                              i < snapshot.data!.categories!.length;
                              i++)
                            Row(
                              children: [
                                Text(
                                  snapshot.data!.categories![i].name!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent),
                                ),
                                i == snapshot.data!.categories!.length - 1
                                    ? Container()
                                    : const Text(", ")
                              ],
                            ),
                        ],
                      ),
                      snapshot.data!.attributes!.isEmpty
                          ? Container()
                          : const SizedBox(
                              height: 30,
                            ),
                      snapshot.data!.attributes!.isEmpty
                          ? Container()
                          : const Text(
                              "Additional information",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),

                      // DataTable(
                      //   // datatable widget
                      //   rows: [
                      //     // row to set the values
                      //     DataRow(cells: [
                      //       DataCell(Text('ValCol1')),
                      //       DataCell(Text('ValCol2')),
                      //     ]),
                      //   ],
                      //   columns: [
                      //     // column to set the name
                      //     DataColumn(
                      //       label: Text('Col1'),
                      //     ),
                      //     DataColumn(
                      //       label: Text('Col2'),
                      //     ),
                      //   ],
                      // )
                      snapshot.data!.attributes!.isEmpty
                          ? Container()
                          : const SizedBox(
                              height: 15,
                            ),
                      snapshot.data!.attributes!.isEmpty
                          ? Container()
                          : Table(
                              border: TableBorder.all(
                                  color: colors.blackcolor.withOpacity(0.1)),
                              children: [
                                for (int i = 0;
                                    i < snapshot.data!.attributes!.length;
                                    i++)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot
                                            .data!.attributes![i].name!),
                                      ), // Replace with dynamic data if needed
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot
                                            .data!.attributes![i].options![0]),
                                      ), // Replace with dynamic data if needed
                                    ],
                                  ),
                              ],
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Related Products",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int index = 0;
                                index < widget.data.length;
                                index++)
                              widget.data[index].id == snapshot.data!.id
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                              productID: widget.data[index].id,
                                              data: widget.data,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 350,
                                          width: 170,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CachedNetworkImage(
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        const Center(
                                                  child:
                                                      CupertinoActivityIndicator(),
                                                ),
                                                imageUrl: widget.data[index]
                                                    .images![0].src!,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                widget.data![index].name![0]
                                                        .toUpperCase() +
                                                    widget.data![index].name!
                                                        .substring(1)
                                                        .toLowerCase(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              widget.data![index].price == ""
                                                  ? Container()
                                                  : Text(
                                                      "\$${widget.data![index].price}",
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  for (int i = 0; i < 5; i++)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Image.asset(
                                                        "assets/png/star.png",
                                                        height: 10,
                                                        width: 10,
                                                      ),
                                                    )
                                                ],
                                              ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              // Container(
                                              //   width: double.infinity,
                                              //   padding: const EdgeInsets.all(4),
                                              //   decoration: BoxDecoration(
                                              //       border: Border.all(
                                              //           color:
                                              //               colors.browncolor)),
                                              //   child: const Center(
                                              //       child:
                                              //           Text("SELECT OPTIONS")),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              productDetailBloc.productDetailBloc(pl, widget.productID);
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
