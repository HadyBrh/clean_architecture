import 'dart:async';

import 'package:anti_social_network/common/constants.dart';
import 'package:anti_social_network/common/custom_colors.dart';
import 'package:anti_social_network/common/top_bar.dart';
import 'package:anti_social_network/features/login/views/sign_in/login_view.dart';
import 'package:anti_social_network/features/login/views/sign_up/sign_up_cubit.dart';
import 'package:anti_social_network/features/login/views/sign_up/sign_up_states.dart';
import 'package:anti_social_network/utils/extensions/extstring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  final _personalInformationFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _asnIdController = TextEditingController();
  bool _showConfirmPassword =
      false; // Track the visibility of the confirm password field
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _passwordController.addListener(() {
      setState(() {
        _showConfirmPassword = _passwordController.text.isNotEmpty;
        if (_showConfirmPassword) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(),
      child:
          BlocConsumer<SignUpCubit, SignUpStates>(listener: (context, state) {
            print('state is $state');
        if (state is SignUpErrorState) {
          //Show Error
          print('error is ${state.responseError!.errors}');
        }

        if (state is SignUpSuccessState) {

        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: CustomColors.lightGrey,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    const TopBarWidget(barHeight: 120),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          8.0, Constants.getScreenHeight(context) * 0.06, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const SizedBox(
                              height: 18,
                              width: 18,
                              child: FittedBox(
                                child: ImageIcon(
                                  AssetImage('assets/icons/back-left.png'),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Login screen',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _returnPersonalInformationStep(context),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _returnPersonalInformationStep(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _personalInformationFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                        color: CustomColors.darkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'ASN id',
                      style:
                          TextStyle(color: CustomColors.darkBlue, fontSize: 12),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _asnIdController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLines: 1,
                validator: (val) {
                  if (!val!.isValidAsnId) {
                    return 'Enter valid asn id';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "ASN id",
                  isDense: true,
                  labelStyle: const TextStyle(
                    fontSize: 12,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide:
                        BorderSide(color: CustomColors.lightGrey, width: 2.0),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 5, 5, 0),
                    child: Text(
                      'ASN id can only contains letters and numbers',
                      style: TextStyle(color: CustomColors.grey, fontSize: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'First Name',
                      style:
                          TextStyle(color: CustomColors.darkBlue, fontSize: 12),
                    ),
                  ),
                ],
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                controller: _firstNameController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "FirstName",
                  isDense: true,
                  labelStyle: const TextStyle(
                    fontSize: 12,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide:
                        BorderSide(color: CustomColors.lightGrey, width: 2.0),
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Last Name',
                      style:
                          TextStyle(color: CustomColors.darkBlue, fontSize: 12),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _lastNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "LastName",
                  isDense: true,
                  labelStyle: const TextStyle(
                    fontSize: 12,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide:
                        BorderSide(color: CustomColors.lightGrey, width: 2.0),
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Email',
                      style:
                          TextStyle(color: CustomColors.darkBlue, fontSize: 12),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLines: 1,
                validator: (val) {
                  if (!val!.isValidEmail) {
                    return 'Enter valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  isDense: true,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide:
                        BorderSide(color: CustomColors.lightGrey, width: 2.0),
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Phone',
                      style:
                          TextStyle(color: CustomColors.darkBlue, fontSize: 12),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _phoneController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLines: 1,
                validator: (val) {
                  if (!val!.isValidPhone) {
                    return 'Enter valid phone';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Phone",
                  isDense: true,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide:
                        BorderSide(color: CustomColors.lightGrey, width: 2.0),
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Password',
                      style:
                          TextStyle(color: CustomColors.darkBlue, fontSize: 12),
                    ),
                  ),
                ],
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _passwordController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Password can\'t be empty';
                  }
                  return null;
                },
                onChanged: (_) {},
                keyboardType: TextInputType.text,
                maxLines: 1,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Password",
                  isDense: true,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide:
                        BorderSide(color: CustomColors.lightGrey, width: 2.0),
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
              const SizedBox(
                height: 10,
              ),
              AnimatedBuilder(
                animation: _fadeInAnimation,
                builder: (context, child) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _fadeInAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0.0, 10.0 * (1 - _fadeInAnimation.value)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  'Confirm Password',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _confirmPasswordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Empty';
                              }
                              if (val != _passwordController.text) {
                                return 'Passwords does not Match';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
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
                                    color: CustomColors.lightGrey, width: 2.0),
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
                        ],
                      ),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                CustomColors.darkBlue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                            )),
                        onPressed: () {
                          BlocProvider.of<SignUpCubit>(context).signUp(
                              _emailController.text,
                              _firstNameController.text,
                              _lastNameController.text,
                              _asnIdController.text,
                              _phoneController.text,
                              _passwordController.text,
                              _confirmPasswordController.text);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showOverlay() {
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.sizeOf(context).height * 0.4,
          width: MediaQuery.sizeOf(context).width,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      // ignore: prefer_const_constructors
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 80,
                            color: CustomColors.mainBlue,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Profile Created',
                            style: TextStyle(
                              color: CustomColors.mainBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context)?.insert(overlayEntry!);

    // Schedule the removal of the overlay after 2 seconds
    Timer(const Duration(seconds: 2), () {
      overlayEntry?.remove();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const LoginView()),
      // );
    });
  }
}
