
import 'package:dio/dio.dart';

import 'failure.dart';

enum DataSourceStatus {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  connectionError,
  unknown,
}

extension StatusHandler on DataSourceStatus {
  Failure getFailure() {
    switch (this) {
      case DataSourceStatus.connectionTimeout:
      case DataSourceStatus.sendTimeout:
      case DataSourceStatus.receiveTimeout:
        return const Failure(ResponseMessage.connectTimeout);
      case DataSourceStatus.cancel:
        return const Failure(ResponseMessage.cancel);
      case DataSourceStatus.connectionError:
        return const Failure(ResponseMessage.noInternetConnection);
      default:
        return const Failure(ResponseMessage.others);
    }
  }
}

extension ExceptionHandler on Exception {
  Failure getFailure() {
    if (this is DioException) {
      switch ((this as DioException).type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const Failure(ResponseMessage.connectTimeout);
        case DioExceptionType.cancel:
          return const Failure(ResponseMessage.cancel);
        case DioExceptionType.connectionError:
          return const Failure(ResponseMessage.noInternetConnection);
        default:
          return const Failure(ResponseMessage.others);
      }
    } else {
      return const Failure(ResponseMessage.others);
    }
  }
}

class ResponseMessage {
  //User-friendly messages
  static const String noInternetConnection = "No internet connection found";
  static const String connectTimeout = "The operation takes too long";
  static const String cancel = "Request was cancelled";
  static const String others =
      "There's something wrong, the operation cannot be completed";
}
