import 'package:anti_social_network/common/constants.dart';
import 'package:anti_social_network/common/custom_colors.dart';
import 'package:anti_social_network/common/toast_helper.dart';
import 'package:anti_social_network/features/homepage/view/homepage_view.dart';
import 'package:anti_social_network/features/login/views/sign_in/login_cubit.dart';
import 'package:anti_social_network/features/login/views/sign_in/login_states.dart';
import 'package:anti_social_network/features/login/views/sign_up/sign_up_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState>? formKey;
  TextEditingController? usernameController;
  TextEditingController? passwordController;
  bool isLoading=false;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
        print('State of login is $state');
        if (state is LoginErrorState) {
          //Show Error
          ToastHelper.showErrorToast(context, state.error);
          isLoading = false;
        }
        if(state is LoginLoadingState){
          isLoading = true;
        }
        if (state is LoginSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      }, builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, Constants.getScreenHeight(context) * 0.2, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: const AssetImage(
                              "assets/icons/asn-logo-blue.png"),
                          width: Constants.getScreenWidth(context) * .5,
                          height: Constants.getScreenWidth(context) * .25,
                          fit: BoxFit.scaleDown,
                          alignment: FractionalOffset.center),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, Constants.getScreenHeight(context) * 0.1, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: const AssetImage(
                              "assets/icons/background.png"),
                          width: Constants.getScreenWidth(context),
                          height: Constants.getScreenHeight(context),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.center),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, Constants.getScreenHeight(context) * 0.5, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Sign In',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: CustomColors.darkBlue),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0, 4, 8),
                            child: Row(
                              children: [
                                Text(
                                  'We\'re Happy to see you back',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: CustomColors.grey),
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: usernameController,
                            maxLines: 1,
                            textInputAction: TextInputAction.next, // Set textInputAction to "next"
                            onEditingComplete: () => FocusScope.of(context).nextFocus(),
                            decoration: InputDecoration(
                              labelText: "ASN ID OR EMAIL",
                              isDense: true,

                              labelStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                borderSide: BorderSide(
                                    color: CustomColors.lightGrey,
                                    width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                borderSide: BorderSide(
                                  color: CustomColors.lightGrey,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            controller: passwordController,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Password",
                              isDense: true,
                              labelStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                borderSide: BorderSide(
                                    color: CustomColors.lightGrey,
                                    width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                borderSide: BorderSide(
                                  color: CustomColors.lightGrey,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                CustomColors.darkBlue),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    0.0),
                                          ),
                                        )),
                                    onPressed: () {
                                      BlocProvider.of<LoginCubit>(context)
                                          .login(
                                              usernameController!.text,
                                              passwordController!.text);
                                    },
                                    child: const Text(
                                      'Sign In',
                                      style:
                                          TextStyle(color: Colors.white),
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    0.0),
                                          ),
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpView()),
                                      );
                                    },
                                    child: Text(
                                      'New User? Sign Up',
                                      style: TextStyle(
                                          color: CustomColors.darkBlue),
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                // Controls visual overflow
                                overflow: TextOverflow.clip,

                                // Controls how the text should be aligned horizontally
                                textAlign: TextAlign.end,

                                // Control the text direction
                                textDirection: TextDirection.rtl,

                                // Whether the text should break at soft line breaks
                                softWrap: true,

                                // Maximum number of lines for the text to span
                                maxLines: 1,
                                text: TextSpan(
                                  text: 'Having Trouble Signing in? ',
                                  style: TextStyle(
                                      color: CustomColors.grey,
                                      fontSize: 12),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'click here',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.grey,
                                        fontSize: 12,
                                        decoration:
                                            TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Visibility(
                            visible: isLoading,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
