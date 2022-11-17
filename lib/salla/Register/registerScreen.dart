import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Component.dart';
import 'package:shop_app/local/cashHelper.dart';
import 'package:shop_app/salla/Register/register_cubit/REGISTERCubit.dart';
import 'package:shop_app/salla/Register/register_cubit/registerStates.dart';
import 'package:shop_app/shopLayout.dart';

import '../../content/content.dart';
import '../cubit/cubitSalla.dart';
import '../cubit/statesSalla.dart';

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is SuccessRegister) {
          if (state.loginModel.status) {
            showToast(
                text: state.loginModel.message, state: ToastState.SUCCESS);
            CashHelper.saveData(
              key: 'token',
              value: state.loginModel.data?.token,
            ).then((value) {
              token = state.loginModel.data?.token;

              navigateTo(context, shopLayout());
            });
          } else {
            print(state.loginModel.message);
            showToast(text: state.loginModel.message, state: ToastState.ERROR);
          }
        }
      }, builder: (context, state) {
        var Bloc1 = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is NewGetUpdateDataLoadingSuccessState)
                      const SizedBox(height: 20.0,) ,

                    const LinearProgressIndicator() ,
                    const SizedBox(height: 20.0,) ,
                    defaultTextFormField(
                        controller: nameController,
                        textInputType: TextInputType.name,
                        validate: (String? val) {
                          if (val!.isEmpty) return 'name must not be empty';
                        },
                        label: 'Name',
                        prefix: Icons.person,
                        suffixPressed: (val) {
                          if (formKey.currentState!.validate()) {
                            Bloc1.PostData(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                          }
                        }),
                    const SizedBox(height: 20.0),
                    defaultTextFormField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      validate: (String? val) {
                        if (val!.isEmpty) return 'email must not be empty';
                      },
                      label: 'Email',
                      prefix: Icons.email,
                        suffixPressed: (val) {
                          if (formKey.currentState!.validate()) {
                            Bloc1.PostData(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                          }
                        }),

                    const SizedBox(height: 20.0),
                    defaultTextFormField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      validate: (String? val) {
                        if (val!.isEmpty) return 'phone must not be empty';
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                        suffixPressed: (val) {
                          if (formKey.currentState!.validate()) {
                            Bloc1. PostData(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                          }
                        }),
                    const SizedBox(height: 20.0),
                    defaultTextFormField(
                      controller: passwordController,
                      textInputType: TextInputType.phone,
                      validate: (String? val) {
                        if (val!.isEmpty) return 'Password must not be empty';
                      },
                      label: 'Password',
                      prefix: Icons.password,
                        suffixPressed: (val) {
                          if (formKey.currentState!.validate()) {
                            Bloc1.PostData(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                          }
                        }),
                    const SizedBox(height: 20.0),
                    defaultButtom(
                      background: Colors.lightBlueAccent,
                      Width: double.infinity,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          Bloc1.PostData(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text);
                        }
                      },
                      text: 'Regeister',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/*
*TextButton(
          onPressed: () {
            CashHelper.removeCacheData(key: 'token').then((value) {
              if (value) {
                navigateAndFinished(context, shopLayout());
              }
            });
          },
          child: Text('Sign Out'),
        ),
    );*/
