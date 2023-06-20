import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStore {
  LocalStore._();

  static setLikeList(int productId) async {
    SharedPreferences _local = await SharedPreferences.getInstance();
    List<String> list = [];
    list = _local.getStringList("likes") ?? [];
    list.add(productId.toString());
    _local.setStringList("likes", list);
  }

  static removeLikeList(int productId) async {
    SharedPreferences _local = await SharedPreferences.getInstance();
    List<String> list = [];
    list = _local.getStringList("likes") ?? [];
    list.removeWhere((element) => element == productId.toString());
    _local.setStringList("likes", list);
  }

  static Future<List<String>> getLikeList() async {
    SharedPreferences _local = await SharedPreferences.getInstance();
    return _local.getStringList("likes") ?? [];
  }
}