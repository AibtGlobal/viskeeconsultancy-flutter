import 'package:flutter/material.dart';
import 'package:viskeeconsultancy/models/Course.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'dart:html' as html;

Course? course;

class CourseDetailPage extends StatelessWidget {
  CourseDetailPage(Course input) {
    course = input;
  }

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      course = ModalRoute.of(context)!.settings.arguments as Course;
    }
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  "images/vc_logo_landscape.png",
                  fit: BoxFit.contain,
                  height: 40,
                ),
              )
            ],
          ),
        ),
        body: Container(
            child: ListView(shrinkWrap: false, children: _getListData())));
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 3; i++) {
      widgets.add(new ColumnItem(i));
    }
    return widgets;
  }
}

class ColumnItem extends StatelessWidget {
  late int index;
  ColumnItem(int index) {
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(course!.name!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: CustomColors.GOLD))));
    } else if (index == 1) {
      return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [getVetCodeText(course), getCricosCodeText(course)],
            ),
          ));
    } else if (index == 2) {
      return Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    "images/clock.png",
                    height: 60,
                    color: CustomColors.GOLD,
                  ),
                ),
                Text(
                  "Total Duration",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: getTotalDurationText(course),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: getDurationDetailText(course),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    "images/location.png",
                    height: 60,
                    color: CustomColors.GOLD,
                  ),
                ),
                Text(
                  "Location",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: getLocationText(course),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    "images/pricing.png",
                    height: 60,
                    color: CustomColors.GOLD,
                  ),
                ),
                Text(
                  "Pricing",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: getTuitionText(course),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.GOLD),
                  ),
                  child: Text("Terms and Conditions"),
                  onPressed: () {
                    html.window.open(
                        "https://aibtglobal.edu.au/courses/terms-for-courses/",
                        "Terms and Conditions");
                  }),
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: null,
      );
    }
  }

  Text getVetCodeText(Course? course) {
    if (course != null && course.vetCode != null) {
      return Text(
        "VET National Code:" + course.vetCode!,
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Text getCricosCodeText(Course? course) {
    if (course != null && course.cricosCode != null) {
      return Text(
        "CRICOS Course Code:" + course.cricosCode!,
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Text getTotalDurationText(Course? course) {
    if (course != null && course.cricosCode != null) {
      return Text(
        course.getDurationString() + " Weeks",
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Text getDurationDetailText(Course? course) {
    if (course != null && course.durationDetail != null) {
      return Text(
        course.durationDetail!,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Text getLocationText(Course? course) {
    if (course != null && course.location != null) {
      return Text(
        course.location.toString(),
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }

  Text getTuitionText(Course? course) {
    if (course != null && course.tuition != null) {
      return Text(
        "Tuition Fee - \$" +
            course.tuition!.toString(),
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text("");
    }
  }
}
