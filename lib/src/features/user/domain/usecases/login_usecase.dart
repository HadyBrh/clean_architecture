import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/model/user.dart';
import '../repository/user_repository.dart';

class LoginUseCase {
  final AbstractUserRepository userRepository;

  LoginUseCase({
    required this.userRepository,
  });

  /// Login user
  /// @parameters: String username, String password
  /// return Either<Failure, User>
  Future<Either<Failure, User>> execute({
    required String username,
    required String password,
  }) async {
    return await userRepository.login(
      username: username,
      password: password,
    );
  }
}
