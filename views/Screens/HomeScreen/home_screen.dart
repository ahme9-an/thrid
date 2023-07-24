import 'package:flutter/material.dart';
import 'package:flutter_cvmaker/models/user_model.dart';
import 'package:flutter_cvmaker/view_model/user_view_model.dart';
import 'package:flutter_cvmaker/views/Helper/Router/router.dart';
import 'package:flutter_cvmaker/views/Helper/SharedPreferance/shared_preferance.dart';
import 'package:flutter_cvmaker/views/Screens/Account/account_screen.dart';
import 'package:flutter_cvmaker/views/Screens/Admin/admin_home_screen.dart';
import 'package:flutter_cvmaker/views/Screens/Regestration/regestration_screen.dart';
import 'package:flutter_cvmaker/views/Screens/Search/search_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                InkWell(
                  onTap: () async {
                    UserViewModel v = UserViewModel();
                    UserModel user = await v
                        .getUserById(SpHelper.spHelper.getMyID().toString());
                    RouterHelper.routerHelper
                        .routingToSpecificWidgetWithoutPop(AccountScreen(
                      user: user,
                    ));
                  },
                  child: Container(
                    child: Column(children: [
                      Icon(Icons.person_2_outlined),
                      Expanded(child: Center(child: Text("حسابي")))
                    ]),
                    height: 60.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ),
                ),
                Container(
                  height: 40.h,
                  width: 2.w,
                  decoration:
                      BoxDecoration(border: Border(), color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    RouterHelper.routerHelper
                        .routingToSpecificWidgetWithoutPop(SearchScreen());
                  },
                  child: Container(
                    child: Column(children: [
                      Icon(Icons.search_off_outlined),
                      Expanded(child: Center(child: Text("بحث")))
                    ]),
                    height: 60.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ),
                ),
                SpHelper.spHelper.isAdnin() == true
                    ? Container(
                        height: 40.h,
                        width: 2.w,
                        decoration: BoxDecoration(
                            border: Border(), color: Colors.black),
                      )
                    : Container(),
                SpHelper.spHelper.isAdnin() == true
                    ? InkWell(
                        onTap: () {
                          RouterHelper.routerHelper
                              .routingToSpecificWidgetWithoutPop(
                                  AdminHomeScreen());
                        },
                        child: Container(
                          child: Column(children: [
                            Icon(Icons.admin_panel_settings),
                            Expanded(child: Center(child: Text("ادارة")))
                          ]),
                          height: 60.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                        ),
                      )
                    : Container(),
              ]),
              InkWell(
                onTap: () {
                  SpHelper.spHelper.logout();
                  RouterHelper.routerHelper
                      .routingReplacementUntil(RegisterScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 150.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.red[300]),
                  child: Text(
                    ' خروج',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
