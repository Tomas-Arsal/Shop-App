import 'package:shop_app/salla/Favorites/FavoritsModel.dart';
import 'package:shop_app/salla/Favorites/change_favorite_model.dart';
import 'package:shop_app/user_model/user_model.dart';

abstract class SallaState {}

class NewInisialState extends SallaState {}

class NewBottomNavState extends SallaState {}

class NewGetHomeLoadingSuccessState extends SallaState {}

class NewGetHomeSuccessState extends SallaState {}

class NewGetHomeErrorState extends SallaState {
  final String error;

  NewGetHomeErrorState(this.error);
}

class NewGetCategoreLoadingSuccessState extends SallaState {}

class NewGetCategoreSuccessState extends SallaState {}

class NewGetCategoreErrorState extends SallaState {
  final String error;
  NewGetCategoreErrorState(this.error);
}

class NewChangeFavorietsLoadingSuccessState extends SallaState {
}

class NewChangeFavorietsSuccessState extends SallaState {
  final ChangeFavoriteModel model;

  NewChangeFavorietsSuccessState(this.model);


}

class NewChangeFavorietsErrorState extends SallaState {
  final String error;

  NewChangeFavorietsErrorState(this.error);
}

class NewGetFavorietsLoadingSuccessState extends SallaState {}

class NewGetFavorietsSuccessState extends SallaState {}

class NewGetFavorietsErrorState extends SallaState {
  final String error;

  NewGetFavorietsErrorState(this.error);
}

class NewGetUserDataLoadingSuccessState extends SallaState {}

class NewGetUserSuccessState extends SallaState {}

class NewGetUserDataErrorState extends SallaState {
  final String error;

  NewGetUserDataErrorState(this.error);
}


class NewGetProfileLoading extends SallaState {

}

class NewGetProfileSuccessState extends SallaState {
  final ShopLoginModel model;

  NewGetProfileSuccessState(this.model);


}

class NewGetProfileDataErrorState extends SallaState {
  final String error;

  NewGetProfileDataErrorState(this.error);
}


class NewGetUpdateDataLoadingSuccessState extends SallaState {

}

class NewGetUpdateSuccessState extends SallaState {
  final ShopLoginModel model;

  NewGetUpdateSuccessState(this.model);


}

class NewGetUpdateDataErrorState extends SallaState {
  final String error;

  NewGetUpdateDataErrorState(this.error);
}
