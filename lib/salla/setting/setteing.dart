import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Component.dart';
import 'package:shop_app/content/content.dart';
import 'package:shop_app/salla/Register/register_cubit/REGISTERCubit.dart';
import 'package:shop_app/salla/cubit/cubitSalla.dart';
import 'package:shop_app/salla/cubit/statesSalla.dart';

class setteing_Screen extends StatefulWidget {
  @override
  State<setteing_Screen> createState() => _setteing_ScreenState();
}

class _setteing_ScreenState extends State<setteing_Screen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SallaCubit, SallaState>(
        listener: (context, state) {},
        builder: (context, state) {
          var Bloc = SallaCubit.get(context);
          var model = SallaCubit.get(context).userModel ;
          nameController.text = model!.data!.name ;
          emailController.text = model.data!.email ;
          phoneController.text = model.data!.phone ;

          return ConditionalBuilder(
            condition: true ,
            // SallaCubit.get(context).userModel != null,
            builder: (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.cyan,
              ),
             body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultTextFormField(
                          controller: nameController,
                          textInputType: TextInputType.name,
                          validate: (String? val) {
                            if (val!.isEmpty) return 'name must not be empty';
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 20.0),
                        defaultTextFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validate: (String? val) {
                            if (val!.isEmpty) return 'email must not be empty';
                          },
                          label: 'Email',
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 20.0),
                        defaultTextFormField(
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          validate: (String? val) {
                            if (val!.isEmpty) return 'phone must not be empty';
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 20.0),
                        defaultButtom(
                          background: Colors.lightBlueAccent,
                          Width: double.infinity,
                          function: () {
                            Bloc.GetUpdateData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text)
                                .then((value) {
                              // Navigator.pop(context);
                            });
                          },
                          text: 'Update',
                        ),
                        const SizedBox(height: 20.0),
                        defaultButtom(
                          background: Colors.lightBlueAccent,
                          Width: double.infinity,
                          function: () {
                            signOut(context) ;
                          },
                          text: 'Log Out',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        });
  }
}
