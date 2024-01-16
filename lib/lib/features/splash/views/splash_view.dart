import 'package:anti_social_network/common/constants.dart';
import 'package:anti_social_network/common/custom_colors.dart';
import 'package:anti_social_network/features/homepage/view/homepage_view.dart';
import 'package:anti_social_network/features/login/views/sign_in/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String? token;
  @override
  initState() {
    super.initState();
    getToken();
  }

  Future<String?> getToken() async {
    token = await Utils.retrieveUserToken();
    if (token != "") {
      Future.delayed(const Duration(seconds: 1), () {
        context.go('/homepage');
      });

    }
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, Constants.getScreenHeight(context) * 0.1, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: const AssetImage("assets/icons/asn-logo-blue.png"),
                    width: Constants.getScreenWidth(context) * .5,
                    height: Constants.getScreenWidth(context) * .25,
                    fit: BoxFit.scaleDown,
                    alignment: FractionalOffset.center),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, Constants.getScreenHeight(context) * 0.2, 0, 0),
            child: Image(
                image: const AssetImage("assets/icons/splash-background.png"),
                width: Constants.getScreenWidth(context),
                height: Constants.getScreenHeight(context) * .6,
                fit: BoxFit.scaleDown,
                alignment: FractionalOffset.center),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, Constants.getScreenHeight(context) * 0.8, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Builder(
                  builder: (context) {
                    print(token);
                    if (token != "" && token!= null) {
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(CustomColors.darkBlue),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              context.go('/login');

                            },
                            child: const Text(
                              'Get Started',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 5),
                // TextButton(onPressed: null, child: Text('Continue as a guest'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
