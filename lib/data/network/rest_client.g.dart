// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'rest_client.dart';
//
// // **************************************************************************
// // RetrofitGenerator
// // **************************************************************************
//
// // ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers
//
// class _RestClient implements RestClient {
//   _RestClient(
//     this._dio, {
//     this.baseUrl,
//   }) {
//     baseUrl ??= 'http://10.0.2.2:8080/api/v1.0/';
//   }
//
//   final Dio _dio;
//
//   String? baseUrl;
//
//   @override
//   Future<List<UploadedYugiohCard>> fetchGallery() async {
//     const _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final Map<String, dynamic>? _data = null;
//     final _result = await _dio
//         .fetch<List<dynamic>>(_setStreamType<List<UploadedYugiohCard>>(Options(
//       method: 'GET',
//       headers: _headers,
//       extra: _extra,
//     )
//             .compose(
//               _dio.options,
//               '/cards',
//               queryParameters: queryParameters,
//               data: _data,
//             )
//             .copyWith(
//                 baseUrl: _combineBaseUrls(
//               _dio.options.baseUrl,
//               baseUrl,
//             ))));
//     var value = _result.data!
//         .map((dynamic i) =>
//             UploadedYugiohCard.fromJson(i as Map<String, dynamic>))
//         .toList();
//     return value;
//   }
//
//   @override
//   Future<int> uploadCard(YugiohCard yugiohCard) async {
//     const _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = {'yugioh_card': yugiohCard};
//     final _result = await _dio.fetch<int>(_setStreamType<int>(Options(
//       method: 'POST',
//       headers: _headers,
//       extra: _extra,
//     )
//         .compose(
//           _dio.options,
//           '/cards',
//           queryParameters: queryParameters,
//           data: _data,
//         )
//         .copyWith(
//             baseUrl: _combineBaseUrls(
//           _dio.options.baseUrl,
//           baseUrl,
//         ))));
//     final value = _result.statusCode!;
//     return value;
//   }
//
//   RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
//     if (T != dynamic &&
//         !(requestOptions.responseType == ResponseType.bytes ||
//             requestOptions.responseType == ResponseType.stream)) {
//       if (T == String) {
//         requestOptions.responseType = ResponseType.plain;
//       } else {
//         requestOptions.responseType = ResponseType.json;
//       }
//     }
//     return requestOptions;
//   }
//
//   String _combineBaseUrls(
//     String dioBaseUrl,
//     String? baseUrl,
//   ) {
//     if (baseUrl == null || baseUrl.trim().isEmpty) {
//       return dioBaseUrl;
//     }
//
//     final url = Uri.parse(baseUrl);
//
//     if (url.isAbsolute) {
//       return url.toString();
//     }
//
//     return Uri.parse(dioBaseUrl).resolveUri(url).toString();
//   }
// }
