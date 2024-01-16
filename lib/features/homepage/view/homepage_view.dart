import 'package:anti_social_network/features/dashboard/views/dashboard_view.dart';
import 'package:anti_social_network/features/profile/views/my_profile/profile_cubit.dart';
import 'package:anti_social_network/features/profile/views/my_profile/profile_view.dart';
import 'package:anti_social_network/common/bottom_navigation_bar.dart';
import 'package:anti_social_network/features/settings/views/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../../../common/constants.dart';
import '../../../common/custom_colors.dart';
import '../../connect/views/connect_view.dart';
import '../../search_page/views/search_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    SearchPage(),
    Connect(),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      body: _children[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: MediaQuery.sizeOf(context).height * .12,
        child: ClipPath(
          clipper: ProsteBezierCurve(
            position: ClipPosition.top,
            list: [
              BezierCurveSection(
                start: Offset(Constants.getScreenWidth(context), 8),
                top: Offset(Constants.getScreenWidth(context) / 2, 0),
                end: const Offset(0, 8),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,
            selectedItemColor: Colors.greenAccent,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,
            type: BottomNavigationBarType.fixed, // Fixed
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/dashboard.png"),
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/search.png"),
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/scan.png"),
                ),
                label: 'Connect',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/person.png"),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
