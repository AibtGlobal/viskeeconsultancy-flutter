import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viskeeconsultancy/models/SubFolderEnum.dart';
import 'package:viskeeconsultancy/pages/ConfigurationDownloadPage.dart';
import 'package:viskeeconsultancy/util/Utils.dart';
import 'package:viskeeconsultancy/values/CustomColors.dart';
import 'package:viskeeconsultancy/values/NavigationPath.dart';
import 'package:viskeeconsultancy/widgets/CommonWidgets.dart';

class CoeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:  () async {
          Utils.onBackPressed(context, true);
          return true;
          },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CommonWidgets.getAppBar(context, true),
          body: Container(
              child: Column(children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: null,
                )),
            Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("Do you require a Confirmation of Enrolment (CoE)?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: CustomColors.GOLD))),
            ),
            Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text("COE",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                          onPressed: () {
                            NavigationPath.PATH.add("COE");
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: ConfigurationDownloadPage(SubFolderEnum.COE),
                                    type: PageTransitionType.topToBottom));
                          }),
                    ))),
            Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.GOLD),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text("NON-COE",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                          onPressed: () {
                            NavigationPath.PATH.add("Non-COE");
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: ConfigurationDownloadPage(SubFolderEnum.NON_COE),
                                    type: PageTransitionType.topToBottom));
                          }),
                    ))),
            Expanded(
                flex: 1,
                child: Container(
                  child: null,
                )),
          ])),
        ));
  }
}
