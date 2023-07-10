import 'package:dio/dio.dart';

class DioFactory {

  const DioFactory();

  Dio getDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout:  const Duration(seconds: 5),
        sendTimeout:  const Duration(seconds: 5),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      )
    );

    return dio;
  }
}