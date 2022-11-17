import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/salla/cubit/cubitSalla.dart';
import 'package:shop_app/salla/cubit/statesSalla.dart';
import 'package:shop_app/salla/search/Search_Screen.dart';

import 'Component.dart';

class shopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SallaCubit(),
      child: BlocConsumer<SallaCubit, SallaState>(
        listener: (context, state) {},
        builder: (context, state) {
          SallaCubit shopCubit = SallaCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('SHOP'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                   navigateTo(context , searchScreen()) ;
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            body: shopCubit.screen[shopCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: shopCubit.currentIndex,
              onTap: (int index) {
                 shopCubit.changeCurrentIndix(index);
              },
              items: shopCubit.bottomItems,
            ),
          );
        },
      ),
    );
  }
}
