import 'dart:convert';
import 'dart:io';

import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:metropole/app/constants/app.keys.dart';
import 'package:metropole/app/routes/app.routes.dart';
import 'package:metropole/core/api/user.api.dart';
import 'package:metropole/core/models/update.user.model.dart';
import 'package:metropole/core/models/user.model.dart';
import 'package:metropole/core/models/userDetails.model.dart';
import 'package:metropole/core/utils/snackbar.util.dart';

class UserNotifier with ChangeNotifier {
  final UserAPI _userAPI = UserAPI();

  String? userEmail = 'Жеткиликтүү эмес';
  String? get getUserEmail => userEmail;

  String? userName;
  String? get getUserName => userName;

  int? balance;
  int? get getBalance => balance;

  String userAddress = 'Жеткиликтүү эмес';
  String get getuserAddress => userAddress;

  String userPhoneNumber = 'Жеткиликтүү эмес';
  String get getuserPhoneNumber => userPhoneNumber;

  Future getUserData({
    required String token,
    required BuildContext context,
  }) async {
    try {
      var userData = await _userAPI.getUserData(token: token);
      var response = UserModel.fromJson(jsonDecode(userData));

      final _data = response.data;
      final _received = response.received;

      if (!_received) {
        notifyListeners();
        Navigator.of(context)
            .pushReplacementNamed(AppRouter.loginRoute)
            .whenComplete(
              () => {
                DeleteCache.deleteKey(AppKeys.userData).whenComplete(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackUtil.stylishSnackBar(
                        text: 'Башынан кириңиз', context: context),
                  );
                })
              },
            );
      } else {
        userEmail = _data.email;
        userName = _data.username;
        notifyListeners();
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Интернет байланышы начар!', context: context),
      );
    }
  }

  Future updateUserBalance({
    required String userEmail,
    required int balance,
  }) async {
    try {
      var userData = await _userAPI.updateUserBalance(
          userEmail: userEmail, balance: balance);

      print(userData);

      return 0;
    } on SocketException catch (_) {
      throw 'Error';
    }
  }

  Future getUserBalance({
    required String userEmail,
  }) async {
    try {
      var userData = await _userAPI.getUserDetails(userEmail: userEmail);
      var response = UserDetails.fromJson(jsonDecode(userData));
      final _data = response.data;
      final _filled = response.filled;
      final _received = response.received;

      if (_received && _filled) {
        userAddress = _data.userAddress;
        userPhoneNumber = _data.userPhoneNo;
        userEmail = _data.user.useremail;
        userName = _data.user.username;
        balance = _data.user.balance;

        return balance;
      }

      return 0;
    } on SocketException catch (_) {
      throw 'Error';
    }
  }

  Future getUserDetails({
    required String userEmail,
    required BuildContext context,
  }) async {
    try {
      var userData = await _userAPI.getUserDetails(userEmail: userEmail);
      var response = UserDetails.fromJson(jsonDecode(userData));
      final _data = response.data;
      final _filled = response.filled;
      final _received = response.received;

      if (_received && _filled) {
        userAddress = _data.userAddress;
        userPhoneNumber = _data.userPhoneNo;
        userEmail = _data.user.useremail;
        userName = _data.user.username;
        balance = _data.user.balance;
        notifyListeners();
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Интернет байланышы начар!', context: context),
      );
    }
  }

  Future updateUserDetails({
    required String userEmail,
    required String userAddress,
    required String userPhoneNo,
    required BuildContext context,
  }) async {
    try {
      var userData = await _userAPI.updateUserDetails(
          userEmail: userEmail,
          userAddress: userAddress,
          userPhoneNo: userPhoneNo);
      var response = UpdateUser.fromJson(jsonDecode(userData));
      final _updated = response.updated;
      notifyListeners();

      return _updated;
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Интернет байланышы начар!', context: context),
      );
    }
  }

  Future changePassword({
    required String userEmail,
    required String oluserpassword,
    required String newuserpassword,
    required BuildContext context,
  }) async {
    try {
      var userData = await _userAPI.changePassword(
          userEmail: userEmail,
          oluserpassword: oluserpassword,
          newuserpassword: newuserpassword);

      var response = ChangeUserPassword.fromJson(jsonDecode(userData));
      final _updated = response.updated;

      notifyListeners();

      return _updated;
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Интернет байланышы начар!', context: context),
      );
    }
  }
}
