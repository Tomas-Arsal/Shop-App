import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/local/cashHelper.dart';
import 'package:shop_app/salla/Register/registerScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/shopLayout.dart';
import 'Component.dart';
import 'content/content.dart';

class loginScreenShop extends StatefulWidget {
  @override
  State<loginScreenShop> createState() => _loginScreenShopState();
}

class _loginScreenShopState extends State<loginScreenShop> {
  var formKey = GlobalKey<FormState>();

  var textLogin = TextEditingController();
  var passwordLogin = TextEditingController();
  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopLoginCubit(),
      child: BlocConsumer<shopLoginCubit, shopStates>(
        listener: (context, state) {
          if (state is shopLoginSuccessState) {
            if (state.shopLoginModel.status) {
              print(state.shopLoginModel.message);
              print(state.shopLoginModel.data?.token);

              showToast(
                  text: state.shopLoginModel.message,
                  state: ToastState.SUCCESS);
              CashHelper.saveData(
                key: 'token',
                value: state.shopLoginModel.data?.token,
              ).then((value) {
                token = state.shopLoginModel.data?.token;

                navigateTo(context, shopLayout());
              });
            } else {
              print(state.shopLoginModel.message);
              showToast(
                  text: state.shopLoginModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Login now to browse',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFormField(
                      controller: textLogin,
                      textInputType: TextInputType.emailAddress,
                      label: 'Email Adress',
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email Adress';
                        }
                      },
                      prefix: Icons.email,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultTextFormField(
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Email Adress';
                          }
                          return null;
                        },
                        prefix: Icons.lock,
                        label: 'Password Adress',
                        textInputType: TextInputType.phone,
                        controller: passwordLogin,
                        suffix: isPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        isPassword: isPassword,
                        suffixPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: ConditionalBuilder(
                        condition: true,
                        builder: (BuildContext context) =>
                            ////////////////////////////////////
                            defaultButtom(
                          background: Colors.black12,
                          Width: double.infinity,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              shopLoginCubit.get(context).userLogin(
                                    email: textLogin.text,
                                    password: passwordLogin.text,
                                  );
                              navigateTo(context, shopLayout());
                            }
                          },
                          text: 'Login',
                        ),
                        fallback: (BuildContext context) =>
                            const CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Row(
                        children: [
                          const Text(
                            'Do not have an account ?',
                          ),
                          textButtom(
                              text: 'Register',
                              function: () {
                                navigateTo(context, RegisterScreen());
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
