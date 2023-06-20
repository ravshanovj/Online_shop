import 'dart:convert';


import 'package:grow_fast_app/model/newProducts.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';

abstract class GetInfo {
  GetInfo._();

  static Future<List<ProductModel?>?> getProduct() async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products");
      final res = await http.get(url);
      return productModelFromJson(res.body);
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List> getCategory() async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/categories");
      final res = await http.get(url);
      return jsonDecode(res.body);
    } catch (e) {
      print(e);
    }
    return [];
  }


   static Future<ProductModel?> getSingleProduct(String productId) async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/$productId");
      final res = await http.get(url);
      return ProductModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      print(e);
    }
    return null;
  }



  static Future<List<ProductModel?>?> getCategoryONlyOne(
      {required String oneItem}) async {
    try {
      final url =
          Uri.parse("https://fakestoreapi.com/products/category/$oneItem");
      final res = await http.get(url);
      return productModelFromJson(res.body);
    } catch (e) {
      print('xattto');
    }
    return [];
  }


  static Future<ProductModel?> geIDProduct(int id) async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/$id");
      final res = await http.get(url);
      return ProductModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      print(e);
    }
    return null;
  }

}

abstract class GetInfoNew {
  GetInfoNew._();

  static Future<NoteModel?> getProductNew(int pageIndex) async {
    try {
      final url =
          Uri.parse("https://zohiddev.uz/v1/products?limit=4&page=$pageIndex");
      final res = await http.get(url);
      return noteModelFromJson(res.body);
    } catch (e) {
      print(e);
    }
    return null;
  }
}