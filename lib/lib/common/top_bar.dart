import 'package:anti_social_network/common/round_clipper_top.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'custom_colors.dart';

class TopBarWidget extends StatefulWidget {
  const  TopBarWidget({Key? key,required this.barHeight}) : super(key: key);

  final double barHeight;
  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.barHeight ,
      child: ClipPath(
        clipper: RoundedClipperTop(),
        child: Container(
          width: double.infinity,
          height: Constants.getScreenHeight(context) * .04,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  CustomColors.lightBlue,
                  CustomColors.darkBlue
                ]),
          ),
        ),
      ),
    );
  }
}
