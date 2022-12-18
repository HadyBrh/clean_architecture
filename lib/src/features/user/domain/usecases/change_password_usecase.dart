import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repository/user_repository.dart';

class ChangePasswordUseCase {
  final AbstractUserRepository userRepository;

  ChangePasswordUseCase({
    required this.userRepository,
  });

  /// Change user password
  /// @parameters: String oldPassword
  /// @parameters: String newPassword
  /// return Either<Failure, bool>
  Future<Either<Failure, bool>> execute({
    required String oldPassword,
    required String newPassword,
  }) async {
    Map<String, dynamic> payload = {};
    payload['old_password'] = oldPassword;
    payload['new_password'] = newPassword;
    return await userRepository.changePassword(
      payload: payload,
    );
  }
}
