import 'package:anti_social_network/networking/failure.dart';
import 'package:dartz/dartz.dart';

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
    required String email,
    required String password,
    required String deviceID,
  }) async {
    Map<String,dynamic> payload = {};
    payload['email'] = email;
    payload['password'] = password;
    payload['deviceId'] = deviceID;
    return await userRepository.login(
      payload: payload
    );
  }
}
