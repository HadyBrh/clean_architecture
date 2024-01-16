import 'package:anti_social_network/services/user_service.dart';
import 'package:anti_social_network/utils/locator/locator.dart';
import 'package:dio/dio.dart';
import 'logging_interceptor.dart';
import 'request_type_enum.dart';

const _defaultConnectTimeout = 10000;
const _defaultReceiveTimeout = 10000;

class DioClient {
  final RequestType requestType;
  Dio? dio;
  final bool addToken;
  final bool contentType;
  final String baseURL;
  final UserService authentication = locator<UserService>();

  DioClient(
      {required this.requestType,
      this.addToken = true,
      this.contentType = false,
      required this.baseURL,
      connectTimeout,
      receiveTimeout}) {
    dio = Dio();
    dio!
      ..options.baseUrl = baseURL
      ..options.connectTimeout = connectTimeout ?? _defaultConnectTimeout
      ..options.receiveTimeout = receiveTimeout ?? _defaultReceiveTimeout
      ..options.contentType = Headers.jsonContentType
      // ..options.headers["x-user-role"] = 'salesman'
      ..interceptors.add(Logging())
      ..httpClientAdapter;

    // if (addToken && authentication.user?.accessToken != null) {
    //   dio!.options.headers['Authorization'] =
    //       'Bearer ${authentication.user!.accessToken}';
    // }

    if(contentType){
      dio!.options.contentType = Headers.jsonContentType;
    }

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
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
