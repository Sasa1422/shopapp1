import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/shared/network/remote/dio_helper.dart';

import '../../../../models/Shop_model/shop_Model.dart';
import '../../../../shared/network/endPoint.dart';
part 'shop_login_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userRegister({
    @required String? email,
    @required String? password,
    @required String? name,
    @required String? phone,

  })
  {
    emit(ShopRegisterloadingStates());
   DioHelper.postData(
       url: Register,
       data: {
        'email':email,
         'password':password,
         'name':name,
         'phone':phone,


       }
   )?.then((value){
          print(value.data);
          loginModel=ShopLoginModel.fromJeson(value.data);
          emit(ShopRegisterSuccessStates(loginModel!));
   }).catchError((error){
     emit(ShopRegisterErrorStates(error));
   });
  }


  IconData? suffex;
  bool isPassword=true;

  void ChangePasswordVisability(){
    isPassword= !isPassword;

  suffex=isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;

   emit(ShopRegisterPasswordVisapilatyStates());
  }
}

