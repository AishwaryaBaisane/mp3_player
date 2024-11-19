import 'dart:convert';

import 'package:get/get.dart';
import 'package:mx_player/Modal_class/modal_class.dart';
import 'package:mx_player/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetController extends GetxController {
  RxList<Result> likeList = <Result>[].obs;

  GetController() {
    getList();
  }

  void theme() {
    if (theme1.value) {
      theme1.value = false;
    } else {
      theme1.value = true;
    }
  }

  Future<void> likeData1(Result result) async {
    likeList.add(result);
    List<String> stringList = likeList.map((item) => item.toString()).toList();
    final SharedPreferences ref = await SharedPreferences.getInstance();
    ref.setStringList('like', stringList);
  }

  Future<void> getList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? storedList = sharedPreferences.getStringList('like');

    if (storedList != null) {
      // Deserialize each JSON string back to a Result object
      likeList.value =
          storedList.map((item) => Result.fromJson(jsonDecode(item))).toList();
    } else {
      likeList.value = [];
    }
    // likeList.value = sharedPreferences.getStringList('like')!;
  }

  Future<void> deleteData(int index) async {
    if (index >= 0 && index < likeList.length) {
      likeList.removeAt(index);

      // Update SharedPreferences after removing the item
      List<String> stringList =
          likeList.map((item) => jsonEncode(item.toJson())).toList();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setStringList('like', stringList);
    }
  }
}

RxBool theme1 = true.obs;
