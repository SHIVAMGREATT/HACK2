import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vendors_app/mainScreens/api.dart';
import 'package:vendors_app/mainScreens/vegetable.dart';

class VegetableService {
  final ApiClient _apiClient = ApiClient();
  Future<List<Vegetable>> getSingers() async {
    try {
      String url =
          "https://github.com/Nikthakur09/serverData/blob/main/vegetables.json";

      Response response = await _apiClient.get(url);
      print(response.data);
      // Convert String (JSON) to Object
      dynamic object = jsonDecode(response.data);
      //print(respose.data);
      //print(object.runtimeType);
      //print("****************");
      //print(response.data.runtimeType);
      List<dynamic> list = object['singers'];
      List<Vegetable> singer = list.map((m) => Vegetable.fromJSON(m)).toList();
      //print("Singers $singer");
      return singer;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
