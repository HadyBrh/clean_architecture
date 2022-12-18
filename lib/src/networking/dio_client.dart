import 'package:dio/dio.dart';

import '../services/user_service.dart';
import '../utils/locator/locator.dart';
import 'logging_interceptor.dart';
import 'request_type_enum.dart';

const _defaultConnectTimeout = 10000;
const _defaultReceiveTimeout = 10000;

class DioClient {
  final RequestType requestType;
  Dio? dio;
  final bool addToken;
  final String baseURL;
  final UserService authentication = locator<UserService>();

  DioClient(
      {required this.requestType,
      this.addToken = true,
      required this.baseURL,
      connectTimeout = null,
      receiveTimeout = null}) {
    dio = Dio();
    dio!
      ..options.baseUrl = baseURL
      ..options.connectTimeout = connectTimeout ?? _defaultConnectTimeout
      ..options.receiveTimeout = receiveTimeout ?? _defaultReceiveTimeout
      ..options.headers["x-user-role"] = 'salesman'
      ..interceptors.add(Logging())
      ..httpClientAdapter;

    if (addToken && authentication.user?.accessToken != null) {
      dio!.options.headers['Authorization'] =
          'Bearer ${authentication.user!.accessToken}';
    }

    /* dio!.interceptors.add(
        QueuedInterceptorsWrapper(
          onRequest: (options, handler) async {
            String? accessToken = authentication.user?.accessToken;

            if (accessToken != null) {
              if (JwtDecoder.isExpired(accessToken)) {
                // Call the refresh endpoint to get a new token
                await UserService().refreshToken().then((response) async {
                  accessToken = authentication.user?.accessToken;
                }).catchError((error, stackTrace) {
                  handler.reject(error, true);
                });
              }
              options.headers['Authorization'] = 'Bearer $accessToken';
              handler.next(options);
            }
          },
          onError: (error, handler) async {
            throw error;
          },
        ),
      );*/
  }

  Future<dynamic> sendRequest(
    String uri, {
    dynamic data,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response;
      switch (requestType) {
        case RequestType.GET:
          response = await dio!.get(
            uri,
            options: options,
            queryParameters: queryParameters,
          );
          break;

        case RequestType.POST:
          response = await dio!.post(
            uri,
            data: data,
            options: options,
            queryParameters: queryParameters,
          );
          break;

        case RequestType.PUT:
          response = await dio!.put(
            uri,
            data: data,
            options: options,
          );
          break;

        case RequestType.PATCH:
          response = await dio!.patch(
            uri,
            data: data,
            options: options,
          );
          break;

        case RequestType.DELETE:
          response = await dio!.delete(
            uri,
            data: data,
            options: options,
          );
          break;
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
