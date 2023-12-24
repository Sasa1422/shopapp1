import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/Shop_AppStates.dart';
import 'package:untitled3/medules/ShopAppsScreen/Categores_Screen/categoresScreen.dart';
import 'package:untitled3/medules/ShopAppsScreen/Favorets_Screen/favoretsScreen.dart';
import 'package:untitled3/medules/ShopAppsScreen/Settings/SetingsScreen.dart';
import 'package:untitled3/medules/ShopAppsScreen/productes_Screen/productsScreen.dart';
import 'package:untitled3/models/Shop_model/HomeModel.dart';
import 'package:untitled3/models/Shop_model/categories_model.dart';
import 'package:untitled3/models/Shop_model/shop_Model.dart';
import 'package:untitled3/shared/components/constantes.dart';
import 'package:untitled3/shared/network/endPoint.dart';
import 'package:untitled3/shared/network/remote/dio_helper.dart';

import '../../../models/Shop_model/FavoretModel.dart';
import '../../../models/Shop_model/changeFavoretModel.dart';

class ShopCupit extends Cubit<ShopStates>
{
  ShopCupit():super(intialShopState());

  static ShopCupit get(context)=>BlocProvider.of(context);

  int curentIndex=0;

  List<Widget> Screens=
      [
        ProductesScreen(),
        CategoresScreen(),
        FavoretsScreen(),
        SittingsScreen(),
      ];

  void ChangeShopBottomNavBar(int index){
    curentIndex=index;
    emit(changeShopBottomNavBarState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favorits={};

 void getHomData()
 {
  emit(ShopLoadingHomeDataState());

  DioHelper.getData(
      url: Home,
      token: token,
  )?.then((value){

    homeModel=HomeModel.forJeson(value?.data);
    print(homeModel?.data?.banners[1].id);
       homeModel?.data?.products.forEach((element)
       {
       favorits.addAll({
         element.id:element.infavorites,
       });
       });
    print('============================================================================');
    print(favorits.toString());
    print('============================================================================');

    emit(ShopSuccessHomeDataState());

  }).catchError((error)
  {
    print(error.toString());
   emit(ShopErrorHomeDataState()) ;

  });

 }

  CategoriesModel? categoriesModel;

  void getCategoriesData()
  {

    DioHelper.getData(
      url: Categories,
      token: token,
    )?.then((value){

      categoriesModel=CategoriesModel.FormJeson(value?.data);
      print('============================================================================');

      print('============================================================================');

      emit(ShopSuccessCategoriesDataState());

    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesDataState()) ;

    });

  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int? productId)
  {
    favorits[productId]= !favorits[productId]!;
    emit(ShopChangeFavoretsDataState());

    DioHelper.postData(
      url: Favoritrs,
      data: {
        'product_id':productId
      },
    token: token,
  )!.then((value){
    changeFavoritesModel=ChangeFavoritesModel.FormJeson(value.data);
    print(value.data);
    if(changeFavoritesModel!.status==false){
      favorits[productId]= !favorits[productId]!;

    }else{
      getFavoritesData();
    }
    emit(ShopSuccessFavoretsChangeState(changeFavoritesModel!));

  }).catchError((error){
    emit(ShopErrorFavoretsChangeState());
  });

  }

  FavoritesModel? favoritesModel;

  void getFavoritesData()
  {
    emit(ShopLoadingFavoritesDataState());

    DioHelper.getData(
      url: Favoritrs,
      token: token,
    )?.then((value){

      favoritesModel=FavoritesModel.fromJson(value?.data);
      print('============================================================================');

      print('============================================================================');

      emit(ShopSuccessFavoritesDataState());

    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorFavoritesDataState()) ;

    });

  }

  ShopLoginModel? userModel;

  void getUserData()
  {
    emit(ShopLoadingUsersDataState());

    DioHelper.getData(
      url: Profile,
      token: token,
    )?.then((value){
      userModel=ShopLoginModel.fromJeson(value?.data);
      emit(ShopSuccessUsersDataState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUsersDataState()) ;
    });

  }



  void UpdateUserData({
    @required String? name,
    @required String? email,
    @required String? phone,

  })
  {
    emit(ShopLoadingUpdateUsersDataState());

    DioHelper.putData(
      url: Update,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,


      }
    )?.then((value){
      userModel=ShopLoginModel.fromJeson(value.data);
      emit(ShopSuccessUpdateUsersDataState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateUsersDataState()) ;
    });

  }


}