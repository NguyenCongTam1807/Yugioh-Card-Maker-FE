import 'package:dio/dio.dart';

class DioFactory {

  const DioFactory();

  Dio getDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout:  const Duration(seconds: 8),
        sendTimeout:  const Duration(seconds: 8),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      )
    );

    return dio;
  }
}