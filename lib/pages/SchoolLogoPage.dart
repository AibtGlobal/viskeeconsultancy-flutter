import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/Department.dart';
import 'package:viskeeconsultancy/models/Group.dart';
import 'package:viskeeconsultancy/models/School.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/values/StringConstants.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

import 'BrochureDownloadPage.dart';
import 'SchoolCoursesPage.dart';

class SchoolLogoPage extends StatelessWidget {
  late Group _group;

  SchoolLogoPage(Group group) {
    _group = group;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Utils.onBackPressed(context, true);
          return true;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CommonWidgets.getAppBar(context, true),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: null,
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: _buildTitleLogo(),
                      )),
                  Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Utils.getGroupPrimaryColor(_group.name)),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text("LATEST BROCHURES",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: BrochureDownloadPage(_group.name!, _group.brochures),
                                      type: PageTransitionType.topToBottom));
                            }),
                      )),
                  Expanded(
                      flex: 8,
                      child: Align(
                        alignment: Alignment.center,
                        child: _buildGrid(),
                      )),
                ],
              ),
            )));
  }

  Widget _buildTitleLogo() {
    if (_group.name == StringConstants.AIBT_GROUP_NAME) {
      return Utils.isRunningOnMobileBrowser()
          ? Padding(padding: EdgeInsets.all(30), child: Image.asset("images/aibt_landscape.png"))
          : SvgPicture.asset("images/aibt.svg");
    } else {
      return Utils.isRunningOnMobileBrowser()
          ? Padding(padding: EdgeInsets.all(30), child: Image.asset("images/reach_landscape.png"))
          : SvgPicture.asset("images/reach.svg");
    }
  }

  Widget _buildGrid() => new StaggeredGridView.countBuilder(
      crossAxisCount: 1,
      shrinkWrap: true,
      // maxCrossAxisExtent: 240,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      itemCount: _group.schools.length,
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(_group.schools.length),
      itemBuilder: (BuildContext context, int index) {
        return new SchoolGridView(_group, index);
      });
}

class SchoolGridView extends StatelessWidget {
  late School _school;
  late Group _group;

  SchoolGridView(Group group, int index) {
    this._group = group;
    this._school = group.schools[index];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Utils.getGroupSecondaryColor(_group.name)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ))),
          onPressed: () {
            NavigationPath.PATH.add(Utils.getSchoolTitle(_school.name!));
            Navigator.push(
                context, PageTransition(child: SchoolCoursesPage(_school), type: PageTransitionType.topToBottom));
          },
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 14, 10, 7),
                  child: Text(Utils.getSchoolTitle(_school.name!),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 7, 10, 14),
                  child: Text(buildDepartmentString(_school.departments),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15)))
            ],
          ),
        ));
  }

  String buildDepartmentString(List<Department> departments) {
    List<String> departmentNames = departments.map((e) => e.name!).toList();
    departmentNames.removeWhere((element) => element.toLowerCase().contains("package"));
    return departmentNames.join(" | ");
  }
}
