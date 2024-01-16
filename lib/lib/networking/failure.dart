import 'package:anti_social_network/features/login/data/model/sign_up_error_response.dart';
import 'package:anti_social_network/networking/network_errors.dart';

class Failure {
  final NetworkError? error;
  final SignUpErrorResponse? responseError;
  const Failure({
    required this.error,
    this.responseError
  });
}
