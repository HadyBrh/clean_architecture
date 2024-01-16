
import 'package:anti_social_network/features/login/domain/repository/user_repository.dart';
import 'package:anti_social_network/networking/failure.dart';
import 'package:dartz/dartz.dart';

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
    required String confirmPassword
  }) async {
    Map<String, dynamic> payload = {};
    payload['oldPassword'] = oldPassword;
    payload['newPassword'] = newPassword;
    payload['confirmPassword'] = confirmPassword;
    return await userRepository.changePassword(
      payload: payload,
    );
  }
}
