import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/salla/cubit/cubitSalla.dart';
import 'package:shop_app/styles/my_main.dart';

Widget defaultButtom({
  required background,
  required Width,
  double radious = 10.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: Width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radious),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required String label,
  required validate,
  ontap,
  onchanged,
  required IconData prefix,
  IconData? suffix,
  suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
      validator: validate,
      onTap: ontap,
      onChanged: onchanged,
    );

// Widget buildMenuItem(Map model, context) => Dismissible(
//       key: Key(model['id'].toString()),
//       child: Container(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.only(
//             top: 40.0,
//             left: 30.0,
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 radius: 30,
//                 backgroundColor: Colors.blue,
//                 child: Text(
//                   '${model['time']}',
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 10.0,
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       '${model['title']}',
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                     Text(
//                       '${model['data']}',
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 5.0,
//               ),
//               IconButton(
//                 onPressed: () {
//                   AppCubit.get(context).updateData(
//                     status: 'check',
//                     id: model['id'],
//                   );
//                 },
//                 icon: Icon(Icons.check),
//               ),
//               IconButton(
//                 onPressed: () {
//                   AppCubit.get(context).updateData(
//                     status: 'archive',
//                     id: model['id'],
//                   );
//                 },
//                 icon: Icon(Icons.archive),
//               ),
//             ],
//           ),
//         ),
//       ),
//       onDismissed: (Direction) {
//         AppCubit.get(context).deleteData(id: model['id']);
//       },
//     );
//
// Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
//       condition: tasks.length > 0,
//       builder: (context) => ListView.separated(
//         itemBuilder: (context, index) => buildMenuItem(tasks[index], context),
//         separatorBuilder: (context, index) => separatorBuilderItem() ,
//         itemCount: tasks.length,
//       ),
//       fallback: (context) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(
//               Icons.menu,
//               size: 100.0,
//               color: Colors.grey,
//             ),
//             Text(
//               'No Tasks Yet , Please Add Some Tasks',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.w900,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//
// Widget buildArticleItem (article , context) => InkWell(
//   onTap: (){
//   navigateTo(context , webSiteScreen(article['url'])) ;
//   },
//   child:   Padding(
//
//     padding: const EdgeInsets.all(10.0),
//
//     child: Row(
//
//       crossAxisAlignment: CrossAxisAlignment.start,
//
//       children: [
//
//         Container(
//
//           width: 120.0,
//
//           height: 120.0,
//
//           decoration: BoxDecoration(
//
//             borderRadius: BorderRadius.circular(10.0),
//
//             image:  DecorationImage(
//
//               image: NetworkImage(
//
//                 '${article['urlToImage']}',
//
//               ),
//
//               fit: BoxFit.cover,
//
//             ),
//
//           ),
//
//         ),
//
//         const SizedBox(
//
//           width: 10.0,
//
//         ),
//
//         Expanded(
//
//           child: Column(
//
//             crossAxisAlignment: CrossAxisAlignment.start,
//
//             children:  [
//
//               Text(
//
//                 '${article['title']}',
//
//                 style: Theme.of(context).textTheme.bodyText1 ,
//
//               ),
//
//               const SizedBox(
//
//                 height: 5.0,
//
//               ),
//
//
//
//                   Text(
//
//                   '${article['publishedAt']}',
//
//                   style:  const TextStyle(
//
//                     color: Colors.black,
//
//                     fontWeight: FontWeight.w900,
//
//                   ),
//
//                   maxLines: 4,
//
//                   overflow: TextOverflow.ellipsis,
//
//                 ),
//
//
//
//             ],
//
//           ),
//
//         ),
//
//       ],
//
//     ),
//
//   ),
// );
//
//
// Widget separatorBuilderItem () => Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Container(
//     color: Colors.brown,
//     height: 5.0,
//   ),
// ) ;
//
// Widget articleBuilder(list , context) => ConditionalBuilder(
//   condition: list.length > 0,
//   builder: (context) =>
//       ListView.separated(
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) =>
//             buildArticleItem(list[index] , context),
//         separatorBuilder: (context, index) => separatorBuilderItem(),
//         itemCount: list.length,
//       ),
//   fallback: (context) =>
//   const Center(child: CircularProgressIndicator()),
// );

void navigateTo(context, Widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Widget),
  );
}

void navigateAndFinished(context, Widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (Route<dynamic> route) => false);
}

Widget textButtom({
  required String text,
  required function,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
        ));

Future<bool?> showToast({required String text, required ToastState state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

// تستخدم لتحديد حاله ال TOAST
enum ToastState { SUCCESS, ERROR, WERNING }

Color ToastColorState(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WERNING:
      color = Colors.yellow;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildListProducts(model, context, {bool isOldPrice = true}) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            if (model.discount != 0 && isOldPrice)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  color: MyMainColors.myRed,
                  child: const Text(
                    'DISTANT',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Material(
                          child: Text(
                            model.price.toString(),
                            style: const TextStyle(
                                fontSize: 10.0, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Material(
                            child: Text(
                              model.oldPrice.toString(),
                              style: const TextStyle(
                                  fontSize: 10.0, color: Colors.red),
                            ),
                          ),
                        const Spacer(),
                        Material(
                            color: MyMainColors.myWhite,
                            child: IconButton(
                              icon: const Icon(Icons.favorite),
                              onPressed: () {
                                // SallaCubit.get(context).changeFavoriteModel(model.id);
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
