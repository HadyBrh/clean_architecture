
import 'dart:convert';

import 'package:anti_social_network/features/login/data/model/sign_up_error_response.dart';
import 'package:anti_social_network/networking/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../common/utils.dart';
import '../../../../networking/request_type_enum.dart';
import '../../../../networking/api_path.dart';
import '../../../../networking/dio_client.dart';
import '../../../../networking/network_errors.dart';
import '../../domain/repository/user_repository.dart';
import '../model/user.dart';

class UserRepository implements AbstractUserRepository {
  DioClient? dioClient;
  Dio dio = Dio();

  @override
  Future<Either<Failure, User>> login({
    required Map<String, dynamic> payload,
  }) async {
    try {
      // Create a Dio instance with custom options
      Dio dio = Dio();
      dio.options = BaseOptions(
        baseUrl: APIEndPoints.asnUrl,
        receiveTimeout: 10000, // Set the timeout to 10 seconds (in milliseconds)
      );
      dio.options.headers['X-DEVICE-ID'] = payload['deviceId'];

      // Create a FormData object
      FormData formData = FormData();
      // Add fields to the FormData object
      payload.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      final response = await dio.post(APIEndPoints.login, data: formData);

      String? token = response.headers.value('X-AUTH-TOKEN');
      Utils.saveUserToken(token!);
      User user = User.fromJson(response.data);
      return Right(user);
    } catch (e) {
      return Left(
        Failure(
          error: NetworkError().getException(e),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword({
      required Map<String, dynamic> payload,
  }) async {
    try {
      dioClient = DioClient(
        requestType: RequestType.PUT,
        baseURL: APIEndPoints.asnUrl,
        addToken: true,
      );

      await dioClient!
          .sendRequest("/accounts/users/change-password/", data: payload);
      return const Right(true);
    } catch (e) {
      return Left(
        Failure(
          error: NetworkError().getException(e),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> forgotPassword({
    required Map<String, dynamic> payload,
  }) async {
    try {
      dioClient = DioClient(
        requestType: RequestType.POST,
        baseURL: APIEndPoints.asnUrl,
        addToken: false,
      );

      await dioClient!
          .sendRequest("/user/forgot-password", data: payload);
      return const Right(true);
    } catch (e) {
      return Left(
        Failure(
          error: NetworkError().getException(e),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> register({
    required Map<String, dynamic> payload,
  }) async {
    try {
      // Create a FormData object
      FormData formData = FormData();
      // Add fields to the FormData object
      payload.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
      final response = await Dio().post("${APIEndPoints.asnUrl}${APIEndPoints.register}", data: formData);

      return response.statusCode == 200
          ? const Right(true)
          : Left(Failure(error: UnauthorizedException()));

    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400) {
          Map<String, dynamic> json = e.response!.data as Map<String, dynamic>; // Assuming response.data is already a Map
          SignUpErrorResponse errorResponse = SignUpErrorResponse.fromJson(json);

          return Left(Failure(error: UnauthorizedException(), responseError: errorResponse));
        } else {
          // Handle other DioError exceptions or throw a custom exception
          return Left(
            Failure(
              error: NetworkError().getException(e),
            ),
          );
        }
      } else {
        // Handle other exceptions or throw a custom exception
        return Left(
          Failure(
            error: NetworkError().getException(e),
          ),
        );
      }
    }
  }

}
