import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/shared/network/remote/dio_helper.dart';

import '../../../models/Shop_model/shop_Model.dart';
import '../../../shared/network/endPoint.dart';
part 'shop_login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    @required String? email,
    @required String? password,
})
  {
    emit(ShopLoginloadingStates());
   DioHelper.postData(
       url: login,
       data: {
        'email':email,
         'password':password,
       }
   )?.then((value){
          print(value.data);
          loginModel=ShopLoginModel.fromJeson(value.data);
          emit(ShopLoginSuccessStates(loginModel!));
   }).catchError((error){
     emit(ShopLoginErrorStates(error));
   });
  }


  IconData? suffex;
  bool isPassword=true;

  void ChangePasswordVisability(){
    isPassword= !isPassword;

  suffex=isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;

   emit(ShopLoginPasswordVisapilatyStates());
  }
}

