import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repository/user_repository.dart';

class GetStatusUseCase {
  final AbstractUserRepository userRepository;

  GetStatusUseCase({
    required this.userRepository,
  });

  /// Get user status
  /// @parameters: String user UUID
  /// return Either<Failure, User>
  Future<Either<Failure, String>> execute({
    required String userUUID,
    required String accessToken,
  }) async {
    Map<String, dynamic> queryParams = {};
    queryParams['fields'] = 'status';
    return await userRepository.getStatus(
      userUUID: userUUID,
      accessToken: accessToken,
    );
  }
}
