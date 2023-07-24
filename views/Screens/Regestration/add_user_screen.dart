import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_cvmaker/models/major_model.dart';
import 'package:flutter_cvmaker/models/qualification_model.dart';
import 'package:flutter_cvmaker/models/user_model.dart';
import 'package:flutter_cvmaker/view_model/major_view_model.dart';
import 'package:flutter_cvmaker/view_model/qualification_view_model.dart';
import 'package:flutter_cvmaker/view_model/user_view_model.dart';
import 'package:flutter_cvmaker/views/Helper/Router/router.dart';
import 'package:flutter_cvmaker/views/Helper/SharedPreferance/shared_preferance.dart';
import 'package:flutter_cvmaker/views/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_cvmaker/views/Screens/Shared/widget/shared_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key, required this.userPrimaryNumber});
  final String userPrimaryNumber;

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  File? _image;
  ImagePicker? _picker = new ImagePicker();
  List<MajorModel> majors = <MajorModel>[];
  List<QualificationModel> qualification = <QualificationModel>[];
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

  TextEditingController primaryPhoneNpController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController secondaryPhoneNoController =
      new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  bool _buttonClick = true;
  Color _buttonColor = Colors.blue;

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('المعرض'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('الكاميرا'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker!.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("img ggggg ggg $_image");
        try {
          // uploadFile();
        } catch (e) {
          print("error $e");
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker!.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        print("hhhhhhhhhhhhhhhhhhhhhhhhhhh");
        _image = File(pickedFile.path);
//
        // uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  String selectedWell = '0';
  MajorModel dropdownValue = MajorModel(name: "non");
  String majorHint = 'اختار تخصص';

  String selectedQ = '0';
  QualificationModel dropdownValueQ = QualificationModel(name: "non");
  String qHint = 'اختار المؤهل العملي';
  @override
  Widget build(BuildContext context) {
    primaryPhoneNpController.text = widget.userPrimaryNumber;
    final _formKey = GlobalKey<FormState>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 111, 156, 214),
          title: const Text(" تسجيل حساب"),
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: _image == null
                                  ? Image.asset("assets/images/user.png",
                                      height: 300, width: 300)
                                  : SizedBox(
                                      width: 180.0,
                                      height: 180.0,
                                      child: (_image != null)
                                          ? Image.file(_image!)
                                          : Text("data")),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera,
                              size: 30.0,
                            ),
                            onPressed: () {
                              _showPicker(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: userNameController,
                    // onSaved: (value) =>
                    // credit = (int.parse(value!)).toDouble(),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0)),
                        labelText: 'الاسم  ',
                        hintText: 'ادخل الاسم بالكامل'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى ادخال  الاسم ';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: primaryPhoneNpController,
                    // onSaved: (value) =>
                    // credit = (int.parse(value!)).toDouble(),
                    enabled: false,

                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(0)),
                        labelText: 'رقم الهاتف الاساسي  '),
                  ),
                
                  DropdownSearch<QualificationModel>(
                    popupProps: PopupPropsMultiSelection.modalBottomSheet(
                      showSearchBox: true,
                    ),
                    // selectedItem: WellMdl(name: "كل الابار", id: "123"),
                    enabled: true,
                    items: qualification,
                    itemAsString: (QualificationModel u) => u.name.toString(),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: qHint,
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
                  DropdownSearch<MajorModel>(
                    popupProps: PopupPropsMultiSelection.modalBottomSheet(
                      showSearchBox: true,
                    ),
                    enabled: true,
                    items: majors,
                    itemAsString: (MajorModel u) => u.name.toString(),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: majorHint,
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
                  
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AbsorbPointer(
                    absorbing: !_buttonClick,
                    child: InkWell(
                      onTap: () async {
                        UserViewModel userViewModel = UserViewModel();
                        if (dropdownValue.name == "non") {
                          showSnackBarText("يرجى ادخال التخصص",
                              backgroundColor: Colors.red);
                          return;
                        }
                        if (dropdownValueQ.name == "non") {
                          showSnackBarText("يرجى ادخال المؤهل العملي",
                              backgroundColor: Colors.red);
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          EasyLoading.show(status: 'جاري التنفيذ...');

                          try {
                            userViewModel.addUser(UserModel(
                                name: userNameController.text,
                                primaryPhoneNo: primaryPhoneNpController.text,
                                major: dropdownValue.name,
                                qualification: dropdownValueQ.name,
                                admin: false));
                            Stream<List<UserModel>> list =
                                userViewModel.getUserByPhoneNumber(
                                    primaryPhoneNpController.text);
                            list.listen((event) {
                              try {
                                print("event ttttttttttt $event");

                                SpHelper.spHelper.login(
                                    event.first.id.toString(),
                                    event.first.primaryPhoneNo.toString(),
                                    event.first.name.toString(),
                                    event.first.admin);
                                EasyLoading.dismiss();
                                RouterHelper.routerHelper
                                    .routingReplacement(HomeScreen());
                              } catch (e) {
                                EasyLoading.dismiss();
                                RouterHelper.routerHelper
                                    .routingReplacementUntil(AddUserScreen(
                                  userPrimaryNumber:
                                      primaryPhoneNpController.text,
                                ));
                              }
                            });
                          } catch (e) {}
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 120.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _buttonColor),
                        child: Text(
                          'تسجيل حساب',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
