import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/Component.dart';
import 'package:shop_app/Login_Screem_Shop.dart';
import 'package:shop_app/local/cashHelper.dart';
import 'package:shop_app/salla/Home/homescreen.dart';

void signOut(context) {
  CashHelper.removeCacheData(key: 'token').then((value) {
    if (value) {
      navigateAndFinished(context, loginScreenShop());
    }
  });
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = CashHelper.getData(key: 'token');
