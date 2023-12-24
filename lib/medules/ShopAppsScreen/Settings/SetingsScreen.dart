import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/ShopApp_Cupit.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/Shop_AppStates.dart';
import 'package:untitled3/shared/components/componantes.dart';
import 'package:untitled3/shared/network/local/cash_Helper.dart';
import 'package:untitled3/shared/styles/colors.dart';

import '../Login_Shop/shopLogIn.dart';

class SittingsScreen extends StatelessWidget {
  SittingsScreen({super.key});
var formKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessUsersDataState){
          nameController.text=state.loginModel.data!.name!;
          emailController.text=state.loginModel.data!.email!;
          phoneController.text=state.loginModel.data!.phone!;

        }
      },
      builder: (context, state) {
        var model=ShopCupit.get(context).userModel;

        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;

        return ConditionalBuilder(
          condition:ShopCupit.get(context).userModel !=null ,
          builder: (context)=>SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUsersDataState)
                    const LinearProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: defoultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (value) {
                            if (value == null) {
                              return 'enter your name please';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defoultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null) {
                              return 'enter your email please';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                      child: defoultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value == null) {
                              return 'enter your phone please';
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone
                      ),
                    ),
                    defoultButton(
                        width: 200,
                        background: defaultColor,
                        onPressed: (){
                          CachHelper.removeData(key: 'token').then((value) {
                            navigateAndFinsh(
                                context,
                                shopLoginScreen()
                            );
                          });

                        },
                        text: 'SIGNOUT'
                    ),
                    SizedBox(height: 20,),
                    defoultButton(
                        width: 200,
                        background: defaultColor,
                        onPressed: (){
                          if(formKey.currentState!.validate()) {
                            ShopCupit.get(context).UpdateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        text: 'UPDATE '
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
