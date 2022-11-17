import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/salla/Categories/CategoriesScreen/CategoriesModels.dart';
import 'package:shop_app/salla/cubit/cubitSalla.dart';
import 'package:shop_app/salla/cubit/statesSalla.dart';

class categories_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SallaCubit, SallaState>(
      listener: (context, state) {},
      builder: (context, state) {
        return builder(context);
      },
    );
  }

  ListView builder(context) {
     print(SallaCubit.get(context).categoriesModel);
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => _buildCategoryItem(
        SallaCubit.get(context).categoriesModel!.data.data[index],
      ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: SallaCubit.get(context).categoriesModel!.data.data.length,
    );
  }

  Padding _buildCategoryItem(DataObject model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
