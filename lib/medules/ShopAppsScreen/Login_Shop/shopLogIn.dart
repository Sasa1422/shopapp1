import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled3/layout/Shop_App/shopLayoutScreen.dart';
import 'package:untitled3/medules/ShopAppsScreen/Login_Shop/shop_login_cubit.dart';
import 'package:untitled3/medules/ShopAppsScreen/Shop_RegesterScreeen/shopRegester_Screen.dart';
import 'package:untitled3/shared/components/constantes.dart';
import 'package:untitled3/shared/network/local/cash_Helper.dart';

import '../../../shared/components/componantes.dart';
import '../../../shared/styles/colors.dart';

class shopLoginScreen extends StatelessWidget {
   shopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var emailController=TextEditingController();
    var paswordConyroller=TextEditingController();
    return  BlocProvider(
  create: (BuildContext context) => ShopLoginCubit(),
  child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
  listener: (context, state) {
    if(state is ShopLoginSuccessStates){
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
                    'LOGIN',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'Login now to our hot offers',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 30,),
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
                    controller: paswordConyroller,
                    type: TextInputType.number,
                    ispassword: ShopLoginCubit.get(context).isPassword,


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
                      ShopLoginCubit.get(context).ChangePasswordVisability();
                    },
                    onSubmit: (value){
                      if(formKey.currentState!.validate()){
                        ShopLoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: paswordConyroller.text);
                      }
                    }
                  ),
                  const SizedBox(height: 15,),
                  ConditionalBuilder(
                      condition: State is! ShopLoginloadingStates,
                      builder: (context)=>defoultButton(
                          width: double.infinity,
                          background: defaultColor,
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: paswordConyroller.text);
                            }

                          },
                          text: 'login'
                      ),
                      fallback: (context)=>const Center(child: CircularProgressIndicator())),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t Have An Account?'
                      ),
                      defoultTextButton(

                          onPressed: (){
                           navigateTo(context,  shopRegisterScreen());
                          }
                          , text: 'register'
                      ),
                    ],
                  )
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
