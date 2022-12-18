import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repository/user_repository.dart';

class ForgotPasswordUseCase {
  final AbstractUserRepository userRepository;

  ForgotPasswordUseCase({
    required this.userRepository,
  });

  /// Reset user password
  /// @parameters: String email
  /// return Either<Failure, bool>
  Future<Either<Failure, bool>> execute({
    required String email,
  }) async {
    Map<String, dynamic> payload = {};
    payload['email'] = email;
    return await userRepository.forgotPassword(
      payload: payload,
    );
  }
}
