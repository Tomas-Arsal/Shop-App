import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/content/content.dart';
import 'package:shop_app/end_points/end_points.dart';
import 'package:shop_app/remote/Dio_helper.dart';
import 'package:shop_app/salla/search/SearchModel.dart';

import 'CubitState.dart';

class NewSearchSallaCubit extends Cubit<NewSearchSallaState> {
  NewSearchSallaCubit() : super(NewInitializeSearchState());

  static NewSearchSallaCubit get(context) => BlocProvider.of(context);
  SearchModel? model;

  void search(String text) {
    emit(NewGetSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(NewGetSearchSuccessState());
    }).catchError((onError) {
      emit(NewGetSearchErrorState(onError.toString()));
    });
  }
}
