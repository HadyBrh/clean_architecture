import 'package:anti_social_network/features/login/data/repository/user_repository.dart';
import 'package:anti_social_network/features/login/views/sign_up/sign_up_states.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/register.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit(): super(SignUpInitialState());

  Future<void> signUp(String email,String firstName,String lastName, String asnId,String phone , String password, String confirmPassword) async{
    emit(SignUpLoadingState());
    String? deviceId = await getDeviceId();
    var signUpResponse =
        await RegisterUseCase(userRepository: UserRepository()).execute(
        deviceID: deviceId ?? "",email: email, firstname: firstName, password: password, asnID: asnId, phone: phone ,  lastname: lastName, confirmPassword: confirmPassword
    );

    signUpResponse.fold(
          (failure) => emit(SignUpErrorState(failure.error.toString(),failure.responseError)),
          (user) async {
        emit(SignUpSuccessState());
      },
    );
  }
  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;

    if (androidDeviceInfo != null) {
      return androidDeviceInfo.id;
    } else if (iosDeviceInfo != null) {
      return iosDeviceInfo.identifierForVendor;
    } else {
      return null;
    }
  }
}