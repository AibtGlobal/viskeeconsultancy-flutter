import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/AIBTSchoolNameEnum.dart';

class Utils {
  static getSchoolLogo(String? schoolName) {
    var aibtSchoolNameEnum = AIBTSchoolNameEnumUtils.fromValue(schoolName!);
    switch (aibtSchoolNameEnum) {
      case AIBTSchoolNameEnum.ACE:
        return Image.asset('images/ace_landscape.png');
      case AIBTSchoolNameEnum.BESPOKE:
        return Image.asset('images/bespoke_portrait.png');
      case AIBTSchoolNameEnum.BRANSON:
        return Image.asset('images/branson_portrait.png');
      case AIBTSchoolNameEnum.DIANA:
        return Image.asset('images/diana_portrait.png');
      case AIBTSchoolNameEnum.EDISON:
        return Image.asset('images/edison_portrait.png');
      case AIBTSchoolNameEnum.SHELDON:
        return Image.asset('images/sheldon_portrait.png');
      case AIBTSchoolNameEnum.REACH:
        return Image.asset('images/reach_portrait.png');
      default:
    }
  }
}