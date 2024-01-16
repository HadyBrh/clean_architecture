import 'package:anti_social_network/features/login/data/model/sign_up_error_response.dart';

abstract class SignUpStates{}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {}

class SignUpErrorState extends SignUpStates {
  final SignUpErrorResponse? responseError;
  final String error;
  SignUpErrorState(this.error,this.responseError);
}