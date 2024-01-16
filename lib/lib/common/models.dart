import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

class ContactInfo extends ISuspensionBean {
  String name;
  String? tagIndex;
  String? namePinyin;
  String? asnID;
  Color? bgColor;
  IconData? iconData;

  String? img;
  String? id;
  String? firstletter;
  String? isFavorite;
  ContactInfo({
    required this.name,
    this.tagIndex,
    this.namePinyin,
    this.bgColor,
    this.iconData,
    this.img,
    this.id,
    this.firstletter,
    this.asnID,
    this.isFavorite
  });

  ContactInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        asnID = json['asnID'],
        img = json['img'],
        id = json['id']?.toString(),
        isFavorite = json['isFavorite'],
        firstletter = json['firstletter'];

  Map<String, dynamic> toJson() => {
//        'id': id,
        'name': name,
        'img': img,
        'asnID':asnID,
        'isFavorite': isFavorite
//        'firstletter': firstletter,
//        'tagIndex': tagIndex,
//        'namePinyin': namePinyin,
//        'isShowSuspension': isShowSuspension
      };

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);
}