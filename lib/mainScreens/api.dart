import 'package:dio/dio.dart';

class ApiClient {
  Dio dio = Dio();
  get(url) {
    return dio.get(url);
  }

  post(url, data) {
    return dio.post(url, data: data);
  }

  put() {}
  delete() {}
}
