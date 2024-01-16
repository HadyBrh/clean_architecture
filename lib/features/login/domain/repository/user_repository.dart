import 'package:anti_social_network/features/login/data/model/user.dart';
import 'package:anti_social_network/networking/failure.dart';
import 'package:dartz/dartz.dart';


abstract class AbstractUserRepository {
  Future<Either<Failure, User>> login({
    required Map<String, dynamic> payload,
  });

  Future<Either<Failure, bool>> register({
    required Map<String, dynamic> payload,

  });

  Future<Either<Failure, bool>> changePassword({
    required Map<String, dynamic> payload,
  });

  Future<Either<Failure, bool>> forgotPassword({
    required Map<String, dynamic> payload,
  });
}
