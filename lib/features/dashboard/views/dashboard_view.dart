import 'package:anti_social_network/features/directory/views/directory_view.dart';
import 'package:anti_social_network/features/groups/views/groups/groups_view.dart';
import 'package:anti_social_network/features/maps/views/maps.dart';
import 'package:anti_social_network/features/messages/views/messages.dart';
import 'package:anti_social_network/features/requests/views/requests.dart';
import 'package:anti_social_network/features/updates/views/updates.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';

import '../../../common/constants.dart';
import '../../../common/custom_colors.dart';
import '../../../common/top_bar.dart';
import '../../settings/views/settings_view.dart';


class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map<String, AssetImage> gridItems = {
    "Favorites": const AssetImage("assets/icons/star.png"),
    "Groups": const AssetImage("assets/icons/people.png"),
    "Maps": const AssetImage("assets/icons/pin-map.png"),
    "Directory": const AssetImage("assets/icons/journal-frame.png"),
    "Updates": const AssetImage("assets/icons/app-indicator.png"),
    "Requests": const AssetImage("assets/icons/person-plus.png"),
    "Messages": const AssetImage("assets/icons/envelope.png"),
    "Settings": const AssetImage("assets/icons/gear.png"),
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        TopBarWidget(barHeight:Constants.getScreenHeight(context) * 0.1),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 50, 8, 0),
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 15,
            childAspectRatio: 1.4/1,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(gridItems.length, (index) {
              return GestureDetector(
                onTap: (){
                  switch (gridItems.keys.elementAt(index)){
                    case "Groups":{
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const GroupsView()));
                      break;
                    }
                    case "Favorites":{
                      context.push('/favorites');
                      break;
                    }

                    case "Directory":{
                      context.push('/directory');
                      break;
                    }

                    case "Updates" : {
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const Updates()));
                      break;
                    }

                    case "Requests" : {
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const Requests()));
                      break;
                    }

                    case "Messages":{
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const Messages()));

                      break;
                    }
                    case "Maps":{
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const Maps()));

                      break;
                    }
                    case "Settings":{
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const SettingsView()));
                      break;
                    }
                  }

                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8),),
                  ),
                  width: screenWidth*.3,
                  height: screenHeight*.1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // to preserve image color
                        Image(
                        image: gridItems.values.elementAt(index),
                        width:  screenWidth*.15,
                        height:  screenWidth*.15,
                        ),

                        // ImageIcon(
                        //   gridItems.values.elementAt(index),
                        //   size: screenWidth*.15,
                        //   color: null,
                        // ),
                        SizedBox(height: screenHeight*.02,),
                        Text(
                          gridItems.keys.elementAt(index),
                          style: TextStyle(color: CustomColors.greyBlue,fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }


}
