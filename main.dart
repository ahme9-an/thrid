import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cvmaker/views/Helper/Router/router.dart';
import 'package:flutter_cvmaker/views/Helper/SharedPreferance/shared_preferance.dart';
import 'package:flutter_cvmaker/views/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_cvmaker/views/Screens/Regestration/regestration_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      options: const FirebaseOptions(
        messagingSenderId: "xxxx",
        apiKey: 'AIzaSyBzMHewB_JS4ygezk4N6mmA-zu4z3DtEvw',
        appId: '1:527061573619:android:9c980fe49b58fa4c23fc86',
        projectId: 'fluttercvmaker',
        storageBucket: 'fluttercvmaker.appspot.com'

        // apiKey: '...',
        // appId: '...',
        // messagingSenderId: '...',
        // projectId: '...',
      ),
    );
  } catch (e) {
    print("eeeeeeeeee$e");
  }
  await MobileAds.instance.initialize().then((InitializationStatus status) {
    print('Initialization done: ${status.adapterStatuses}');
    MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
          tagForChildDirectedTreatment:
              TagForChildDirectedTreatment.unspecified,
          testDeviceIds: <String>[
            "76D876DC25AAE04CF157D090E3029B30",
            "A8DE1403-9A26-4F50-8353-E44BD4BF743C"
          ]),
    );
  });
  await SpHelper.spHelper.initSharedPrefrences();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'تطبيق مياه';

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          // locale: DevicePreview.locale(context),

          debugShowCheckedModeBanner: false,
          title: _title,
          navigatorKey: RouterHelper.routerHelper.routerKey,
          // localizationsDelegates: context.localizationDelegates,
          // supportedLocales: context.supportedLocales,
          // locale: context.locale,
          // debugShowCheckedModeBanner: false,
          home: _showScreen(context), builder: EasyLoading.init(),
        );
      },
      // child: const HomePage(title: 'First Method'),
    );
  }
}

Widget _showScreen(context) {
  if (SpHelper.spHelper.isLogined() != null) {
    // requestPermission();
    // storeNotificationToken();
    return HomeScreen();
  } else {
    return const RegisterScreen();
  }

  // switch (SpHelper.spHelper.isLogined()) {
  //   case true:
  //     return const WellMainScreen();
  //   case false:
  //     return const RegisterScreen();
  // }
  return Container();
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
