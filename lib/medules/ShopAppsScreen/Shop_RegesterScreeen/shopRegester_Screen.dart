import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/medules/ShopAppsScreen/Shop_RegesterScreeen/Register_cubit/shop_login_cubit.dart';

import '../../../layout/Shop_App/shopLayoutScreen.dart';
import '../../../shared/components/componantes.dart';
import '../../../shared/components/constantes.dart';
import '../../../shared/network/local/cash_Helper.dart';
import '../../../shared/styles/colors.dart';
import '../Login_Shop/shop_login_cubit.dart';

class shopRegisterScreen extends StatelessWidget {
   shopRegisterScreen({super.key});
var formKey=GlobalKey<FormState>();
var nameController=TextEditingController();
   var emailController=TextEditingController();
   var passwordController=TextEditingController();
   var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => ShopRegisterCubit(),
  child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
  listener: (context, state) {
    if(state is ShopRegisterSuccessStates){
      if(state.loginModel.status!){
        print(state.loginModel.message);
        print(state.loginModel.data!.token);

        CachHelper.saveData(
            key: 'token',
            value: state.loginModel.data!.token
        ).then((value) {
          token=state.loginModel.data!.token;
          navigateAndFinsh(context, const shopLayoutScreen());
        });
      }else{
        print(state.loginModel.message);
        showToast(
          text: '${state.loginModel.message}',
          state:ToastStates.ERROR,
        );
      }
    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'REGISTER',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'register now to our hot offers',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 30,),
                  defoultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validator: (String? value){
                      if(value!.isEmpty){
                        print('please enter your name address');
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(height: 20,),

                  defoultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validator: (String? value){
                      if(value!.isEmpty){
                        print('please enter your email address');
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email_outlined,

                  ),
                  SizedBox(height: 15,),
                  defoultFormField(
                      controller: passwordController,
                      type: TextInputType.number,
                      ispassword: //ShopLoginCubit.get(context).isPassword,

                                       true,
                      validator: (String? value){
                        if(value!.isEmpty){
                          print('Pasword is to short');
                        }
                        return null;
                      },
                      label: 'Pasword',
                      prefix: Icons.lock_outline,
                      suffix: Icons.visibility_outlined,
                      suffixpressed: (){
                        ShopRegisterCubit.get(context).ChangePasswordVisability();
                      },
                      onSubmit: (value){
                        if(formKey.currentState!.validate()){
                          ShopRegisterCubit.get(context).userRegister(
                            name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text
                          );
                       }
                      }
                  ),
                  SizedBox(height: 20,),
                  defoultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validator: (String? value){
                      if(value!.isEmpty){
                        print('please enter your phone address');
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,

                  ),
                  const SizedBox(height: 15,),
                  ConditionalBuilder(
                      condition: state is! ShopRegisterloadingStates ,
                      builder: (context)=>defoultButton(
                          width: double.infinity,
                          background: defaultColor,
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                   phone: phoneController.text,
                              );
                            }

                          },
                          text: 'REGISTER'
                      ),
                      fallback: (context)=>const Center(child: CircularProgressIndicator())),
                  const SizedBox(height: 15,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}
