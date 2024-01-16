import 'package:anti_social_network/networking/failure.dart';
import 'package:dartz/dartz.dart';
import '../repository/user_repository.dart';

class RegisterUseCase {
  final AbstractUserRepository userRepository;

  RegisterUseCase({
    required this.userRepository,
  });

  Future<Either<Failure, bool>> execute({
    required String firstname,
    required String password,
    required String email,
    required String asnID,
    required String lastname,
    required String phone,
    required String confirmPassword,
    required String deviceID

  }) async {
    Map<String,dynamic> payload = {};
    payload['firstname'] = firstname;
    payload['lastname'] = lastname;
    payload['email'] = email;
    payload['password'] = password;
    payload['username'] = asnID;
    payload['phone'] = phone;
    payload['confirmPassword'] = confirmPassword;
    payload['deviceID'] = deviceID;
    return await userRepository.register(
      payload: payload
    );
  }
}
