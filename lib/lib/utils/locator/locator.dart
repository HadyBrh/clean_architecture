import 'package:anti_social_network/features/login/views/sign_in/login_cubit.dart';
import 'package:anti_social_network/services/user_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// App Config & Shared Preferences
  // locator.registerLazySingleton(() => SharedPrefs());

  /// Services
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => LoginCubit());
}
