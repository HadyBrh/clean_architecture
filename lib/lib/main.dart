import 'package:anti_social_network/features/connect/views/connect_cubit.dart';
import 'package:anti_social_network/features/directory/views/directory_cubit.dart';
import 'package:anti_social_network/features/directory/views/directory_view.dart';
import 'package:anti_social_network/features/favorites/views/favorites_cubit.dart';
import 'package:anti_social_network/features/favorites/views/favorites_view.dart';
import 'package:anti_social_network/features/groups/views/create_group/create_group_cubit.dart';
import 'package:anti_social_network/features/groups/views/groups/groups_cubit.dart';
import 'package:anti_social_network/features/groups/views/select_group_members/select_group_members_cubit.dart';
import 'package:anti_social_network/features/groups/views/single_group/group_profile_cubit.dart';
import 'package:anti_social_network/features/homepage/view/homepage_view.dart';
import 'package:anti_social_network/features/login/views/sign_in/login_view.dart';
import 'package:anti_social_network/features/maps/views/maps_cubit.dart';
import 'package:anti_social_network/features/preset/views/list_preset_dialog/preset_cubit.dart';
import 'package:anti_social_network/features/profile/views/my_profile/profile_cubit.dart';
import 'package:anti_social_network/features/profile/views/user_profile/user_profile_cubit.dart';
import 'package:anti_social_network/features/profile/views/user_profile/user_profile_view.dart';
import 'package:anti_social_network/features/requests/views/requests_cubit.dart';
import 'package:anti_social_network/features/settings/views/settings_cubit.dart';
import 'package:anti_social_network/features/splash/views/splash_view.dart';
import 'package:anti_social_network/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  initializeApp();
  runApp(
    const MyApp(),
  );
}

Future<void> initializeApp() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

}
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesView(),
    ),
    GoRoute(
      path: '/directory',
      builder: (context, state) => const DirectoryView(),
    ),
    GoRoute(
      path: '/userprofile/:uuid',
      builder: (context, state) => UserProfileView(uuid: state.pathParameters['uuid']?? ""),
    ),
  ],
);
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider<DirectoryCubit>(
          create: (context) => DirectoryCubit(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) => FavoritesCubit(),
        ),
        BlocProvider<ConnectCubit>(
          create: (context) => ConnectCubit(),
        ),
        BlocProvider<GroupsCubit>(
          create: (context) => GroupsCubit(),
        ),
        BlocProvider<MapsCubit>(
          create: (context) => MapsCubit(),
        ),
        BlocProvider<RequestsCubit>(
          create: (context) => RequestsCubit(),
        ),
        BlocProvider<UserProfileCubit>(
          create: (context) => UserProfileCubit(),
        ),
        BlocProvider<CreateGroupCubit>(
          create: (context) => CreateGroupCubit(),
        ),
        BlocProvider<SelectGroupMembersCubit>(
          create: (context) => SelectGroupMembersCubit(),
        ),
        BlocProvider<PresetCubit>(
          create: (context) => PresetCubit(),
        ),
        BlocProvider<GroupProfileCubit>(
          create: (context) => GroupProfileCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'ASN',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true, //<-- SEE HERE
            fillColor: Colors.white, //<-- SEE HERE
          ),
        ),
        // home:  const HomePage(),
      ),
    );
  }
}
