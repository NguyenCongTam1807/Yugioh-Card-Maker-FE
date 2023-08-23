import 'package:dio/dio.dart';

class DioFactory {

  const DioFactory();

  Dio getDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout:  const Duration(seconds: 10),
        sendTimeout:  const Duration(seconds: 10),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      )
    );

    return dio;
  }
}