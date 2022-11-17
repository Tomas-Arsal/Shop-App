import 'package:shop_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/remote/Dio_helper.dart';
import 'package:shop_app/user_model/user_model.dart';

import '../end_points/end_points.dart';

class shopLoginCubit extends Cubit<shopStates>
{
shopLoginCubit() : super(shopLoginLoadingState()) ;
static shopLoginCubit get(cotext) => BlocProvider.of(cotext) ;

ShopLoginModel? shopLoginModel ;
void userLogin ({
  required String email ,
  required String password ,

}){
  emit(shopLoginLoadingState()) ;
  DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
     ).then((value) {
       print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data) ;
       emit(shopLoginSuccessState(shopLoginModel!));
  }).catchError((error){
    emit(shopLoginErrorState(error.toString()));
  });
}
}