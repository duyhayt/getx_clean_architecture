import 'package:dio/dio.dart';

import '../../../app/core/utils/domain.dart';
import '../../../app/exceptions/server_exception.dart';

abstract class HttpClient {
  Future get(String url,
      {Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        bool authorization = false,
        ResponseType? responseType});

  Future post(String url, {Map headers, required dynamic body, bool authorization = false, ResponseType? responseType});

  Future put(String url, {Map? headers, required dynamic body, bool authorization = false, ResponseType? responseType});
}

class HttpClientImpl implements HttpClient {
  late Dio _dio;

  HttpClientImpl() {
    _initApiClient();
  }

  _initApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: Domain.getBaseUrl(),
      receiveTimeout: const Duration(milliseconds: 90000),
      connectTimeout: const Duration(milliseconds: 90000),
      responseType: ResponseType.json,
    ));
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (option, handler) {
        return handler.next(option);
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (e, handler) {
        return handler.next(e);
      }),
    );
  }

  @override
  Future get(String url,
      {Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        bool authorization = false,
        ResponseType? responseType}) async {
    _dio.options.baseUrl = '${Domain.enPoint}:${Domain.port}';
    try {
      if (authorization) {
        _dio.options.headers['authorization'] = 'my access when login successfully';
      }
      final response = await _dio.get(url,
          queryParameters: queryParameters,
          options: Options(headers: {..._dio.options.headers, ...?headers}, responseType: responseType));
      return response.data;
    } on DioError catch (e) {
      throwError(e);
    }
  }

  @override
  Future post(String url,
      {Map headers = const {}, required body, bool authorization = false, ResponseType? responseType}) async {
    _dio.options.baseUrl = '${Domain.enPoint}:${Domain.port}';
    try {
      if (authorization) {
        _dio.options.headers["authorization"] = "my access token when login successfully";
      }
      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: {..._dio.options.headers, ...headers}, responseType: responseType),
      );
      return response.data;
    } on DioError catch (e) {
      throwError(e);
    }
  }

  @override
  Future put(String url, {Map? headers, required body, bool authorization = false, ResponseType? responseType}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  throwError(DioError e) {
    if (e.response?.data != null) {
      throw ServerException(e.response?.data["message"]);
    }
    throw ServerException('Conect không thành công');
  }
}
