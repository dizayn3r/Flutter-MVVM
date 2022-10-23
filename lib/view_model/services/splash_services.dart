
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/models/user_model.dart';
import 'package:flutter_mvvm_demo/utils/routes/routes_name.dart';
import 'package:flutter_mvvm_demo/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserDate() => UserViewModel().getUser();
  void checkAuthentication(BuildContext context)async{
    getUserDate().then((value)async{
      String token = "${value.token}";
      log("Token: $token");
      if(value.token.toString() == 'null' || value.token.toString() == ''){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }else {
        await  Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace){
      log("Error: $error");
    });

  }



}