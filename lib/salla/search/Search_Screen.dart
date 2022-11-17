
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Component.dart';
import 'cubit/Cubit.dart';
import 'cubit/CubitState.dart';

class searchScreen extends StatelessWidget {
  var TextSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewSearchSallaCubit(),
      child: BlocConsumer<NewSearchSallaCubit, NewSearchSallaState>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            var model = NewSearchSallaCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: defaultTextFormField(
                       onchanged: (String text){
                         model.search(text);
                       },
                      controller: TextSearch,
                      textInputType: TextInputType.emailAddress,
                      label: 'Search',
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your search Adress';
                        }
                      },
                      prefix: Icons.search,
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  if(state is NewGetSearchLoadingState)
                  const LinearProgressIndicator() ,
                  if(state is NewGetSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProducts(
                            NewSearchSallaCubit.get(context).model!.data.data[index] , context , isOldPrice: false ),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount:
                        NewSearchSallaCubit.get(context).model!.data.data.length,
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
