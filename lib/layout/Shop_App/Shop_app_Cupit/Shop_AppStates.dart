import 'package:untitled3/models/Shop_model/changeFavoretModel.dart';
import 'package:untitled3/models/Shop_model/shop_Model.dart';

abstract class ShopStates{}

class intialShopState  extends ShopStates{}

class changeShopBottomNavBarState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{}

class ShopSuccessFavoretsChangeState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessFavoretsChangeState(this.model);
}

class ShopErrorFavoretsChangeState extends ShopStates{}

class ShopChangeFavoretsDataState extends ShopStates{}

class ShopLoadingFavoritesDataState extends ShopStates{}

class ShopSuccessFavoritesDataState extends ShopStates{}

class ShopErrorFavoritesDataState extends ShopStates{}

class ShopLoadingUsersDataState extends ShopStates{}

class ShopSuccessUsersDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUsersDataState(this.loginModel);
}

class ShopErrorUsersDataState extends ShopStates{}

class ShopLoadingUpdateUsersDataState extends ShopStates{}

class ShopSuccessUpdateUsersDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUsersDataState(this.loginModel);
}

class ShopErrorUpdateUsersDataState extends ShopStates{}
