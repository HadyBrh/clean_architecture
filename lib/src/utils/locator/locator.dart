import 'package:clean_architecture/core_flutter_package.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  /// Services
  locator.registerLazySingleton(() => UserService());

}
