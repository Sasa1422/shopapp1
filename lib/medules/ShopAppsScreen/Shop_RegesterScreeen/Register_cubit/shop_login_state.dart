part of 'shop_login_cubit.dart';
abstract class ShopRegisterState {}

class ShopRegisterInitialStates extends ShopRegisterState {}

class ShopRegisterloadingStates extends ShopRegisterState {}

class ShopRegisterSuccessStates extends ShopRegisterState {
   final ShopLoginModel loginModel;

  ShopRegisterSuccessStates(this.loginModel);
}

class ShopRegisterErrorStates extends ShopRegisterState {
   final String? error;
  ShopRegisterErrorStates(this.error);
}
class ShopRegisterPasswordVisapilatyStates extends ShopRegisterState {}


