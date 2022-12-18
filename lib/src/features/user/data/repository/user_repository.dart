import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../networking/request_type_enum.dart';
import '../../../../networking/dio_client.dart';
import '../../../../networking/network_errors.dart';
import '../../../../utils/constant/app.dart';
import '../../domain/repository/user_repository.dart';
import '../model/user.dart';

class UserRepository implements AbstractUserRepository {
  DioClient? dioClient;

  @override
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      dioClient = DioClient(
        requestType: RequestType.POST,
        baseURL: APIEndPoints.ssoBase,
        addToken: false,
      );
      dioClient!.dio!.options.headers["authorization"] = basicAuth;

      final payload = jsonEncode({
        "uri_redirect": "",
        "application_id": APIEndPoints.ssoApplicationID,
      });

      final response =
          await dioClient!.sendRequest("/sso/token/", data: payload);
      User user = User.fromJson(response);

      if (user.userData?.groups == null) {
        return Left(Failure(error: UnauthorizedException()));
      }

      bool allowed = false;
      user.userData?.groups?.forEach((element) {
        if (element.name == AppConstant.salesmanMobileAccess) {
          allowed = true;
        }
      });

      return allowed
          ? Right(user)
          : Left(Failure(error: UnauthorizedException()));
    } catch (e) {
      return Left(
        Failure(
          error: NetworkError().getException(e),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> getStatus({
    required String userUUID,
    required String accessToken,
  }) async {
    try {
      // Initialize Dio instance
      dioClient = DioClient(
        requestType: RequestType.GET,
        baseURL: APIEndPoints.echoSystemBase,
        addToken: false,
      );
      dioClient!.dio!.options.headers["authorization"] = 'Bearer $accessToken';
      var response = await dioClient!.sendRequest(
        "/user_management/v1/employees/$userUUID",
      );
      return Right(response['status']);
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
        baseURL: APIEndPoints.ssoBase,
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
        baseURL: APIEndPoints.ssoBase,
        addToken: false,
      );

      await dioClient!
          .sendRequest("/accounts/users/forgot-password/", data: payload);
      return const Right(true);
    } catch (e) {
      return Left(
        Failure(
          error: NetworkError().getException(e),
        ),
      );
    }
  }
}
