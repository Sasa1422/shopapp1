part of 'shop_login_cubit.dart';
abstract class ShopLoginState {}

class ShopLoginInitialStates extends ShopLoginState {}

class ShopLoginloadingStates extends ShopLoginState {}

class ShopLoginSuccessStates extends ShopLoginState {
   final ShopLoginModel loginModel;

  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginErrorStates extends ShopLoginState {
   final String? error;
  ShopLoginErrorStates(this.error);
}
class ShopLoginPasswordVisapilatyStates extends ShopLoginState {}


