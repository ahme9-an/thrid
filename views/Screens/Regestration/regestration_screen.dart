import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cvmaker/models/user_model.dart';
import 'package:flutter_cvmaker/view_model/user_view_model.dart';
import 'package:flutter_cvmaker/views/Helper/Router/router.dart';
import 'package:flutter_cvmaker/views/Helper/SharedPreferance/shared_preferance.dart';
import 'package:flutter_cvmaker/views/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'add_user_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  double bottom = 0;

  String otpPin = " ";
  String countryDial = "+967";
  String verID = " ";

  int screenState = 0;

  String buttinText = "متابعه";

  Color blue = const Color(0xff8cccff);

  Future<void> verifyPhone(String number) async {
    setState(() {
      screenState = 1;
    });
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        timeout: const Duration(seconds: 20),
        verificationCompleted: (PhoneAuthCredential credential) {
          showSnackBarText("تم التحقق!");
          setState(() {
            buttinText = "متابعه";
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          showSnackBarText("فشل التحقق!");
          setState(() {
            buttinText = "متابعه";
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          showSnackBarText("تم ارسال الكود!");
          verID = verificationId;
          setState(() {
            screenState = 1;
            buttinText = "متابعه";
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          showSnackBarText("انتهى الوقت!");
        },
      );
    } catch (e) {
      print("nnnnnnnnnnnnnnnn$e");
    }
  }

  Future<void> verifyOTP() async {
    UserViewModel userViewModel =  UserViewModel();
    try {
      EasyLoading.show(status: 'جاري التنفيذ...');
      // await FirebaseAuth.instance
      //     .signInWithCredential(
      //       PhoneAuthProvider.credential(
      //         verificationId: verID,
      //         smsCode: otpPin,
      //       ),
      //     )
      //     .whenComplete(() {});

      Stream<List<UserModel>> list =
          userViewModel.getUserByPhoneNumber(phoneController.text);
      list.listen((event) {
        try {
          print("event ttttttttttt $event");

          SpHelper.spHelper.login(
              event.first.id.toString(),
              event.first.primaryPhoneNo.toString(),
              event.first.name.toString(),
              event.first.admin);
          EasyLoading.dismiss();
          RouterHelper.routerHelper.routingReplacement(HomeScreen());
        } catch (e) {
          EasyLoading.dismiss();
          RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(AddUserScreen(
            userPrimaryNumber: phoneController.text,
          ));
        }
      });
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBarText("حدث خطأ");
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    bottom = MediaQuery.of(context).viewInsets.bottom;

    return WillPopScope(
      onWillPop: () {
        setState(() {
          screenState = 0;
        });
        return Future.value(false);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: blue,
          body: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight / 8),
                    child: Column(
                      children: [
                        Text(
                          " CV Maker",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth / 8,
                          ),
                        ),
                        Text(
                          "يمكنك انشاء حساب برقم الهاتف فقط!",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: screenWidth / 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: circle(5),
                ),
                Transform.translate(
                  offset: const Offset(30, -30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: circle(4.5),
                  ),
                ),
                Center(
                  child: circle(3),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    height: bottom > 0 ? screenHeight : screenHeight / 2,
                    width: screenWidth,
                    color: Colors.white,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth / 12,
                        right: screenWidth / 12,
                        top: bottom > 0 ? screenHeight / 12 : 0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          screenState == 0 ? stateRegister() : stateOTP(),
                          GestureDetector(
                            onTap: () {
                              if (screenState == 0) {
                                if (phoneController.text.isEmpty) {
                                  showSnackBarText("يرجى ادخال رقم الهاتف");
                                } else {
                                  setState(() {
                                    buttinText = "....جاري التحقق";
                                  });
                                  verifyPhone(
                                      countryDial + phoneController.text);
                                }
                              } else {
                                if (otpPin.length >= 6) {
                                  setState(() {
                                    buttinText = "متابعه";
                                  });
                                  verifyOTP();
                                } else {
                                  showSnackBarText(
                                      "يرجى ادخال الرمز بشكل صحيح!");
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              width: screenWidth,
                              margin:
                                  EdgeInsets.only(bottom: screenHeight / 12),
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                  child: Text("$buttinText",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        fontSize: 18,
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  Widget stateRegister() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          "رقم الهاتف",
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IntlPhoneField(
            controller: phoneController,
            showCountryFlag: false,
            showDropdownIcon: false,
            initialValue: countryDial,
            onCountryChanged: (country) {
              setState(() {
                countryDial = "+" + country.dialCode;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget stateOTP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "لقد تم ارسال الكود اليك ",
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: countryDial + phoneController.text,
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: "\nادخل الكود اسفل للمتابعه",
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: PinCodeTextField(
            appContext: context,
            length: 6,
            onChanged: (value) {
              setState(() {
                otpPin = value;
              });
            },
            pinTheme: PinTheme(
              activeColor: blue,
              selectedColor: blue,
              inactiveColor: Colors.black26,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "لم ستسقبل الكود؟ ",
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        screenState = 0;
                        buttinText = "متابعه";
                      });
                    },
                    child: Text(
                      "اعادة ارسال",
                      style: GoogleFonts.montserrat(
                        color: Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget circle(double size) {
    return Container(
      height: screenHeight / size,
      width: screenHeight / size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}
