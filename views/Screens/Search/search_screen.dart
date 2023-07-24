import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cvmaker/models/major_model.dart';
import 'package:flutter_cvmaker/models/qualification_model.dart';
import 'package:flutter_cvmaker/models/user_model.dart';
import 'package:flutter_cvmaker/view_model/major_view_model.dart';
import 'package:flutter_cvmaker/view_model/qualification_view_model.dart';
import 'package:flutter_cvmaker/view_model/user_view_model.dart';
import 'package:flutter_cvmaker/views/Helper/Router/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_cvmaker/views/Screens/CV/cv_screen_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<MajorModel> majors = <MajorModel>[];
  List<QualificationModel> qualification = <QualificationModel>[];
  String selectedWell = '0';
  MajorModel dropdownValue = MajorModel(name: "non");
  String majorHint = 'اختار تخصص';

  String selectedQ = '0';
  QualificationModel dropdownValueQ = QualificationModel(name: "non");
  String qHint = 'اختار المؤهل العملي';
  List<UserModel> list = [];
  @override
  initState() {
    super.initState();
    getMajors();
    getQualification();
  }

  getMajors() {
    MajorViewModel v = MajorViewModel();
    majors.clear();
    v.getAllMajors().listen((event) {
      setState(() {
        event.forEach((element) {
          majors.add(element);
        });
      });
    });
  }

  getQualification() {
    QualificationViewModel v = QualificationViewModel();
    majors.clear();
    v.getAllQualificatios().listen((event) {
      setState(() {
        event.forEach((element) {
          qualification.add(element);
        });
      });
    });
  }

  searchByMajor(String major) {
    UserViewModel v = UserViewModel();

    list.clear();
    v.getByMajor(major).listen((event) {
      event.forEach((element) {
        setState(() {
          list.add(element);
          print(list);
        });
      });
    });
  }

  searchByMajorandQualification(String major, String qualification) {
    UserViewModel v = UserViewModel();

    list.clear();
    v.getByMajorandQualification(major, qualification).listen((event) {
      event.forEach((element) {
        setState(() {
          list.add(element);
          print(list);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 111, 156, 214),
            title: const Text("  البحث عن اشخاص"),
            titleSpacing: 00.0,
            toolbarHeight: 60.2,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
            elevation: 0.00,
            // actions: [
            //   Icon(Icons.notifications, color: Color(0xffffffff), size: 24),
            // ],
          ),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Column(
                  children: [
                   Row(
                      children: [
                        Expanded(
                          child: DropdownSearch<QualificationModel>(
                            popupProps:
                                PopupPropsMultiSelection.modalBottomSheet(
                              showSearchBox: true,
                            ),
                            // selectedItem: WellMdl(name: "كل الابار", id: "123"),
                            enabled: true,
                            items: qualification,
                            itemAsString: (QualificationModel u) =>
                                u.name.toString(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "المؤهل",
                                hintText: qHint,
                              ),
                            ),
                            onChanged: (QualificationModel? newValue) {
                              if (newValue!.id == "123") {
                                // getWaterProviders();
                              } else {
                                setState(() {
                                  dropdownValueQ = newValue;
                                  qHint = newValue.name.toString();
                                  // getConsumers(newValue.id!);
                                });
                                print(newValue.name);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                          child: DropdownSearch<MajorModel>(
                            popupProps:
                                PopupPropsMultiSelection.modalBottomSheet(
                              showSearchBox: true,
                            ),
                            // selectedItem: WellMdl(name: "كل الابار", id: "123"),
                            enabled: true,
                            items: majors,
                            itemAsString: (MajorModel u) => u.name.toString(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "التخصص",
                                hintText: majorHint,
                              ),
                            ),
                            onChanged: (MajorModel? newValue) {
                              if (newValue!.id == "123") {
                                // getWaterProviders();
                              } else {
                                setState(() {
                                  dropdownValue = newValue;
                                  majorHint = newValue.name.toString();
                                  // getConsumers(newValue.id!);
                                });
                                print(newValue.name);
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Perform the search here
                            searchByMajorandQualification(
                                dropdownValue.name.toString(),
                                dropdownValueQ.name.toString());
                          },
                        ),
                      ],
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 5,
                            child: ListTile(
                                leading: InkWell(
                                    onTap: () => UrlLauncher.launch(
                                        "tel://${list[index].primaryPhoneNo}"),
                                    child: Icon(Icons.call)),
                                title: Text("${list[index].name}"),
                                subtitle: Text(
                                    "${list[index].qualification}  ${list[index].major}"),
                                trailing: InkWell(child:Text("عرض السيفي"), onTap: (){
                                  RouterHelper.routerHelper
                        .routingToSpecificWidgetWithoutPop(CVSecreenSearch(userID: list[index].id.toString()));
                                  
                                })));
                      },
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
