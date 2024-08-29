import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phantomscanbliss/api/urls.dart';
import 'package:phantomscanbliss/bloc/best_selling_bloc.dart';
import 'package:phantomscanbliss/bloc/category_bloc.dart';
import 'package:phantomscanbliss/bloc/category_product_bloc.dart';
import 'package:phantomscanbliss/bloc/products_bloc.dart';
import 'package:phantomscanbliss/check_internet/check_internet.dart';
import 'package:phantomscanbliss/global/global.dart';
import 'package:phantomscanbliss/indicator/indicator.dart';
import 'package:phantomscanbliss/model/best_selling_model.dart';
import 'package:phantomscanbliss/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:phantomscanbliss/model/category_product_model.dart';
import 'package:phantomscanbliss/model/get_customer_model.dart';
import 'package:phantomscanbliss/model/product_detail_model.dart';
import 'package:phantomscanbliss/model/products_model.dart';
import 'package:phantomscanbliss/screens/bottom_bar/bottom_navigationbar_screen.dart';
import 'package:phantomscanbliss/screens/login_screen.dart';
import 'package:phantomscanbliss/shared_prefs/shared_prefs.dart';
import 'package:phantomscanbliss/urils/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Api {
  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colors.blackcolor,
        textColor: colors.whitecolor,
        fontSize: 16.0);
  }

  Future<List<CategoryModel>?> categoryListApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${SpUtil.getString(SpConstUtil.baseurl)}${urls.productCategory}?consumer_key=${SpUtil.getString(SpConstUtil.consumerKey)}&consumer_secret=${SpUtil.getString(SpConstUtil.consumerSecret)}&per_page=20'));
        debugPrint("==== request =====> categoryBloc ====> $request");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== categoryBloc response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          return categoryModelFromJson(response.body);
        }
      } catch (e) {
        await pl.hide();

        categoryBloc.categorystreamController.sink.addError(commonData.error);
      }
    } else {
      await pl.hide();

      categoryBloc.categorystreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<List<ProductsModel>?> productListApi(
      ProgressLoader pl, categoryID) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${SpUtil.getString(SpConstUtil.baseurl)}${urls.products}?consumer_key=${SpUtil.getString(SpConstUtil.consumerKey)}&consumer_secret=${SpUtil.getString(SpConstUtil.consumerSecret)}&category=$categoryID&status=publish&per_page=6'));
        debugPrint("==== request =====> productListApi ====> $request");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== productListApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          return productsModelFromJson(response.body);
        }
      } catch (e) {
        await pl.hide();
        productsBloc.productstreamController.sink.addError(commonData.error);
      }
    } else {
      await pl.hide();
      productsBloc.productstreamController.sink.addError(commonData.noInternet);
    }
    return null;
  }

  Future<List<CategoryProductsModel>?> categoryproductListApi(
      ProgressLoader pl, categoryID) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${SpUtil.getString(SpConstUtil.baseurl)}${urls.products}?consumer_key=${SpUtil.getString(SpConstUtil.consumerKey)}&consumer_secret=${SpUtil.getString(SpConstUtil.consumerSecret)}&category=$categoryID&status=publish&catalog_visibility=visible'));
        debugPrint("==== request =====> categoryproductListApi ====> $request");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== categoryproductListApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          return categoryproductsModelFromJson(response.body);
        }
      } catch (e) {
        await pl.hide();

        categoryProductsBloc.productstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      categoryProductsBloc.productstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<List<BestSellingModel>?> bestsellingProductsListApi(
      ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${SpUtil.getString(SpConstUtil.baseurl)}${urls.products}?consumer_key=${SpUtil.getString(SpConstUtil.consumerKey)}&consumer_secret=${SpUtil.getString(SpConstUtil.consumerSecret)}&orderby=popularity'));
        debugPrint(
            "==== request =====> bestsellingProductsListApi ====> $request");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== bestsellingProductsListApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          return bestsellingModelFromJson(response.body);
        }
      } catch (e) {
        await pl.hide();

        bestSellingProductsBloc.bestSellingproductstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      bestSellingProductsBloc.bestSellingproductstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<ProductDetailModel?> productDetailApi(
      ProgressLoader pl, productID) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'POST',
            Uri.parse(
                '${SpUtil.getString(SpConstUtil.baseurl)}${urls.products}/$productID?consumer_key=${SpUtil.getString(SpConstUtil.consumerKey)}&consumer_secret=${SpUtil.getString(SpConstUtil.consumerSecret)}'));
        debugPrint(
            "==== productDetailApi =====> bestsellingProductsListApi ====> $request");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== productDetailApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          return productDetailModelFromJson(response.body);
        }
      } catch (e) {
        await pl.hide();

        bestSellingProductsBloc.bestSellingproductstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      bestSellingProductsBloc.bestSellingproductstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future loginApi(ProgressLoader pl, String userName, String password,
      BuildContext context) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'POST', Uri.parse('${urls.custombaseurl}${urls.login}'));
        debugPrint("==== loginApi =====> loginApi ====> $request");
        request.body =
            json.encode({"username": userName, "password": password});

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== loginApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          await SpUtil.putInt(
              SpConstUtil.userID, jsonDecode(response.body)['id']);
          await SpUtil.putString(
              SpConstUtil.userName, jsonDecode(response.body)['username']);
          await SpUtil.putString(
              SpConstUtil.userEmail, jsonDecode(response.body)['email']);
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const BottomNavigationbarScreen(),
            ),
          );
        }
      } catch (e) {
        await pl.hide();

        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future registerApi(
      ProgressLoader pl,
      String userName,
      String email,
      String password,
      String confirmpassword,
      String firstName,
      String lastName,
      BuildContext context) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'POST', Uri.parse('${urls.custombaseurl}${urls.register}'));
        debugPrint("==== loginApi =====> loginApi ====> $request");
        request.body = json.encode({
          "username": userName,
          "email": email,
          "password": password,
          "confirm_password": confirmpassword,
          "firstname": firstName,
          "lastname": lastName
        });

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== registerApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          await showToast("Register successfully now you please login...");
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      } catch (e) {
        await pl.hide();

        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future<GetCustomerModel?> getCustomerApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${SpUtil.getString(SpConstUtil.baseurl)}${urls.customers}/${SpUtil.getInt(SpConstUtil.userID)}?consumer_key=${SpUtil.getString(SpConstUtil.consumerKey)}&consumer_secret=${SpUtil.getString(SpConstUtil.consumerSecret)}&orderby=popularity'));
        debugPrint("==== request =====> getCustomerApi ====> $request");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== getCustomerApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          return getCustomerModelFromJson(response.body);
        }
      } catch (e) {
        await pl.hide();

        bestSellingProductsBloc.bestSellingproductstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      bestSellingProductsBloc.bestSellingproductstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future updateCustomerApi(ProgressLoader pl, String firstName, String lastName,
      String email) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'PUT',
            Uri.parse(
                '${SpUtil.getString(SpConstUtil.baseurl)}${urls.customers}/${SpUtil.getInt(SpConstUtil.userID)}?consumer_key=${SpUtil.getString(SpConstUtil.consumerKey)}&consumer_secret=${SpUtil.getString(SpConstUtil.consumerSecret)}&orderby=popularity'));
        debugPrint("==== request =====> updateCustomerApi ====> $request");
        request.body = json.encode(
            {"first_name": firstName, "last_name": lastName, "email": email});

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== updateCustomerApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          showToast("Update successfully");
        }
      } catch (e) {
        await pl.hide();

        showToast(commonData.error);
      }
    } else {
      await pl.hide();

      showToast(commonData.noInternet);
    }
    return null;
  }
}

Api api = Api();
