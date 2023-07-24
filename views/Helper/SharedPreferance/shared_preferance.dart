import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();

  static SpHelper spHelper = SpHelper._();
  SharedPreferences? sharedPreferences;

  initSharedPrefrences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    log('hello');
  }

  bool getIsLoginFirstTime() {
    bool isFirstTime = sharedPreferences!.getBool('isFirstTime') ?? true;
    return isFirstTime;
  }

  setIsLoginFirstTime() {
    sharedPreferences!.setBool('isFirstTime', false);
  }

  setTokenId(String id) {
    sharedPreferences!.setString('Token', id);
  }

  getTokenId() {
    String TokenId = sharedPreferences!.getString('Token') ?? '';
    return TokenId;
  }

  login(String currentUserID, String phoneNo, String name, admin) {
    sharedPreferences!.setBool('Logined', true);
    setMyID(currentUserID);
    setMyPhoneNo(phoneNo);
    setMyName(name);
    setIsAdmin(admin);
  }

  logout() {
    sharedPreferences!.setBool('Logined', false);
    sharedPreferences!.clear();
  }

  bool? isLogined() {
    return sharedPreferences!.getBool('Logined');
  }

  setMyName(String name) async {
    bool isSuccess = await sharedPreferences!.setString('name', name);
    log(isSuccess.toString());
  }

  setMyID(String userID) async {
    bool isSuccess = await sharedPreferences!.setString('userID', userID);
    log(isSuccess.toString());
  }

  setIsAdmin(bool admin) async {
    bool isSuccess = await sharedPreferences!.setBool('admin', admin);
    log(isSuccess.toString());
  }

  bool? isAdnin() {
    return sharedPreferences!.getBool('admin');
  }

  setMyPhoneNo(String userPhoneNo) async {
    bool isSuccess =
        await sharedPreferences!.setString('userPhoneNo', userPhoneNo);
    log(isSuccess.toString());
  }

  String? getMyName() {
    return sharedPreferences!.getString('name');
  }

  String? getMyID() {
    return sharedPreferences!.getString('userID');
  }

  String? getMyPhoneNo() {
    return sharedPreferences!.getString('userPhoneNo');
  }
}
