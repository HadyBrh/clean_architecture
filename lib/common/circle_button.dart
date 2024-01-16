import 'package:flutter/material.dart';

import 'custom_colors.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData? iconData;
  final double? size;
  final Color? color;
  const CircleButton({Key? key, this.onTap, this.iconData,this.size,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          size: 15.0,
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}