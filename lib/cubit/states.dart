import '../user_model/user_model.dart';

abstract class shopStates {}

 class shopInitialState extends  shopStates{}

 class shopLoginLoadingState extends  shopStates{}

 class shopLoginSuccessState extends  shopStates{
 late final ShopLoginModel shopLoginModel ;
shopLoginSuccessState(this.shopLoginModel) ;

 }

 class shopLoginErrorState extends  shopStates{

  final String error ;
  shopLoginErrorState(this.error) ;
}
