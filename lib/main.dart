import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Login_Screem_Shop.dart';
import 'package:shop_app/local/cashHelper.dart';
import 'package:shop_app/onBoarding.dart';
import 'package:shop_app/salla/Categories/CategoriesScreen/categories.dart';
import 'package:shop_app/salla/Favorites/favorites.dart';
import 'package:shop_app/salla/Home/homescreen.dart';
import 'package:shop_app/salla/Register/registerScreen.dart';
import 'package:shop_app/remote/Dio_helper.dart';
import 'package:shop_app/salla/cubit/cubitSalla.dart';
import 'package:shop_app/salla/cubit/statesSalla.dart';
import 'package:shop_app/salla/search/Search_Screen.dart';
import 'package:shop_app/salla/setting/setteing.dart';
import 'package:shop_app/shopLayout.dart';
import 'package:shop_app/styles/theme.dart';

import 'boc_observer/boc_Observer.dart';
import 'content/content.dart';
import 'main_cubit/Main_Cubit.dart';
import 'main_cubit/Main_State.dart';

void main() async {
  // كوود يضمن ان كل ما هو قبل run  البرنامج سوف ينفذ
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();

  Widget widget;
  bool? onBoarding = CashHelper.getData(key: 'onBoarding') ?? true;
  token = CashHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = shopLayout();
    } else
      widget = loginScreenShop();
  } else {
    widget = onBoardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MainCubit(),
        ),
        BlocProvider(
            create: (BuildContext context) => SallaCubit()
              ..getFavoriteModelData()
              ..getCategoriesData()
              ..getHomeModelData()
              ..getProfileModelData()
              ),
      ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: dark,
            theme: light,
            // themeMode: MainCubit.get(context).isDark!
            //     ? ThemeMode.dark
            //     : ThemeMode.light,
            themeMode: ThemeMode.light,
            home: Favorites_Screen(),
          );
        },
      ),
    );
  }
}
