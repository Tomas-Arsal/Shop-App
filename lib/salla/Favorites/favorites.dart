import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/salla/Categories/CategoriesScreen/CategoriesModels.dart';
import 'package:shop_app/salla/Favorites/FavoritsModel.dart';
import 'package:shop_app/styles/my_main.dart';
import '../../Component.dart';
import '../cubit/cubitSalla.dart';
import '../cubit/statesSalla.dart';

class Favorites_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SallaCubit, SallaState>(
      listener: (context, state) {},
      builder: (context, state) {
         print(SallaCubit.get(context).favoritesModel);
        return ConditionalBuilder(
            condition: state is! NewGetFavorietsLoadingSuccessState,
            builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildListProducts(
                      SallaCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data[index]
                          .product,
                      context),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount:
                      SallaCubit.get(context).favoritesModel!.data!.data.length,
                ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
