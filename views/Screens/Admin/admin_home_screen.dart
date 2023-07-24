
import 'package:flutter/material.dart';
import 'package:flutter_cvmaker/views/Helper/Router/router.dart';
import 'package:flutter_cvmaker/views/Screens/Admin/majors_screen.dart';
import 'package:flutter_cvmaker/views/Screens/Admin/qualification_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              InkWell(
                child: Card(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Text("التخصصات"),
                        // title: Text("${well.name}"),
                        // subtitle: Text('${well.location}'),
                        trailing: Text("دخول"),
                      ),
                    ],
                  ),
                  elevation: 10,
                ),
                onTap: (){
                   RouterHelper.routerHelper
                      .routingToSpecificWidgetWithoutPop(MajorScreen());
                },
              ),
               InkWell(
                child: Card(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Text("المؤهلات العلمية"),
                        // title: Text("${well.name}"),
                        // subtitle: Text('${well.location}'),
                        trailing: Text("دخول"),
                      ),
                    ],
                  ),
                  elevation: 10,
                ),
                onTap: (){
                   RouterHelper.routerHelper
                      .routingToSpecificWidgetWithoutPop(QualificationScreen());
                },
              ),
             
            ],
          ),
        ));
  }
}