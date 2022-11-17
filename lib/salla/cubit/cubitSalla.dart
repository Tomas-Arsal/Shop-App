import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/end_points/end_points.dart';
import 'package:shop_app/remote/Dio_helper.dart';
import 'package:shop_app/salla/Favorites/FavoritsModel.dart';
import 'package:shop_app/salla/Favorites/change_favorite_model.dart';
import 'package:shop_app/salla/Favorites/favorites.dart';
import 'package:shop_app/salla/cubit/statesSalla.dart';
import 'package:shop_app/user_model/user_model.dart';
import '../../content/content.dart';
import '../Categories/CategoriesScreen/CategoriesModels.dart';
import '../Categories/CategoriesScreen/categories.dart';

import '../Home/homeModel/homeModel.dart';
import '../Home/homescreen.dart';
import '../setting/setteing.dart';

class SallaCubit extends Cubit<SallaState> {
  SallaCubit() : super(NewInisialState()) {}

  static SallaCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    HomeScreen(),
    categories_Screen(),
    Favorites_Screen(),
    setteing_Screen(),
  ];

  void changeCurrentIndix(index) {
    currentIndex = index;
    emit(NewBottomNavState());
  }

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Colors.indigo,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.category,
        color: Colors.indigo,
      ),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
        color: Colors.indigo,
      ),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
        color: Colors.indigo,
      ),
      label: 'Settings',
    ),
  ];
  HomeModel? homeModel;
  late Map<int, bool> favoriets = {};

  void getHomeModelData() {
    emit(NewGetHomeLoadingSuccessState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favoriets.addAll(
          {
            element.id: element.inFavorites,
          },
        );
      });
      emit(NewGetHomeSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(NewGetHomeErrorState(error.toString()));
    });
  }
  Map<int, bool> favorites = {};
  FavoritesModel? favoritesModel;

  void getFavoriteModelData() {
    emit(NewGetFavorietsLoadingSuccessState());
    DioHelper.getData(url: FAVORIETS_PRODUCTS, token: token).then((value) {
      // print(value.data);

      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(NewGetFavorietsSuccessState());
    }).catchError((err) {
      // print(err.toString());
      emit(NewGetFavorietsErrorState(err.toString()));
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites(int productId) async {
    try {
      favorites[productId] = !favorites[productId]!;
      emit(NewChangeFavorietsLoadingSuccessState());

      Response value = await DioHelper.postData(
        url: FAVORIETS_PRODUCTS,
        data: {
          'product_id': productId,
        },
        token: token,
      );

      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel!.status) {
        // in case the status in remote == false
        // redo the change color in local
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoriteModelData();
      }

      emit(NewChangeFavorietsSuccessState(changeFavoriteModel!));
    } catch (error) {
      favorites[productId] = !favorites[productId]!;
      print('changeFavorites -- ${error.toString()}');
      emit(NewGetFavorietsErrorState(error.toString()));
    }
  }


  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    // emit(NewGetFavorietsLoadingSuccessState());
    DioHelper.getData(url: CATEGORIES_PRODUCTS, token: token).then((value) {
      // print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);
      //focus in this print

      emit(NewGetCategoreSuccessState());
    }).catchError((err) {
      // print(err.toString());
      emit(NewGetCategoreErrorState(err.toString()));
    });
  }

  ShopLoginModel? userModel;

// المفروض  profile  بس
  void getProfileModelData() {
    emit(NewGetProfileLoading());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(NewGetProfileSuccessState(userModel!));
    }).catchError((error) {
      // print(error.toString());
      emit(NewGetProfileDataErrorState(error));
    });
  }

  Future GetUpdateData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(NewGetUpdateDataLoadingSuccessState());
    DioHelper.putData(url: PROFILE_UPDATE, token: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      // print(userModel!.data!.name);
      emit(NewGetUpdateSuccessState(userModel!));
    }).catchError((err) {
      // print(err.toString());
      emit(NewGetUpdateDataErrorState(err.toString()));
    });
  }
}
