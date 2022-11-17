import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Component.dart';
import 'package:shop_app/salla/cubit/cubitSalla.dart';
import 'package:shop_app/salla/cubit/statesSalla.dart';
import 'package:shop_app/styles/color.dart';
import '../../styles/my_main.dart';
import '../Categories/CategoriesScreen/CategoriesModels.dart';
import 'homeModel/homeModel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SallaCubit, SallaState>(
      listener: (context, state) {
        if(state is NewChangeFavorietsSuccessState)
        {
          if(!state.model.status)
          {
            showToast(text: 'state.model.message', state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: conditionBuilder(context),
          builder: widgetBuilder,
          fallback: fallbackBuilder,
        );
      },
    );
  }

  Widget fallbackBuilder(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  bool conditionBuilder(BuildContext context) {
    return SallaCubit.get(context).homeModel != null &&
        SallaCubit.get(context).categoriesModel != null;
  }

  Widget widgetBuilder(context) {
    return productsBuilder(
      context,
      SallaCubit.get(context).homeModel,
      SallaCubit.get(context).categoriesModel,
    );
  }

  Widget productsBuilder(
    BuildContext context,
    HomeModel? model,
    CategoriesModel? categoriesModel,
  ) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data.banners.map(
              (e) {
                return Image(
                  image: NetworkImage(e.image),
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: double.infinity,
              color: MyMainColors.myWhite,
              height: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Material(
                    color: MyMainColors.myWhite,
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 100,
                    color: MyMainColors.myWhite,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildCategoryItem(
                        categoriesModel!.data.data[index] , context,
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: categoriesModel!.data.data.length,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Material(
                    color: MyMainColors.myWhite,
                    child: Text(
                      'New Products',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: MyMainColors.myWhite,
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.49,
              children: List.generate(
                model.data.products.length,
                (index) => buildGridHome(
                  model.data.products[index],
                  context,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Stack buildCategoryItem(DataObject model , context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          width: 100,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: MyMainColors.myWhite,
              fontSize: 15.0,
            ),
          ),
        )
      ],
    );
  }

  Container buildGridHome(ProductModel model, context) {
    return Container(
      color: MyMainColors.myWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  color: MyMainColors.myRed,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Discount ${_calculateDiscount(model)}%',
                    style: const TextStyle(
                      fontSize: 8,
                      color: MyMainColors.myWhite,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${model.price.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: MyMainColors.myBlue,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: MyMainColors.myGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    Material(
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        splashRadius: 10.0,
                        iconSize: 30.0,
                        onPressed: () {
                          SallaCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon:  CircleAvatar(
                          backgroundColor: SallaCubit.get(context).favoriets[model.id]! ? CozmoColor2: CozmoColor4,
                          radius: 15,
                          child: const Icon(
                              Icons.favorite_border_rounded,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_calculateDiscount(ProductModel model) {
  dynamic cal = ((model.oldPrice.round() - model.price.round()) /
          model.oldPrice.round()) *
      100;
  return cal.floor();
}
