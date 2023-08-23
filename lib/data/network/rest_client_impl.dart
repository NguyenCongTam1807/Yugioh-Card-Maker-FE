import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yugioh_card_creator/data/network/rest_client.dart';
import 'package:yugioh_card_creator/data/network/yugioh_api.dart';

import '../models/uploaded_yugioh_card.dart';
import '../models/yugioh_card.dart';

class RestClientImpl extends RestClient {
  final Dio _dio;
  String? baseUrl;

  RestClientImpl(
      this._dio, {
        required this.baseUrl,
      }) {
    baseUrl ??= YugiohApi.baseUrl;
  }

  @override
  Future<List<UploadedYugiohCard>> fetchGallery() async {
    //const _extra = <String, dynamic>{};
    //final queryParameters = <String, dynamic>{};
    // final _headers = <String, dynamic>{};
    // final Map<String, dynamic>? _data = null;
    final result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<UploadedYugiohCard>>(Options(
      method: 'GET',
      //headers: _headers,
      //extra: _extra,
    )
        .compose(
      _dio.options,
      '/cards',
      //queryParameters: queryParameters,
      //data: _data,
    )
        .copyWith(
        baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    var value = result.data!
        .map((dynamic i) =>
        UploadedYugiohCard.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<int> uploadCard(YugiohCard yugiohCard) async {
    try {
      final response = await _dio.post('$baseUrl/cards', data: jsonEncode(yugiohCard));
      final value = response.statusCode!;
      return value;
    } catch (_) {
      rethrow;
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
      String dioBaseUrl,
      String? baseUrl,
      ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}