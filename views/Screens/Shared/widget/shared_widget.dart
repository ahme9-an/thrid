// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_cvmaker/views/Helper/Router/router.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
// import 'package:get/get.dart';
// import 'package:context_holder/context_holder.dart';

// import '../../Helper/Router/router.dart';

// void showSnackBarText(String text, context,
//     {Color backgroundColor = Colors.black}) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: backgroundColor,
//       content: Text(text),
//     ),
//   );
// }

showDilog(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text("حدث خطأ"),
            ));
      });
}

showAlertDialog(context, String title, String content, Function() okButton) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: okButton,
                    child: Text(
                      "تأكيد",
                      style: TextStyle(
                          // styling the text
                          fontSize: 16.0, //the size of the text
                          fontWeight: FontWeight.bold, // font weight
                          color: Colors.blue), //text color
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Text(
                      "الغاء",
                      style: TextStyle(
                          // styling the text
                          fontSize: 16.0, //the size of the text
                          fontWeight: FontWeight.bold, // font weight
                          color: Colors.red), //text color
                    )),
              ),
            ],
          ),
        );
      });
}

// GlobalKey<NavigatorState> routerKey = GlobalKey<NavigatorState>();
// BuildContext? _context = routerKey.currentContext;

void showSnackBarText(String text,
        {title = "حالة العملية", Color backgroundColor = Colors.blue}) =>
    Flushbar(
      icon: Icon(Icons.done, size: 30, color: Colors.white),
      shouldIconPulse: false,
      title: title,
      message: text,
      // mainButton: FlatButton(
      //   child: Text(
      //     'Click Me',
      //     style: TextStyle(color: Colors.white, fontSize: 16),
      //   ),
      //   onPressed: () {},
      // ),
      // onTap: (_) {
      //   print('Clicked bar');
      // },
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ).show(RouterHelper.routerHelper.routerKey.currentState!.context);

// void showSnackBarText(String text, context,
//         {Color backgroundColor = Colors.blue}) =>
//     Flushbar(
//       icon: Icon(Icons.done, size: 32, color: Colors.white),
//       shouldIconPulse: false,
//       title: 'Title',
//       message: text,
//       // mainButton: FlatButton(
//       //   child: Text(
//       //     'Click Me',
//       //     style: TextStyle(color: Colors.white, fontSize: 16),
//       //   ),
//       //   onPressed: () {},
//       // ),
//       // onTap: (_) {
//       //   print('Clicked bar');
//       // },
//       duration: Duration(seconds: 3),
//       flushbarPosition: FlushbarPosition.TOP,
//       backgroundColor: backgroundColor,
//       margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
//       borderRadius: BorderRadius.all(Radius.circular(20)),
//     ).show(context);

// void showCustomSnackBar(String message, {bool isError = true}) {
//   if (message != null && message.isNotEmpty) {
//     ScaffoldMessenger.of(
//             RouterHelper.routerHelper.routerKey.currentState!.context)
//         .showSnackBar(SnackBar(
//       dismissDirection: DismissDirection.horizontal,
//       margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//       duration: Duration(seconds: 3),
//       backgroundColor: isError ? Colors.red : Colors.green,
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
//       content: Text(message, style: robotoMedium.copyWith(color: Colors.white)),
//     ));
//   }
// }

// class Dimensions {
//   static double fontSizeExtraSmall = Get.context!.width >= 1300 ? 14 : 10;
//   static double fontSizeSmall = Get.context!.width >= 1300 ? 16 : 12;
//   static double fontSizeDefault = Get.context!.width >= 1300 ? 18 : 14;
//   static double fontSizeLarge = Get.context!.width >= 1300 ? 20 : 16;
//   static double fontSizeExtraLarge = Get.context!.width >= 1300 ? 22 : 18;
//   static double fontSizeOverLarge = Get.context!.width >= 1300 ? 28 : 24;

//   static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
//   static const double PADDING_SIZE_SMALL = 10.0;
//   static const double PADDING_SIZE_DEFAULT = 15.0;
//   static const double PADDING_SIZE_LARGE = 20.0;
//   static const double PADDING_SIZE_EXTRA_LARGE = 25.0;
//   static const double PADDING_SIZE_OVER_LARGE = 30.0;

//   static const double RADIUS_SMALL = 5.0;
//   static const double RADIUS_DEFAULT = 10.0;
//   static const double RADIUS_LARGE = 15.0;
//   static const double RADIUS_EXTRA_LARGE = 20.0;

//   static const double WEB_MAX_WIDTH = 1170;
//   static const int MESSAGE_INPUT_LENGTH = 250;
// }

// final robotoMedium = TextStyle(
//   fontFamily: 'Roboto',
//   fontWeight: FontWeight.w500,
//   fontSize: Dimensions.fontSizeDefault,
// );
