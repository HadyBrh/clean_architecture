import 'package:anti_social_network/common/index.dart';
import 'package:anti_social_network/features/login/data/repository/user_repository.dart';
import 'package:anti_social_network/features/login/domain/usecases/login.dart';
import 'package:anti_social_network/features/login/views/sign_in/login_states.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit(): super(LoginInitialState());

  Future<void> login(String email,String password) async{
    // if (!formKey!.currentState!.validate()) {
    //   return;
    // }
    emit(LoginLoadingState());
    String? deviceId = await Utils.getDeviceDetails();
    var loginResponse =
    await LoginUseCase(userRepository: UserRepository()).execute(
      email: email,
      password: password,
      deviceID: deviceId ?? ""
    );

    loginResponse.fold(
          (failure) => emit(LoginErrorState(failure.error.toString())),
          (user) async {
            Utils.saveUserDetails(user);
            emit(LoginSuccessState());
      },
    );
  }
}
