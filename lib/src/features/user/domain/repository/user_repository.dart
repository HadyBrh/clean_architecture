import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/model/user.dart';

abstract class AbstractUserRepository {
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, String>> getStatus({
    required String userUUID,
    required String accessToken,
  });

  Future<Either<Failure, bool>> changePassword({
    required Map<String, dynamic> payload,
  });

  Future<Either<Failure, bool>> forgotPassword({
    required Map<String, dynamic> payload,
  });
}
