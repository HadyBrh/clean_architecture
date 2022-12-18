import 'package:clean_architecture/src/networking/network_errors.dart';

class Failure {
  final NetworkError? error;

  const Failure({
    required this.error,
  });
}
